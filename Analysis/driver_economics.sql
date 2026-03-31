--! ============================================
--! Driver & Talent Economics
--! ============================================

--& 1. Total driver payroll per team
SELECT
    c.team_name,
    COUNT(d.driver_id) AS total_drivers,
    SUM(d.salary_million) AS total_payroll,
    ROUND(AVG(d.salary_million), 2) AS avg_driver_salary
FROM drivers d
JOIN constructors c ON d.constructor_id = c.constructor_id
GROUP BY c.team_name
ORDER BY total_payroll DESC;

--* 2. highest paid drivers overall
SELECT
    d.driver_name,
    d.country,
    d.driver_role,
    c.team_name,
    d.salary_million
FROM drivers d
JOIN constructors c ON d.constructor_id = c.constructor_id
ORDER BY d.salary_million DESC
LIMIT 3;

--^ 3. Expiring driver contracts in 2026
SELECT
    d.driver_name,
    d.driver_role,
    c.team_name,
    d.salary_million,
    d.contract_end
FROM drivers d
JOIN constructors c ON d.constructor_id = c.constructor_id
WHERE d.contract_end = 2026
ORDER BY d.salary_million DESC;

--todo 4. Average driver salary by nationality
SELECT
    d.country,
    COUNT(d.driver_id) AS total_drivers,
    ROUND(AVG(d.salary_million), 2) AS avg_salary,
    SUM(d.salary_million) AS total_salary
FROM drivers d
GROUP BY d.country
ORDER BY avg_salary DESC;

--~ 5. ROI on driver salaries: correlation between top-paid drivers and team sponsorship revenue
SELECT
    c.team_name,
    SUM(d.salary_million) AS total_driver_payroll,
    sr.total_sponsorship_revenue,
    ROUND(sr.total_sponsorship_revenue / NULLIF(SUM(d.salary_million), 0), 2) AS sponsorship_per_salary_dollar,
    RANK() OVER (ORDER BY SUM(d.salary_million) DESC) AS driver_cost_rank,
    RANK() OVER (ORDER BY sr.total_sponsorship_revenue DESC) AS sponsorship_rank
FROM drivers d
JOIN constructors c ON d.constructor_id = c.constructor_id
JOIN sponsorship_revenue sr ON c.constructor_id = sr.constructor_id
GROUP BY c.team_name, sr.total_sponsorship_revenue
ORDER BY sponsorship_per_salary_dollar DESC;