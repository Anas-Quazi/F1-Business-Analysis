--!--------------------------------
--! cost and profitability analysis
--!--------------------------------

--^ 1. Net profit/loss per constructor
SELECT
    constructor_id,
    team_name,
    total_revenue,
    total_expenses,
    net_profit,
    CASE
        WHEN net_profit >= 200 THEN 'High Performing'
        WHEN net_profit >= 100 THEN 'Robust'
        WHEN net_profit >= 40  THEN 'Stable'
        ELSE 'Marginal'
    END AS financial_status
FROM team_finances
ORDER BY net_profit DESC;

--* 2. Cost category breakdown as % of total expenses
SELECT
    team_name,
    ROUND((driver_salaries / NULLIF(total_expenses, 0)) * 100, 2) AS driver_salary_pct,
    ROUND((management_cost / NULLIF(total_expenses, 0)) * 100, 2) AS management_pct,
    ROUND((factory_cost / NULLIF(total_expenses, 0)) * 100, 2) AS factory_pct,
    ROUND((wind_tunnel_cost / NULLIF(total_expenses, 0)) * 100, 2) AS wind_tunnel_pct,
    ROUND((rd_cost / NULLIF(total_expenses, 0)) * 100, 2) AS rd_pct,
    ROUND((logistics_cost / NULLIF(total_expenses, 0)) * 100, 2) AS logistics_pct
FROM expense_breakdown
ORDER BY total_expenses DESC;

--& 3. Most expensive vs most efficient teams (cost to revenue ratio)
SELECT
    tf.team_name,
    tf.total_expenses,
    tf.total_revenue,
    ROUND((tf.total_expenses / NULLIF(tf.total_revenue, 0)) * 100, 2) AS cost_to_revenue_ratio,
    RANK() OVER (ORDER BY tf.total_expenses DESC) AS most_expensive_rank,
    RANK() OVER (ORDER BY (tf.total_expenses / NULLIF(tf.total_revenue, 0))) AS least_efficient_rank
FROM team_finances tf
ORDER BY cost_to_revenue_ratio;

--? 4. Teams operating at a low profit with reason
SELECT
    eb.team_name,
    tf.total_revenue,
    tf.total_expenses,
    tf.net_profit,
    eb.driver_salaries,
    eb.factory_cost,
    eb.rd_cost,
    CASE
        WHEN eb.driver_salaries > tf.total_revenue * 0.4 THEN 'High Driver Salaries'
        WHEN eb.factory_cost > tf.total_revenue * 0.3 THEN 'High Factory Costs'
        WHEN eb.rd_cost > tf.total_revenue * 0.3 THEN 'High R&D Costs'
        ELSE 'Multiple Cost Pressures'
    END AS primary_loss_reason
FROM team_finances tf
JOIN expense_breakdown eb ON tf.constructor_id = eb.constructor_id
WHERE tf.net_profit < 100
ORDER BY tf.net_profit;

