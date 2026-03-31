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
('Petronas',   'Malaysia',      14.00, 2010),
('Shell',      'Netherlands',   16.00, 1996),
('ExxonMobil', 'United States', 12.00, 2022),
('Aramco',     'Saudi Arabia',  11.00, 2025),
('BP Castrol', 'United Kingdom', 9.00, 2026);

--^ 3. engine manufactures
INSERT INTO engine_suppliers (supplier_name, country, fuel_supplier_id, fuel_supply_fee_million) VALUES
('Mercedes-AMG HPP',         'Germany',        1, 14.00),
('Ferrari',                  'Italy',          2, 16.00),
('Red Bull Ford Powertrains','United Kingdom',  3, 12.00),
('Honda Racing Corporation', 'Japan',          4, 11.00),
('Audi',                     'Germany',        5,  9.00);

--^ 4. tyre supplier
INSERT INTO tyre_suppliers (supplier_name, country, supply_fee_per_team_million, f1_sponsorship_fee_million, contract_start, contract_end) VALUES
('Pirelli', 'Italy', 1.80, 85.00, 2011, 2027);

--? ------------------------------------------------
--? 5. constructors
--? ------------------------------------------------

INSERT INTO constructors (team_name, full_name, country, constructor_budget_million, engine_supplier_id, tyre_supplier_id) VALUES
('Mercedes', 'Mercedes-AMG Petronas Formula One Team', 'German', 520.00, 1, 1),
('Ferrari', 'Scuderia Ferrari HP', 'Italian', 510.00, 2, 1),
('Red Bull', 'Oracle Red Bull Racing', 'Austrian', 500.00, 3, 1),
('McLaren', 'McLaren Formula 1 Team', 'British', 485.00, 1, 1),
('Aston Martin', 'Aston Martin Aramco Formula One Team', 'British', 465.00, 4, 1),
('Alpine', 'BWT Alpine Formula One Team', 'French', 445.00, 1, 1),
('Williams', 'Williams Racing', 'British', 430.00, 1, 1),
('Racing Bulls', 'Visa Cash App Racing Bulls Formula One Team', 'Italian', 435.00, 3, 1),
('Haas', 'MoneyGram Haas F1 Team', 'American', 425.00, 2, 1),
('Audi', 'Audi Formula One Team', 'German', 475.00, 5, 1),
('Cadillac', 'Cadillac Formula One Team', 'American', 450.00, 2, 1); 

--& 6. connect to engine suppliers via junction table
INSERT INTO engine_supply_contracts (supplier_id, constructor_id, supply_fee_million, is_external, contract_start) VALUES
(1, 1, 0.00, FALSE, 2010),
(1, 4, 18.00, TRUE, 2021),
(1, 6, 14.00, TRUE, 2026),
(1, 7, 12.00, TRUE, 2014),
(2, 2, 0.00, FALSE, 1950),
(2, 9, 10.00, TRUE, 2016),
(2, 11, 13.00, TRUE, 2026),
(3, 3, 0.00, FALSE, 2026),
(3, 8, 9.50, TRUE, 2026),
(4, 5, 0.00, FALSE, 2026),
(5, 10, 0.00, FALSE, 2026);

--~ 7. drivers
INSERT INTO drivers 
    (driver_name, country, constructor_id, salary_million, 
     contract_start, contract_end)
