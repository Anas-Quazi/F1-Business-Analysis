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

--* 3. Headquarters location impact on expenses (European vs non-European teams)
SELECT
    CASE
        WHEN c.country IN ('British', 'German', 'Italian', 'French', 'Austrian', 'Swiss') THEN 'European'
        ELSE 'Non-European'
    END AS team_region,
    COUNT(*) AS total_teams,
    ROUND(AVG(eb.factory_cost), 2) AS avg_factory_cost,
    ROUND(AVG(eb.rd_cost), 2) AS avg_rd_cost,
    ROUND(AVG(eb.logistics_cost), 2) AS avg_logistics_cost,
    ROUND(AVG(eb.total_expenses), 2) AS avg_total_expenses
FROM constructors c
JOIN expense_breakdown eb ON c.constructor_id = eb.constructor_id
GROUP BY team_region
ORDER BY avg_total_expenses DESC;

--todo 4. Highest and lowest factory cost teams with possible reasons
SELECT
    eb.team_name,
    c.country,
    eb.factory_cost,
    eb.wind_tunnel_cost,
    eb.rd_cost,
    eb.total_expenses,
    RANK() OVER (ORDER BY eb.factory_cost DESC) AS factory_cost_rank,
    CASE
        WHEN eb.factory_cost = MAX(eb.factory_cost) OVER () THEN 'Largest factory infrastructure'
        WHEN eb.factory_cost = MIN(eb.factory_cost) OVER () THEN 'Lean/outsourced operations'
        WHEN eb.rd_cost > eb.factory_cost THEN 'R&D heavy team'
        WHEN eb.factory_cost > eb.rd_cost * 2 THEN 'Manufacturing heavy team'
        ELSE 'Balanced operations'
    END AS possible_reason
FROM expense_breakdown eb
JOIN constructors c ON eb.constructor_id = c.constructor_id
ORDER BY eb.factory_cost DESC;
