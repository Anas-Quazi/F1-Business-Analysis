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