VALUES 
    ('George Russell', 'British', 1, 35.00, 2025, 2026),
    ('Kimi Antonelli', 'Italian', 1, 9.00, 2025, 2028),
    ('Charles Leclerc', 'Monegasque', 2, 36.00, 2025, 2028),
    ('Lewis Hamilton', 'British', 2, 58.00, 2025, 2026),
    ('Max Verstappen', 'Dutch', 3, 68.00, 2024, 2028),
    ('Isack Hadjar', 'French', 3, 7.00, 2026, 2027),
    ('Lando Norris', 'British', 4, 32.00, 2025, 2027),
    ('Oscar Piastri', 'Australian', 4, 20.00, 2025, 2028),
    ('Fernando Alonso', 'Spanish', 5, 21.00, 2025, 2026),
    ('Lance Stroll', 'Canadian', 5, 13.00, 2024, 2028),
    ('Pierre Gasly', 'French', 6, 11.00, 2025, 2028),
    ('Franco Colapinto', 'Argentinian', 6, 6.00, 2025, 2027),
    ('Carlos Sainz', 'Spanish', 7, 14.00, 2025, 2027),
    ('Alexander Albon', 'Thai', 7, 9.00, 2025, 2027),
    ('Liam Lawson', 'New Zealander', 8, 6.00, 2025, 2027),
    ('Arvid Lindblad', 'Swedish', 8, 4.00, 2026, 2028),
    ('Esteban Ocon', 'French', 9, 9.00, 2025, 2026),
    ('Oliver Bearman', 'British', 9, 5.00, 2025, 2027),
    ('Nico Hulkenberg', 'German', 10, 9.00, 2025, 2026),
    ('Gabriel Bortoleto', 'Brazilian', 10, 5.50, 2025, 2028),
    ('Sergio Perez', 'Mexican', 11, 11.00, 2025, 2026),
    ('Valtteri Bottas', 'Finnish', 11, 9.00, 2025, 2026),
    ('Kush Maini', 'Indian', 6, 1.50, 2025, 2027),
    ('Frederik Vesti', 'Danish', 1, 2.00, 2025, 2027),
    ('Antonio Giovinazzi', 'Italian', 2, 2.50, 2025, 2026),
    ('Yuki Tsunoda', 'Japanese', 3, 4.00, 2025, 2027),
    ('Leonardo Fornaroli', 'Italian', 4, 1.50, 2026, 2027),
    ('Pato OWard', 'Mexican', 4, 2.50, 2025, 2027),
    ('Paul Aron', 'Estonian', 6, 1.20, 2025, 2027),
    ('Jack Doohan', 'Australian', 9, 2.00, 2025, 2026);

--~ 8. team management
INSERT INTO team_management 
    (constructor_id, principal_name, principal_salary_million, management_cost_million)
VALUES
    (1, 'Toto Wolff', 10.00, 48.00),      
    (2, 'Fred Vasseur', 6.50, 42.00),    
    (3, 'Laurent Mekies', 3.00, 38.00),  
    (4, 'Andrea Stella', 5.00, 40.00),   
    (5, 'Adrian Newey', 12.00, 45.00),   
    (6, 'Flavio Briatore', 5.50, 37.00),
    (7, 'James Vowles', 5.50, 32.00),    
    (8, 'Alan Permane', 2.00, 28.00),    
    (9, 'Ayao Komatsu', 1.50, 26.00),    
    (10, 'Jonathan Wheatley', 4.00, 39.00), 
    (11, 'Graeme Lowdon', 2.00, 25.00);  

--~ 9. other factory expenses
INSERT INTO factory_expenses 
    (constructor_id, factory_cost_million, wind_tunnel_cost_million, 
     rd_cost_million, logistics_cost_million, total_expense_million)
VALUES
    (1, 48.00, 28.00, 118.00, 35.00, 229.00),
    (2, 47.00, 29.00, 120.00, 34.00, 230.00),
    (3, 49.00, 27.00, 115.00, 36.00, 227.00),
    (4, 45.00, 25.00, 112.00, 33.00, 215.00),
    (5, 43.00, 24.00, 108.00, 32.00, 207.00),
    (6, 41.00, 23.00, 102.00, 31.00, 197.00),
    (7, 38.00, 21.00, 95.00, 29.00, 183.00),
    (8, 36.00, 19.00, 90.00, 28.00, 173.00),
    (9, 32.00, 18.00, 85.00, 27.00, 162.00),
    (10, 44.00, 26.00, 110.00, 34.00, 214.00),
    (11, 40.00, 22.00, 98.00, 30.00, 190.00);

