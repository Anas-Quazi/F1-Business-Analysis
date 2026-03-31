--! ============================================
--! Window Function Analysis
--! ============================================

--& 1. Cumulative sponsorship revenue across teams
SELECT
    team_name,
    total_sponsorship_revenue,
    SUM(total_sponsorship_revenue) OVER (ORDER BY total_sponsorship_revenue DESC) AS cumulative_revenue,
    ROUND(SUM(total_sponsorship_revenue) OVER (ORDER BY total_sponsorship_revenue DESC) /
        SUM(total_sponsorship_revenue) OVER () * 100, 2) AS cumulative_market_share_pct
FROM sponsorship_revenue
ORDER BY total_sponsorship_revenue DESC;

--* 2. Percentile ranking of teams across multiple metrics
SELECT
    tf.team_name,
    RANK() OVER (ORDER BY sr.total_sponsorship_revenue DESC) AS sponsorship_rank,
    RANK() OVER (ORDER BY tf.total_expenses DESC) AS expense_rank,
    RANK() OVER (ORDER BY tf.net_profit DESC) AS profit_rank,
    NTILE(4) OVER (ORDER BY tf.net_profit DESC) AS profit_quartile
FROM team_finances tf
JOIN sponsorship_revenue sr ON tf.constructor_id = sr.constructor_id;

--todo 3. Top 5 most valuable partnerships (deal value x contract length)
SELECT
    sponsor_name,
    deal_value_million,
    contract_start,
    contract_end,
    (contract_end - contract_start) AS contract_duration,
    ROUND(deal_value_million * (contract_end - contract_start), 2) AS total_contract_value
FROM (
    SELECT sponsor_name, deal_value_million, contract_start, contract_end FROM title_sponsors
    UNION ALL
    SELECT sponsor_name, deal_value_million, contract_start, contract_end FROM principal_partners
    UNION ALL
    SELECT partner_name, deal_value_million, contract_start, contract_end FROM team_partners
) AS all_sponsors
WHERE contract_end IS NOT NULL
ORDER BY total_contract_value DESC
LIMIT 5;

--~ 4. Year-over-year simulation based on contract years
SELECT
    team_name,
    sponsor_name,
    deal_value_million,
    contract_start,
    contract_end,
    (contract_end - contract_start) AS contract_years,
    deal_value_million * (contract_end - contract_start) AS total_contract_value,
    SUM(deal_value_million) OVER (PARTITION BY team_name ORDER BY contract_start) AS cumulative_revenue_by_year
FROM (
    SELECT c.team_name, ts.sponsor_name, ts.deal_value_million, ts.contract_start, ts.contract_end
    FROM title_sponsors ts JOIN constructors c ON ts.constructor_id = c.constructor_id
    UNION ALL
    SELECT c.team_name, pp.sponsor_name, pp.deal_value_million, pp.contract_start, pp.contract_end
    FROM principal_partners pp JOIN constructors c ON pp.constructor_id = c.constructor_id
) AS sponsor_timeline
WHERE contract_end IS NOT NULL
ORDER BY team_name, contract_start;

--^ 5. Teams with strongest supplier ecosystem (engine + fuel + tyre)
SELECT
    c.team_name,
    es.supplier_name AS engine_supplier,
    fs.supplier_name AS fuel_supplier,
    ts.supplier_name AS tyre_supplier,
    ec.supply_fee_million AS engine_fee,
    fs.supply_fee_million AS fuel_fee,
    ts.supply_fee_per_team_million AS tyre_fee,
    (COALESCE(ec.supply_fee_million, 0) +
     COALESCE(fs.supply_fee_million, 0) +
     COALESCE(ts.supply_fee_per_team_million, 0)) AS total_supplier_cost,
    RANK() OVER (ORDER BY (COALESCE(ec.supply_fee_million, 0) +
     COALESCE(fs.supply_fee_million, 0) +
     COALESCE(ts.supply_fee_per_team_million, 0)) DESC) AS supplier_investment_rank
FROM constructors c
JOIN engine_supply_contracts ec ON c.constructor_id = ec.constructor_id AND ec.is_external = TRUE
JOIN engine_suppliers es ON ec.supplier_id = es.supplier_id
JOIN engine_suppliers eng ON c.engine_supplier_id = eng.supplier_id
JOIN fuel_suppliers fs ON eng.fuel_supplier_id = fs.supplier_id
JOIN tyre_suppliers ts ON c.tyre_supplier_id = ts.supplier_id
ORDER BY total_supplier_cost DESC;

--? 6. Potential merger/acquisition value: high sponsorship but low profit
SELECT
    tf.team_name,
    sr.total_sponsorship_revenue,
    tf.net_profit,
    c.constructor_budget_million AS estimated_team_value,
    ROUND(sr.total_sponsorship_revenue / NULLIF(tf.net_profit, 0), 2) AS revenue_to_profit_ratio,
    CASE
        WHEN sr.total_sponsorship_revenue > 150 AND tf.net_profit < 20 THEN 'Prime Acquisition Target'
        WHEN sr.total_sponsorship_revenue > 100 AND tf.net_profit < 0 THEN 'High Value Turnaround'
        WHEN sr.total_sponsorship_revenue > 80 AND tf.net_profit < 50 THEN 'Moderate Opportunity'
        ELSE 'Not a Priority Target'
    END AS acquisition_attractiveness
FROM team_finances tf
JOIN sponsorship_revenue sr ON tf.constructor_id = sr.constructor_id
JOIN constructors c ON tf.constructor_id = c.constructor_id
ORDER BY sr.total_sponsorship_revenue DESC, tf.net_profit;

--todo Governing body vs team sponsor comparison
SELECT
    'F1 Global Partners' AS level,
    COUNT(*) AS total_partners,
    SUM(deal_value_million) AS total_revenue,
    ROUND(AVG(deal_value_million), 2) AS avg_deal
FROM global_partners
UNION ALL
SELECT
    'Official Suppliers',
    COUNT(*),
    SUM(deal_value_million),
    ROUND(AVG(deal_value_million), 2)
FROM official_suppliers
UNION ALL
SELECT
    'All Team Sponsors',
    COUNT(*),
    SUM(deal_value_million),
    ROUND(AVG(deal_value_million), 2)
FROM (
    SELECT deal_value_million FROM title_sponsors
    UNION ALL
    SELECT deal_value_million FROM principal_partners
    UNION ALL
    SELECT deal_value_million FROM team_partners
) AS team_sponsors
ORDER BY total_revenue DESC;

--* Dream team revenue projection: what if top sponsor moved to another team
SELECT
    c.team_name AS target_team,
    tf.total_revenue AS current_revenue,
    ts.deal_value_million AS top_sponsor_value,
    tf.total_revenue + ts.deal_value_million AS projected_revenue,
    ts.sponsor_name AS top_sponsor_name,
    RANK() OVER (ORDER BY tf.total_revenue + ts.deal_value_million DESC) AS projected_rank
FROM team_finances tf
JOIN constructors c ON tf.constructor_id = c.constructor_id
JOIN (
    SELECT constructor_id, sponsor_name, deal_value_million,
           ROW_NUMBER() OVER(PARTITION BY constructor_id ORDER BY deal_value_million DESC) as rn
    FROM title_sponsors
) ts ON c.constructor_id = ts.constructor_id AND ts.rn = 1
ORDER BY projected_revenue DESC;
