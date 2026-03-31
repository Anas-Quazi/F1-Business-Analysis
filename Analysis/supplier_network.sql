--! ============================================
--! Supplier & Partnership Network
--! ============================================

--* 1. Engine supplier market share and revenue
SELECT
    es.supplier_name,
    COUNT(ec.constructor_id) AS teams_supplied,
    SUM(CASE WHEN ec.is_external = TRUE THEN ec.supply_fee_million ELSE 0 END) AS external_revenue,
    ROUND((COUNT(ec.constructor_id) / (SELECT COUNT(*) FROM constructors)) * 100, 2) AS market_share_pct
FROM engine_suppliers es
JOIN engine_supply_contracts ec ON es.supplier_id = ec.supplier_id
GROUP BY es.supplier_name
ORDER BY teams_supplied DESC;

--& 2. Teams paying highest engine supply fees
SELECT
    c.team_name,
    es.supplier_name AS engine_supplier,
    ec.supply_fee_million,
    ec.is_external
FROM engine_supply_contracts ec
JOIN constructors c ON ec.constructor_id = c.constructor_id
JOIN engine_suppliers es ON ec.supplier_id = es.supplier_id
WHERE ec.is_external = TRUE
ORDER BY ec.supply_fee_million DESC;

--^ 3. Sponsors partnering with multiple teams (brand diversification)
SELECT
    sponsor_name,
    COUNT(DISTINCT constructor_id) AS teams_count,
    SUM(deal_value_million) AS total_f1_investment
FROM (
    SELECT sponsor_name, constructor_id, deal_value_million FROM title_sponsors
    UNION ALL
    SELECT sponsor_name, constructor_id, deal_value_million FROM principal_partners
    UNION ALL
    SELECT partner_name, constructor_id, deal_value_million FROM team_partners
) AS all_sponsors
GROUP BY sponsor_name
HAVING teams_count > 1
ORDER BY teams_count DESC, total_f1_investment DESC;

--~ 4. Power rankings: global partners vs team-specific partners
SELECT
    'Global Partner' AS partner_level,
    COUNT(*) AS total_partners,
    SUM(deal_value_million) AS total_investment,
    ROUND(AVG(deal_value_million), 2) AS avg_deal_value
FROM global_partners
UNION ALL
SELECT
    'Title Sponsor',
    COUNT(*),
    SUM(deal_value_million),
    ROUND(AVG(deal_value_million), 2)
FROM title_sponsors
UNION ALL
SELECT
    'Principal Partner',
    COUNT(*),
    SUM(deal_value_million),
    ROUND(AVG(deal_value_million), 2)
FROM principal_partners
UNION ALL
SELECT
    'Team Partner',
    COUNT(*),
    SUM(deal_value_million),
    ROUND(AVG(deal_value_million), 2)
FROM team_partners
ORDER BY avg_deal_value DESC;

--todo 5. Overlap analysis: sponsors partnering with multiple teams
SELECT
    sponsor_name,
    COUNT(DISTINCT all_sponsors.constructor_id) AS teams_count,
    GROUP_CONCAT(DISTINCT c.team_name ORDER BY c.team_name SEPARATOR ', ') AS teams,
    SUM(deal_value_million) AS total_f1_investment,
    ROUND(AVG(deal_value_million), 2) AS avg_deal_per_team
FROM (
    SELECT sponsor_name, constructor_id, deal_value_million FROM title_sponsors
    UNION ALL
    SELECT sponsor_name, constructor_id, deal_value_million FROM principal_partners
    UNION ALL
    SELECT partner_name, constructor_id, deal_value_million FROM team_partners
) AS all_sponsors
JOIN constructors c ON all_sponsors.constructor_id = c.constructor_id
GROUP BY sponsor_name
HAVING teams_count > 1
ORDER BY teams_count DESC, total_f1_investment DESC;