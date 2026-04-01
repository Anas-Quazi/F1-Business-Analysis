--! ----------------------------------------------
--! Analysis & insights (foundation views)
--! ----------------------------------------------

--* team finances
CREATE VIEW team_finances AS
SELECT *,
    (total_revenue - total_expenses) AS net_profit
FROM (
    SELECT
        c.constructor_id,
        c.team_name,

        COALESCE((SELECT SUM(deal_value_million) FROM title_sponsors WHERE constructor_id = c.constructor_id), 0) +
        COALESCE((SELECT SUM(deal_value_million) FROM principal_partners WHERE constructor_id = c.constructor_id), 0) +
        COALESCE((SELECT SUM(deal_value_million) FROM team_partners WHERE constructor_id = c.constructor_id), 0) +
        COALESCE((SELECT total_prize_million FROM f1_prize_money WHERE constructor_id = c.constructor_id), 0) +
        COALESCE((SELECT SUM(ec.supply_fee_million) FROM engine_supply_contracts ec
                  WHERE ec.supplier_id = (SELECT supplier_id FROM engine_supply_contracts WHERE constructor_id = c.constructor_id AND is_external = FALSE)
                  AND ec.is_external = TRUE), 0) AS total_revenue,

        COALESCE((SELECT SUM(salary_million) FROM drivers WHERE constructor_id = c.constructor_id), 0) +
        COALESCE((SELECT management_cost_million FROM team_management WHERE constructor_id = c.constructor_id), 0) +
        COALESCE((SELECT total_expense_million FROM factory_expenses WHERE constructor_id = c.constructor_id), 0) +
        COALESCE((SELECT supply_fee_million FROM engine_supply_contracts WHERE constructor_id = c.constructor_id AND is_external = TRUE), 0) AS total_expenses

    FROM constructors c
) AS summary;

SELECT * FROM team_finances
ORDER BY net_profit DESC;

--* sponsorship revenue breakdown per team
CREATE VIEW sponsorship_revenue AS
SELECT
    c.constructor_id,
    c.team_name,
    COALESCE((SELECT SUM(deal_value_million) FROM title_sponsors ts WHERE ts.constructor_id = c.constructor_id), 0) AS title_revenue,
    COALESCE((SELECT SUM(deal_value_million) FROM principal_partners pp WHERE pp.constructor_id = c.constructor_id), 0) AS principal_revenue,
    COALESCE((SELECT SUM(deal_value_million) FROM team_partners tp WHERE tp.constructor_id = c.constructor_id), 0) AS team_partner_revenue,
    COALESCE((SELECT SUM(deal_value_million) FROM title_sponsors ts WHERE ts.constructor_id = c.constructor_id), 0) +
    COALESCE((SELECT SUM(deal_value_million) FROM principal_partners pp WHERE pp.constructor_id = c.constructor_id), 0) +
    COALESCE((SELECT SUM(deal_value_million) FROM team_partners tp WHERE tp.constructor_id = c.constructor_id), 0) AS total_sponsorship_revenue
FROM constructors c;

SELECT * FROM sponsorship_revenue
ORDER BY total_sponsorship_revenue DESC;

--* expense breakdown per team
CREATE OR REPLACE VIEW expense_breakdown AS
SELECT
    c.constructor_id,
    c.team_name,
    COALESCE((SELECT SUM(salary_million) FROM drivers d WHERE d.constructor_id = c.constructor_id), 0) AS driver_salaries,
    COALESCE((SELECT principal_salary_million FROM team_management tm WHERE tm.constructor_id = c.constructor_id), 0) AS principal_salary,
    COALESCE((SELECT management_cost_million FROM team_management tm WHERE tm.constructor_id = c.constructor_id), 0) AS management_cost,
    COALESCE((SELECT factory_cost_million FROM factory_expenses fe WHERE fe.constructor_id = c.constructor_id), 0) AS factory_cost,
    COALESCE((SELECT wind_tunnel_cost_million FROM factory_expenses fe WHERE fe.constructor_id = c.constructor_id), 0) AS wind_tunnel_cost,
    COALESCE((SELECT rd_cost_million FROM factory_expenses fe WHERE fe.constructor_id = c.constructor_id), 0) AS rd_cost,
    COALESCE((SELECT logistics_cost_million FROM factory_expenses fe WHERE fe.constructor_id = c.constructor_id), 0) AS logistics_cost,
    COALESCE((SELECT supply_fee_million FROM engine_supply_contracts ec WHERE ec.constructor_id = c.constructor_id AND ec.is_external = TRUE), 0) AS engine_cost,

    COALESCE((SELECT SUM(salary_million) FROM drivers d WHERE d.constructor_id = c.constructor_id), 0) +
    COALESCE((SELECT principal_salary_million FROM team_management tm WHERE tm.constructor_id = c.constructor_id), 0) +
    COALESCE((SELECT management_cost_million FROM team_management tm WHERE tm.constructor_id = c.constructor_id), 0) +
    COALESCE((SELECT factory_cost_million FROM factory_expenses fe WHERE fe.constructor_id = c.constructor_id), 0) +
    COALESCE((SELECT wind_tunnel_cost_million FROM factory_expenses fe WHERE fe.constructor_id = c.constructor_id), 0) +
    COALESCE((SELECT rd_cost_million FROM factory_expenses fe WHERE fe.constructor_id = c.constructor_id), 0) +
    COALESCE((SELECT logistics_cost_million FROM factory_expenses fe WHERE fe.constructor_id = c.constructor_id), 0) +
    COALESCE((SELECT supply_fee_million FROM engine_supply_contracts ec WHERE ec.constructor_id = c.constructor_id AND ec.is_external = TRUE), 0) AS total_expenses

FROM constructors c;


SELECT * FROM expense_breakdown;

