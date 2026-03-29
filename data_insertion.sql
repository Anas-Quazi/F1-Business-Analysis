--!------------------------------------------------------
--! Data insertion
--!------------------------------------------------------

--* 1. Governing Bodies
INSERT INTO governing_bodies (name, role, headquarters, founded_year, website) VALUES
('FIA', 'Regulator & Sporting Governing Body', 'Paris, France', 1904, 'www.fia.com'),
('Formula One Management', 'Commercial Rights Holder', 'London, UK', 1987, 'www.formula1.com'),
('Liberty Media', 'Parent Company & Owner of F1 Commercial Rights', 'Englewood, USA', 1991, 'www.libertymedia.com');

--^ fuel suppliers
-- 3. Fuel Suppliers
INSERT INTO fuel_suppliers (supplier_name, country, supply_fee_million, contract_start) VALUES
('Petronas',   'Malaysia',      12.00, 2010),
('Shell',      'Netherlands',   15.00, 1996),
('ExxonMobil', 'United States', 10.00, 2022),
('Aramco',     'Saudi Arabia',  10.00, 2025),
('BP Castrol', 'United Kingdom', 8.00, 2026);

--^ engine manufactures
INSERT INTO engine_suppliers (supplier_name, country, fuel_supplier_id, fuel_supply_fee_million) VALUES
('Mercedes-AMG HPP',         'Germany',        1, 12.00),  -- Petronas
('Ferrari',                  'Italy',          2, 15.00),  -- Shell
('Red Bull Ford Powertrains','United Kingdom',  3, 10.00),  -- ExxonMobil
('Honda Racing Corporation', 'Japan',          4, 10.00),  -- Aramco
('Audi',                     'Germany',        5,  8.00);  -- BP Castrol