--todo 10. Title Sponsors Table for the 2026 Season
INSERT INTO title_sponsors (sponsor_name, country, category, deal_value_million, contract_start, contract_end, constructor_id) VALUES
('Petronas', 'Malaysia', 'Energy', 98.00, 2010, 2029, 1),
('HP', 'United States', 'Technology', 105.00, 2024, 2027, 2),
('Oracle', 'United States', 'Technology', 118.00, 2022, 2030, 3),
('Mastercard', 'United States', 'Finance', 102.00, 2026, 2035, 4),
('Aramco', 'Saudi Arabia', 'Energy', 92.00, 2024, 2028, 5),
('BWT', 'Austria', 'Water Treatment', 52.00, 2022, 2026, 6),
('Atlassian', 'Australia', 'Technology', 55.00, 2025, 2028, 7),
('Visa Cash App', 'United States', 'Finance', 55.00, 2024, 2026, 8),
('Toyota Gazoo Racing', 'Japan', 'Automotive', 58.00, 2026, 2028, 9),
('Revolut', 'United Kingdom', 'Finance', 85.00, 2026, 2029, 10),
('Tommy Hilfiger', 'United States', 'Apparel', 32.00, 2026, 2030, 11);

--todo 11. principal partners
INSERT INTO principal_partners (sponsor_name, country, category, deal_value_million, contract_start, constructor_id) VALUES
('INEOS', 'United Kingdom', 'Chemicals', 35.00, 2020, 1),
('CrowdStrike', 'United States', 'Cybersecurity', 32.00, 2019, 1),
('Microsoft', 'United States', 'Technology', 55.00, 2026, 1),
('UniCredit', 'Italy', 'Finance', 40.00, 2023, 2),
('Richard Mille', 'Switzerland', 'Luxury', 32.00, 2021, 2),
('DXC Technology', 'United States', 'Technology', 28.00, 2019, 2),
('IBM', 'United States', 'Technology', 26.00, 2023, 2),
('Tag Heuer', 'Switzerland', 'Luxury', 28.00, 2016, 3),
('AT&T', 'United States', 'Telecommunications', 30.00, 2023, 3),
('Hard Rock International', 'United States', 'Hospitality', 24.00, 2023, 3),
('Siemens', 'Germany', 'Technology', 24.00, 2021, 3),
('Ford', 'United States', 'Automotive', 35.00, 2026, 3),
('Google Chrome', 'United States', 'Technology', 40.00, 2023, 4),
('Dell Technologies', 'United States', 'Technology', 28.00, 2020, 4),
('OKX', 'Seychelles', 'Finance', 30.00, 2022, 4),
('A Better Tomorrow', 'United Kingdom', 'Consumer Goods', 22.00, 2019, 4),
('Cognizant', 'United States', 'Technology', 27.00, 2021, 5),
('JCB', 'United Kingdom', 'Manufacturing', 22.00, 2023, 5),
('Honda', 'Japan', 'Automotive', 35.00, 2026, 5),
('Qatar Airways', 'Qatar', 'Aviation', 28.00, 2023, 6),
('Boeing', 'United States', 'Aerospace', 22.00, 2023, 6),
('Gulf', 'United Kingdom', 'Energy', 22.00, 2022, 7),
('Barclays', 'United Kingdom', 'Finance', 27.00, 2026, 7),
('Kraken', 'United States', 'Finance', 18.00, 2024, 7),
('Randstad', 'Netherlands', 'Recruitment', 17.00, 2020, 8),
('Ford', 'United States', 'Automotive', 19.00, 2026, 8),
('Mphasis', 'India', 'Technology', 15.00, 2024, 9),
('BP Castrol', 'United Kingdom', 'Energy', 25.00, 2026, 10),
('Adidas', 'Germany', 'Apparel', 42.00, 2026, 10),
('Visit Qatar', 'Qatar', 'Tourism', 22.00, 2026, 10),
('General Motors', 'United States', 'Automotive', 42.00, 2026, 11),
('TWG AI', 'United States', 'Technology', 22.00, 2026, 11),
('Tommy Hilfiger', 'United States', 'Fashion', 19.00, 2026, 11);

