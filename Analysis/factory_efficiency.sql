--! ============================================
--! Factory & Operational Efficiency
--! ============================================

--? 1. Factory expense breakdown across all teams
SELECT
    team_name,
    factory_cost,
    wind_tunnel_cost,
    rd_cost,
    logistics_cost,
    (factory_cost + wind_tunnel_cost + rd_cost + logistics_cost) AS total_factory_expenses
FROM expense_breakdown
ORDER BY total_factory_expenses DESC;

--^ 2. Cost efficiency vs sponsorship revenue
SELECT
    eb.team_name,
    (eb.factory_cost + eb.wind_tunnel_cost + eb.rd_cost + eb.logistics_cost) AS total_factory_expenses,
    sr.total_sponsorship_revenue,
    ROUND(( (eb.factory_cost + eb.wind_tunnel_cost + eb.rd_cost + eb.logistics_cost) / NULLIF(sr.total_sponsorship_revenue, 0)) * 100, 2) AS factory_cost_to_sponsorship_pct
FROM expense_breakdown eb
JOIN sponsorship_revenue sr ON eb.constructor_id = sr.constructor_id
ORDER BY factory_cost_to_sponsorship_pct;

