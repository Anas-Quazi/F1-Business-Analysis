--!------------------------------------------------------
--! Data insertion
--!------------------------------------------------------

--* 1. Governing Bodies
INSERT INTO governing_bodies (name, role, headquarters, founded_year, website) VALUES
('FIA', 'Regulator & Sporting Governing Body', 'Paris, France', 1904, 'www.fia.com'),
('Formula One Management', 'Commercial Rights Holder', 'London, UK', 1987, 'www.formula1.com'),
('Liberty Media', 'Parent Company & Owner of F1 Commercial Rights', 'Englewood, USA', 1991, 'www.libertymedia.com');

--^ 2. fuel suppliers
INSERT INTO fuel_suppliers (supplier_name, country, supply_fee_million, contract_start) VALUES
('Petronas',   'Malaysia',      12.00, 2010),
('Shell',      'Netherlands',   15.00, 1996),
('ExxonMobil', 'United States', 10.00, 2022),
('Aramco',     'Saudi Arabia',  10.00, 2025),
('BP Castrol', 'United Kingdom', 8.00, 2026);

--^ 3. engine manufactures
INSERT INTO engine_suppliers (supplier_name, country, fuel_supplier_id, fuel_supply_fee_million) VALUES
('Mercedes-AMG HPP',         'Germany',        1, 12.00),  -- Petronas
('Ferrari',                  'Italy',          2, 15.00),  -- Shell
('Red Bull Ford Powertrains','United Kingdom',  3, 10.00),  -- ExxonMobil
('Honda Racing Corporation', 'Japan',          4, 10.00),  -- Aramco
('Audi',                     'Germany',        5,  8.00);  -- BP Castrol


--^ 4. tyre supplier
INSERT INTO tyre_suppliers (supplier_name, country, supply_fee_per_team_million, f1_sponsorship_fee_million, contract_start, contract_end) VALUES
('Pirelli', 'Italy', 1.50, 80.00, 2011, 2027);


--? ------------------------------------------------
--? 5. constructors
--? ------------------------------------------------

--& engine_supplier_id: 1=Mercedes, 2=Ferrari, 3=Red Bull Ford, 4=Honda, 5=Audi
--~ tyre_supplier_id: 1=Pirelli (all teams)

INSERT INTO constructors (team_name, full_name, country, constructor_budget_million, engine_supplier_id, tyre_supplier_id) VALUES
('Mercedes', 'Mercedes-AMG Petronas Formula One Team', 'German', 465.00, 1, 1),
('Ferrari', 'Scuderia Ferrari HP', 'Italian', 490.00, 2, 1),
('Red Bull', 'Oracle Red Bull Racing', 'Austrian', 455.00, 3, 1),
('McLaren', 'McLaren Formula 1 Team', 'British', 320.00, 1, 1),
('Aston Martin', 'Aston Martin Aramco Formula One Team', 'British', 350.00, 4, 1),
('Alpine', 'BWT Alpine Formula One Team', 'French', 270.00, 1, 1),
('Williams', 'Williams Racing', 'British', 260.00, 1, 1),
('Racing Bulls', 'Visa Cash App Racing Bulls Formula One Team', 'Italian', 255.00, 3, 1),
('Haas', 'MoneyGram Haas F1 Team', 'American', 250.00, 2, 1),
('Audi', 'Audi Formula One Team', 'German', 445.00, 5, 1),
('Cadillac', 'Cadillac Formula One Team', 'American', 290.00, 2, 1); 

--& connect to engine suppliers via junction table
INSERT INTO engine_supply_contracts (supplier_id, constructor_id, supply_fee_million, is_external, contract_start) VALUES
(1, 1, 0.00, FALSE, 2010),
(1, 4, 15.00, TRUE, 2021),
(1, 6, 12.00, TRUE, 2026),
(1, 7, 10.00, TRUE, 2014),
(2, 2, 0.00, FALSE, 1950),
(2, 9, 8.00, TRUE, 2016),
(2, 11, 10.00, TRUE, 2026),
(3, 3, 0.00, FALSE, 2026),
(3, 8, 8.00, TRUE, 2026),
(4, 5, 0.00, FALSE, 2026),
(5, 10, 0.00, FALSE, 2026);

--~ drivers
INSERT INTO drivers 
    (driver_name, country, constructor_id, salary_million, 
     contract_start, contract_end)