--todo 12. Team Partners
INSERT INTO team_partners (partner_name, country, category, deal_value_million, contract_start, constructor_id) VALUES
('Snapdragon', 'United States', 'Technology', 17.00, 2023, 1),
('TeamViewer', 'Germany', 'Technology', 14.00, 2021, 1),
('UBS', 'Switzerland', 'Finance', 12.00, 2021, 1),
('HPE', 'United States', 'Technology', 12.00, 2022, 1),
('Adidas', 'Germany', 'Apparel', 10.00, 2022, 1),
('SAP', 'Germany', 'Technology', 10.00, 2018, 1),
('Meta AI', 'United States', 'Technology', 9.00, 2023, 1),
('WhatsApp', 'United States', 'Technology', 7.00, 2023, 1),
('AMD', 'United States', 'Technology', 8.00, 2022, 1),
('Marriott Bonvoy', 'United States', 'Hospitality', 7.00, 2022, 1),
('IWC Schaffhausen', 'Switzerland', 'Luxury', 10.00, 2020, 1),
('G42', 'United Arab Emirates', 'Technology', 12.00, 2023, 1),
('Solera', 'United States', 'Technology', 8.00, 2022, 1),
('PepsiCo', 'United States', 'Beverages', 9.00, 2026, 1),
('Nu', 'Brazil', 'Finance', 7.00, 2026, 1),
('Ray-Ban', 'Italy', 'Luxury', 10.00, 2020, 2),
('Puma', 'Germany', 'Apparel', 12.00, 2014, 2),
('Brembo', 'Italy', 'Automotive', 7.00, 2015, 2),
('Technogym', 'Italy', 'Fitness', 6.00, 2018, 2),
('Vistajet', 'Malta', 'Aviation', 8.00, 2019, 2),
('IBM', 'United States', 'Technology', 12.00, 2023, 2),
('AON', 'United Kingdom', 'Finance', 8.00, 2021, 2),
('Peroni', 'Italy', 'Beverages', 6.00, 2019, 2),
('WHOOP', 'United States', 'Technology', 7.00, 2026, 2),
('BingX', 'Singapore', 'Finance', 6.00, 2026, 2),
('Mobil 1', 'United States', 'Energy', 10.00, 2016, 3),
('Heineken', 'Netherlands', 'Beverages', 12.00, 2017, 3),
('Castore', 'United Kingdom', 'Apparel', 8.00, 2022, 3),
('Hexagon', 'Sweden', 'Technology', 8.00, 2021, 3),
('DMG Mori', 'Germany', 'Manufacturing', 6.00, 2020, 3),
('1Password', 'Canada', 'Technology', 7.00, 2023, 3),
('DAMAC Properties', 'United Arab Emirates', 'Real Estate', 10.00, 2026, 3),
('Pepe Jeans', 'United Kingdom', 'Apparel', 6.00, 2021, 3),
('Splunk', 'United States', 'Technology', 10.00, 2021, 4),
('Richard Mille', 'Switzerland', 'Luxury', 14.00, 2021, 4),
('Hilton', 'United States', 'Hospitality', 8.00, 2021, 4),
('Deloitte', 'United Kingdom', 'Finance', 9.00, 2021, 4),
('Monster Energy', 'United States', 'Beverages', 10.00, 2020, 4),
('Workday', 'United States', 'Technology', 8.00, 2022, 4),
('Goldman Sachs', 'United States', 'Finance', 10.00, 2023, 4),
('LEGO', 'Denmark', 'Consumer Goods', 7.00, 2023, 4),
('Etihad Airlines', 'United Arab Emirates', 'Aviation', 12.00, 2026, 4),
('Puma', 'Germany', 'Apparel', 8.00, 2026, 4),
('Gemini', 'United States', 'Finance', 10.00, 2026, 4),
('NetApp', 'United States', 'Technology', 8.00, 2022, 5),
('Boss', 'Germany', 'Fashion', 7.00, 2022, 5),
('Valvoline', 'United States', 'Energy', 6.00, 2022, 5),
('CoreWeave', 'United States', 'Technology', 10.00, 2025, 5),
('Cohere', 'Canada', 'Technology', 9.00, 2026, 5),
('Coinbase', 'United States', 'Finance', 8.00, 2023, 5),
('Glenfiddich', 'United Kingdom', 'Beverages', 6.00, 2022, 5),
('Breitling', 'Switzerland', 'Luxury', 7.00, 2026, 5),
('Eni', 'Italy', 'Energy', 14.00, 2021, 6),
('MSC Cruises', 'Switzerland', 'Hospitality', 10.00, 2022, 6),
('H Moser and Cie', 'Switzerland', 'Luxury', 7.00, 2022, 6),
('Castore', 'United Kingdom', 'Apparel', 6.00, 2023, 6),
('eToro', 'Cyprus', 'Finance', 7.00, 2026, 6),
('Mobilize Financial Services', 'France', 'Finance', 6.00, 2022, 6),
('Duracell', 'United States', 'Consumer Goods', 7.00, 2023, 7),
('Komatsu', 'Japan', 'Manufacturing', 6.00, 2024, 7),
('BNY', 'United States', 'Finance', 8.00, 2026, 7),
('Zoox', 'United States', 'Technology', 6.00, 2023, 7),
('Girard Perregaux', 'Switzerland', 'Luxury', 7.00, 2026, 7),
('Sparco', 'Italy', 'Automotive', 5.00, 2026, 7),
('Cash App', 'United States', 'Finance', 14.00, 2024, 8),
('Hugo', 'Germany', 'Fashion', 7.00, 2024, 8),
('Tudor', 'Switzerland', 'Luxury', 8.00, 2022, 8),
('Siemens', 'Germany', 'Technology', 7.00, 2021, 8),
('Dynatrace', 'United States', 'Technology', 6.00, 2023, 8),
('Haas Automation', 'United States', 'Manufacturing', 17.00, 2016, 9),
('Alpinestars', 'Italy', 'Apparel', 5.00, 2016, 9),
('Castore', 'United Kingdom', 'Apparel', 6.00, 2026, 9),
('Singha Corporation', 'Thailand', 'Beverages', 5.00, 2026, 9),
('CommScope', 'United States', 'Technology', 6.00, 2023, 9),
('Gillette', 'United States', 'Consumer Goods', 8.00, 2026, 10),
('Visit Qatar', 'Qatar', 'Tourism', 10.00, 2026, 10),
('NinjaOne', 'United States', 'Technology', 7.00, 2026, 10),
('ElevenLabs', 'United States', 'Technology', 6.00, 2026, 10),
('Camozzi', 'Italy', 'Manufacturing', 5.00, 2024, 10),
('World of Hyatt', 'United States', 'Hospitality', 7.00, 2026, 10),
('Claro', 'Mexico', 'Telecommunications', 10.00, 2026, 11),
('Core Scientific', 'United States', 'Technology', 8.00, 2026, 11),
('IFS', 'Sweden', 'Technology', 7.00, 2026, 11),
('Jim Beam', 'United States', 'Beverages', 6.00, 2026, 11),
('Tenneco', 'United States', 'Automotive', 7.00, 2026, 11);

