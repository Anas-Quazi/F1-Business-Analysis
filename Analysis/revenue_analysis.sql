--^ 4. Total sponsorship revenue per team (with title sponsor % contribution)
SELECT
    team_name,
    title_revenue,
    principal_revenue,
    team_partner_revenue,
    total_sponsorship_revenue,
    ROUND((title_revenue / NULLIF(total_sponsorship_revenue, 0)) * 100, 2) AS title_sponsor_percentage
FROM sponsorship_revenue
ORDER BY  title_sponsor_percentage DESC;


--^ 5. Teams ranked by total sponsorship income vs overall profitability
WITH RankedTeams AS (
    SELECT
        sr.team_name,
        sr.total_sponsorship_revenue,
        tf.total_revenue,
        tf.total_expenses,
        tf.net_profit,
        RANK() OVER (ORDER BY sr.total_sponsorship_revenue DESC) AS sponsorship_rank,
        RANK() OVER (ORDER BY tf.net_profit DESC) AS profitability_rank
    FROM sponsorship_revenue sr
    JOIN team_finances tf ON sr.constructor_id = tf.constructor_id
)
SELECT 
    *,
    (CAST(sponsorship_rank AS SIGNED) - CAST(profitability_rank AS SIGNED)) AS rank_difference
FROM RankedTeams
ORDER BY rank_difference DESC;

--^ 6. Teams most dependent on a single sponsor
SELECT
    c.team_name,
    ts.sponsor_name,
    ts.partnership_type,
    ts.deal_value_million,
    sr.total_sponsorship_revenue,
    ROUND((ts.deal_value_million / NULLIF(sr.total_sponsorship_revenue, 0)) * 100, 2) AS dependency_percentage
FROM title_sponsors ts
JOIN constructors c ON ts.constructor_id = c.constructor_id
JOIN sponsorship_revenue sr ON c.constructor_id = sr.constructor_id
ORDER BY dependency_percentage DESC;

--^ 7. Expiring sponsorship contracts in next 2 years (2026-2027)
SELECT
    c.team_name,
    ts.sponsor_name AS sponsor,
    'Title Sponsor' AS type,
    ts.deal_value_million,
    ts.contract_end
FROM title_sponsors ts
JOIN constructors c ON ts.constructor_id = c.constructor_id
WHERE ts.contract_end BETWEEN 2026 AND 2027
UNION ALL
SELECT
    c.team_name,
    pp.sponsor_name,
    'Principal Partner',
    pp.deal_value_million,
    pp.contract_end
FROM principal_partners pp
JOIN constructors c ON pp.constructor_id = c.constructor_id
WHERE pp.contract_end BETWEEN 2026 AND 2027
UNION ALL
SELECT
    c.team_name,
    tp.partner_name,
    'Team Partner',
    tp.deal_value_million,
    tp.contract_end
FROM team_partners tp
JOIN constructors c ON tp.constructor_id = c.constructor_id
WHERE tp.contract_end BETWEEN 2026 AND 2027
ORDER BY contract_end, deal_value_million DESC;

--^ 8. Sponsorship value by industry/sector
SELECT
    category AS industry,
    COUNT(*) AS number_of_deals,
    SUM(deal_value_million) AS total_investment,
    ROUND(AVG(deal_value_million), 2) AS avg_deal_value
FROM (
    SELECT category, deal_value_million FROM title_sponsors
    UNION ALL
    SELECT category, deal_value_million FROM principal_partners
    UNION ALL
    SELECT category, deal_value_million FROM team_partners
) AS all_sponsors
GROUP BY category
ORDER BY total_investment DESC;

--^ 9. Sponsorship value by industry/sector
SELECT
    country AS industry,
    COUNT(*) AS number_of_deals,
    SUM(deal_value_million) AS total_investment,
    ROUND(AVG(deal_value_million), 2) AS avg_deal_value
FROM (
    SELECT country, deal_value_million FROM title_sponsors
    UNION ALL
    SELECT country, deal_value_million FROM principal_partners
    UNION ALL
    SELECT country, deal_value_million FROM team_partners
) AS all_sponsors
GROUP BY country
ORDER BY total_investment DESC;
