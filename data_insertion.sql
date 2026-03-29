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

INSERT INTO constructors (team_name, full_name, nationality, founded_year, constructor_budget_million, engine_supplier_id, tyre_supplier_id) VALUES
('Mercedes', 'Mercedes-AMG Petronas Formula One Team', 'German', 1954, 465.00, 1, 1),
('Ferrari', 'Scuderia Ferrari HP', 'Italian', 1950, 490.00, 2, 1),
('Red Bull', 'Oracle Red Bull Racing', 'Austrian', 2005, 455.00, 3, 1),
('McLaren', 'McLaren Formula 1 Team', 'British', 1966, 320.00, 1, 1),
('Aston Martin', 'Aston Martin Aramco Formula One Team', 'British', 2021, 350.00, 4, 1),
('Alpine', 'BWT Alpine Formula One Team', 'French', 2021, 270.00, 1, 1),
('Williams', 'Williams Racing', 'British', 1977, 260.00, 1, 1),
('Racing Bulls', 'Visa Cash App Racing Bulls Formula One Team', 'Italian', 2024, 255.00, 3, 1),
('Haas', 'MoneyGram Haas F1 Team', 'American', 2016, 250.00, 2, 1),
('Audi', 'Audi Formula One Team', 'German', 2026, 445.00, 5, 1),
('Cadillac', 'Cadillac Formula One Team', 'American', 2026, 290.00, 2, 1);