--* 13. Global partners
INSERT INTO global_partners 
    (partner_name, country, category, deal_value_million, contract_start, contract_end)
VALUES
    ('Aramco', 'Saudi Arabia', 'Energy', 80.00, 2022, 2027),
    ('AWS (Amazon Web Services)', 'USA', 'Technology', 65.00, 2023, 2028),
    ('Qatar Airways', 'Qatar', 'Airline', 75.00, 2023, 2027),
    ('MSC Cruises', 'Switzerland', 'Travel & Hospitality', 35.00, 2022, 2030),
    ('LVMH', 'France', 'Luxury', 150.00, 2025, 2035),
    ('Salesforce', 'USA', 'Technology', 55.00, 2024, 2027),
    ('DHL', 'Germany', 'Logistics', 50.00, 2019, 2026),
    ('Lenovo', 'China', 'Technology', 45.00, 2024, 2027),
    ('Allwyn', 'Czech Republic', 'Lottery & Entertainment', 40.00, 2025, 2030),
    ('Standard Chartered', 'UK', 'Banking', 35.00, 2026, 2029),
    ('Crypto.com', 'Singapore', 'Cryptocurrency', 50.00, 2022, 2028);

--* 14. official partners
INSERT INTO official_suppliers 
(supplier_name, country, category, deal_value_million, contract_start, contract_end)
VALUES
('Louis Vuitton', 'France', 'Luxury Goods', 75.00, 2024, 2034),
('TAG Heuer', 'Switzerland', 'Watches', 45.00, 2016, 2030),
('Moët Hennessy', 'France', 'Beverages', 55.00, 2021, 2030),
('American Express', 'USA', 'Financial Services', 65.00, 2023, 2030),
('PepsiCo', 'USA', 'Food & Beverage', 60.00, 2023, 2030),
('Crypto.com', 'Singapore', 'Cryptocurrency', 100.00, 2021, 2030),
('Standard Chartered', 'UK', 'Banking', 50.00, 2010, 2030),
('Santander', 'Spain', 'Banking', 40.00, 2007, 2025),
('Globant', 'Argentina', 'IT Services', 25.00, 2021, 2026),
('Allwyn', 'Czech Republic', 'Lottery / Gaming', 35.00, 2024, 2030),
('PwC', 'UK', 'Consulting', 30.00, 2023, 2028),
('Nestlé', 'Switzerland', 'Food & Beverage', 70.00, 2022, 2030),
('Barilla', 'Italy', 'Food (Pasta)', 20.00, 2023, 2028),
('Las Vegas Convention & Visitors Authority', 'USA', 'Tourism', 25.00, 2023, 2028),
('Liqui Moly', 'Germany', 'Lubricants', 18.00, 2019, 2025),
('Paramount+', 'USA', 'Streaming', 40.00, 2023, 2026),
('Puma', 'Germany', 'Sportswear', 30.00, 2024, 2030),
('Tata Communications', 'India', 'Telecom', 55.00, 2012, 2028),
('Aggreko', 'UK', 'Energy Solutions', 22.00, 2017, 2026),
('McDonald''s', 'USA', 'Fast Food', 85.00, 2023, 2030),
('T-Mobile', 'Germany', 'Telecommunications', 45.00, 2023, 2028);

