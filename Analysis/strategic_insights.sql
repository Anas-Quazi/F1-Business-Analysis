--! ============================================
--! Strategic Business Insights
--! ============================================

--~ Most diversified sponsor portfolio per team
SELECT
    c.team_name,
    COUNT(DISTINCT COALESCE(ts.category, pp.category, tp.category)) AS unique_industries,
    COUNT(DISTINCT ts.sponsor_id) + COUNT(DISTINCT pp.sponsor_id) + COUNT(DISTINCT tp.partner_id) AS total_sponsors
FROM constructors c
LEFT JOIN title_sponsors ts ON c.constructor_id = ts.constructor_id
LEFT JOIN principal_partners pp ON c.constructor_id = pp.constructor_id
LEFT JOIN team_partners tp ON c.constructor_id = tp.constructor_id
GROUP BY c.team_name
ORDER BY unique_industries DESC, total_sponsors DESC;

--* 2. F1 ecosystem summary
SELECT
    (SELECT COUNT(*) FROM constructors) AS total_teams,
    (SELECT COUNT(*) FROM drivers) AS total_drivers,
    (SELECT SUM(deal_value_million) FROM title_sponsors) +
    (SELECT SUM(deal_value_million) FROM principal_partners) +
    (SELECT SUM(deal_value_million) FROM team_partners) AS total_sponsorship_pool,
    (SELECT SUM(supply_fee_million) FROM engine_supply_contracts WHERE is_external = TRUE) AS total_engine_revenue,
    (SELECT SUM(total_prize_million) FROM f1_prize_money) AS total_prize_money_distributed,
    (SELECT AVG(net_profit) FROM team_finances) AS avg_team_profit;

--todo 3. Risk heatmap — teams with high expenses and expiring contracts
SELECT
    c.team_name,
    tf.total_expenses,
    tf.net_profit,
    COUNT(CASE WHEN ts.contract_end <= 2027 THEN 1 END) +
    COUNT(CASE WHEN pp.contract_end <= 2027 THEN 1 END) +
    COUNT(CASE WHEN tp.contract_end <= 2027 THEN 1 END) AS expiring_contracts,
    SUM(CASE WHEN ts.contract_end <= 2027 THEN ts.deal_value_million ELSE 0 END) +
    SUM(CASE WHEN pp.contract_end <= 2027 THEN pp.deal_value_million ELSE 0 END) +
    SUM(CASE WHEN tp.contract_end <= 2027 THEN tp.deal_value_million ELSE 0 END) AS revenue_at_risk,
    CASE
        WHEN tf.net_profit < 0 AND COUNT(CASE WHEN ts.contract_end <= 2027 THEN 1 END) > 2 THEN 'HIGH RISK'
        WHEN tf.net_profit < 50 AND COUNT(CASE WHEN ts.contract_end <= 2027 THEN 1 END) > 1 THEN 'MEDIUM RISK'
        ELSE 'LOW RISK'
    END AS risk_level
FROM constructors c
JOIN team_finances tf ON c.constructor_id = tf.constructor_id
LEFT JOIN title_sponsors ts ON c.constructor_id = ts.constructor_id
LEFT JOIN principal_partners pp ON c.constructor_id = pp.constructor_id
LEFT JOIN team_partners tp ON c.constructor_id = tp.constructor_id
GROUP BY c.team_name, tf.total_expenses, tf.net_profit
ORDER BY revenue_at_risk DESC;