VALUES 

    ('George Russell', 'British', 1, 34.00, 2025, 2026),
    ('Kimi Antonelli', 'Italian', 1, 8.00, 2025, 2028),

    ('Charles Leclerc', 'Monegasque', 2, 34.00, 2025, 2028),
    ('Lewis Hamilton', 'British', 2, 60.00, 2025, 2026),

    ('Max Verstappen', 'Dutch', 3, 70.00, 2024, 2028),
    ('Isack Hadjar', 'French', 3, 6.00, 2026, 2027),

    ('Lando Norris', 'British', 4, 30.00, 2025, 2027),
    ('Oscar Piastri', 'Australian', 4, 18.00, 2025, 2028),

    ('Fernando Alonso', 'Spanish', 5, 20.00, 2025, 2026),
    ('Lance Stroll', 'Canadian', 5, 12.00, 2024, 2028),

    ('Pierre Gasly', 'French', 6, 10.00, 2025, 2028),
    ('Franco Colapinto', 'Argentinian', 6, 5.00, 2025, 2027),

    ('Carlos Sainz', 'Spanish', 7, 13.00, 2025, 2027),
    ('Alexander Albon', 'Thai', 7, 8.00, 2025, 2027),

    ('Liam Lawson', 'New Zealander', 8, 5.00, 2025, 2027),
    ('Arvid Lindblad', 'Swedish', 8, 3.50, 2026, 2028),

    ('Esteban Ocon', 'French', 9, 8.00, 2025, 2026),
    ('Oliver Bearman', 'British', 9, 4.00, 2025, 2027),

    ('Nico Hulkenberg', 'German', 10, 8.00, 2025, 2026),
    ('Gabriel Bortoleto', 'Brazilian', 10, 4.50, 2025, 2028),

    ('Sergio Perez', 'Mexican', 11, 10.00, 2025, 2026),
    ('Valtteri Bottas', 'Finnish', 11, 8.00, 2025, 2026),

    ('Kush Maini', 'Indian', 6, 1.20, 2025, 2027),
    ('Frederik Vesti', 'Danish', 1, 1.50, 2025, 2027),
    ('Antonio Giovinazzi', 'Italian', 2, 2.00, 2025, 2026),
    ('Yuki Tsunoda', 'Japanese', 3, 3.00, 2025, 2027),
    ('Leonardo Fornaroli', 'Italian', 4, 1.20, 2026, 2027),
    ('Pato OWard', 'Mexican', 4, 2.00, 2025, 2027),
    ('Paul Aron', 'Estonian', 6, 1.00, 2025, 2027),
    ('Jack Doohan', 'Australian', 9, 1.50, 2025, 2026);


--~ team management
INSERT INTO team_management 
    (constructor_id, principal_name, principal_salary_million, management_cost_million)
VALUES
    (1, 'Toto Wolff', 9.50, 45.00),      
    (2, 'Fred Vasseur', 6.00, 38.00),    
    (3, 'Laurent Mekies', 2.50, 32.00),  
    (4, 'Andrea Stella', 4.50, 35.00),   
    (5, 'Adrian Newey', 10.00, 42.00),   
    (6, 'Flavio Briatore', 5.00, 34.00),
    (7, 'James Vowles', 5.00, 28.00),    
    (8, 'Alan Permane', 1.50, 24.00),    
    (9, 'Ayao Komatsu', 1.00, 22.00),    
    (10, 'Jonathan Wheatley', 3.50, 36.00), 
    (11, 'Graeme Lowdon', 1.50, 20.00);  

--~ other factory expenses
INSERT INTO factory_expenses 
    (constructor_id, factory_cost_million, wind_tunnel_cost_million, 
     rd_cost_million, logistics_cost_million, total_expense_million)
VALUES
    (1, 45.00, 25.00, 110.00, 32.00, 212.00),
    (2, 44.00, 26.00, 112.00, 31.00, 213.00),
    (3, 46.00, 24.00, 108.00, 35.00, 213.00),
    (4, 42.00, 22.00, 105.00, 30.00, 199.00),
    (5, 40.00, 21.00, 100.00, 29.00, 190.00),
    (6, 38.00, 20.00, 95.00, 28.00, 181.00),
    (7, 35.00, 18.00, 88.00, 26.00, 167.00),
    (8, 32.00, 16.00, 82.00, 25.00, 155.00),
    (9, 28.00, 15.00, 75.00, 24.00, 142.00),
    (10, 42.00, 23.00, 102.00, 33.00, 200.00),
    (11, 36.00, 19.00, 90.00, 27.00, 172.00);