--* 15. media broadcasters
INSERT INTO media_broadcast_partners
(partner_name, country, deal_value_million, contract_start, contract_end)
VALUES
('Sky Sports', 'UK', 1200.00, 2019, 2029),
('ESPN', 'USA', 90.00, 2018, 2025),
('Apple TV+', 'USA', 700.00, 2026, 2030),
('DAZN', 'Spain', 70.00, 2021, 2026),
('Canal+', 'France', 100.00, 2021, 2029),
('Servus TV', 'Austria', 25.00, 2021, 2026),
('ORF', 'Austria', 20.00, 2021, 2026),
('Sky Deutschland', 'Germany', 85.00, 2021, 2027),
('Viaplay', 'Netherlands', 60.00, 2022, 2029),
('beIN Sports', 'Qatar', 80.00, 2016, 2028),
('FanCode', 'India', 30.00, 2024, 2028),
('SuperSport', 'South Africa', 35.00, 2019, 2026),
('TSN', 'Canada', 40.00, 2019, 2026),
('RDS', 'Canada', 35.00, 2019, 2026),
('Bandeirantes', 'Brazil', 30.00, 2021, 2025);

--& F1 prize money
INSERT INTO f1_prize_money 
(constructor_id, position_bonus_million, heritage_bonus_million, long_standing_bonus_million)
VALUES
(1, 152.00, 90.00, 35.00),
(2, 142.00, 82.00, 72.00),
(3, 148.00, 65.00, 30.00),
(4, 165.00, 28.00, 12.00),
(5, 132.00, 18.00, 8.00),
(6, 125.00, 12.00, 5.00),
(7, 115.00, 12.00, 5.00),
(8, 118.00, 8.00, 5.00),
(9, 112.00, 5.00, 0.00),
(10, 108.00, 12.00, 5.00),
(11, 102.00, 8.00, 5.00);