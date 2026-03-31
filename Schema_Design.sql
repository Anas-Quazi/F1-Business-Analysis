
--! Formula one financial analysis project

--* Database Schema design
CREATE DATABASE IF NOT EXISTS F1_Business;
USE F1_Business;

--& Realtions
--^ Governing bodies
CREATE TABLE IF NOT EXISTS governing_bodies (
    governing_body_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    role VARCHAR(100),
    headquarters VARCHAR(100),
    founded_year YEAR,
    website VARCHAR(100)
);

--^ engine manufacturers
CREATE TABLE IF NOT EXISTS engine_suppliers (
    supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    supplier_name VARCHAR(100) NOT NULL,
    country VARCHAR(50) NOT NULL,
    category VARCHAR(50) DEFAULT 'Automotive'
);

--? constructor 
CREATE TABLE IF NOT EXISTS constructors (
    constructor_id INT AUTO_INCREMENT PRIMARY KEY,
    team_name VARCHAR(100) NOT NULL, 
    full_name VARCHAR(150),
    country VARCHAR(50) NOT NULL,
    constructor_budget_million DECIMAL(10,2),
    category VARCHAR(50) DEFAULT 'Constructor',
    engine_supplier_id INT,
    FOREIGN KEY (engine_supplier_id) REFERENCES engine_suppliers(supplier_id)
);

--todo junction table for engine supply contracts
CREATE TABLE IF NOT EXISTS engine_supply_contracts (
    supplier_id INT NOT NULL,
    constructor_id INT NOT NULL,
    supply_fee_million DECIMAL(10,2),
    is_external BOOLEAN DEFAULT TRUE,
    partnership_type VARCHAR(50) DEFAULT 'Engine',
    contract_start YEAR,
    contract_end YEAR,
    PRIMARY KEY (supplier_id, constructor_id),
    FOREIGN KEY (supplier_id) REFERENCES engine_suppliers(supplier_id),
    FOREIGN KEY (constructor_id) REFERENCES constructors(constructor_id)
);

--^ tyre supplier(s)
CREATE TABLE IF NOT EXISTS tyre_suppliers (
    supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    supplier_name VARCHAR(100) NOT NULL,
    country VARCHAR(50) NOT NULL,
    category VARCHAR(50) DEFAULT 'Automotive',
    partnership_type VARCHAR(50) DEFAULT 'Tyre Supplier',
    supply_fee_per_team_million DECIMAL(10,2),
    f1_sponsorship_fee_million DECIMAL(10,2),
    contract_start YEAR,
    contract_end YEAR
);

--todo alter constructor table for tyre supplier connection
ALTER TABLE constructors
ADD COLUMN tyre_supplier_id INT,
ADD FOREIGN KEY (tyre_supplier_id) REFERENCES tyre_supplierS(supplier_id);

--~ fuel supplier (connected to engine suppliers)
CREATE TABLE IF NOT EXISTS fuel_suppliers (
    supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    supplier_name VARCHAR(100) NOT NULL,
    country VARCHAR(50) NOT NULL,
    category VARCHAR(50) DEFAULT 'Energy',
    partnership_type VARCHAR(50) DEFAULT 'Fuel Supplier',
    supply_fee_million DECIMAL(10,2),
    contract_start YEAR,
    contract_end YEAR
);

--? connect engine manufacturers with fuel suppliers
ALTER TABLE engine_suppliers
ADD COLUMN fuel_supplier_id INT,
ADD COLUMN fuel_supply_fee_million DECIMAL(10,2),
ADD FOREIGN KEY (fuel_supplier_id) REFERENCES fuel_suppliers(supplier_id);

--^ drivers 
CREATE TABLE IF NOT EXISTS drivers (
    driver_id INT AUTO_INCREMENT PRIMARY KEY,
    driver_name VARCHAR(100) NOT NULL,
    country VARCHAR(50) NOT NULL,
    constructor_id INT NOT NULL,
    salary_million DECIMAL(10,2),
    contract_start YEAR,
    contract_end YEAR,
    FOREIGN KEY (constructor_id) REFERENCES constructors(constructor_id)
);

ALTER TABLE drivers
ADD COLUMN driver_role VARCHAR(50) DEFAULT 'Race Driver';

--^ Team management
CREATE TABLE IF NOT EXISTS team_management (
    management_id INT AUTO_INCREMENT PRIMARY KEY,
    constructor_id INT NOT NULL,
    principal_name VARCHAR(100) NOT NULL,
    principal_salary_million DECIMAL(10,2),
    management_cost_million DECIMAL(10,2),
    FOREIGN KEY (constructor_id) REFERENCES constructors(constructor_id)
);

--^ other expenses
CREATE TABLE IF NOT EXISTS factory_expenses (
    expense_id INT AUTO_INCREMENT PRIMARY KEY,
    constructor_id INT NOT NULL,
    factory_cost_million DECIMAL(10,2),      
    wind_tunnel_cost_million DECIMAL(10,2),  
    rd_cost_million DECIMAL(10,2),           
    logistics_cost_million DECIMAL(10,2),    
    total_expense_million DECIMAL(10,2),     
    FOREIGN KEY (constructor_id) REFERENCES constructors(constructor_id)
);

--~ Sponsors (Team)

--^ Title sponsor
CREATE TABLE IF NOT EXISTS title_sponsors (
    sponsor_id INT AUTO_INCREMENT PRIMARY KEY,
    sponsor_name VARCHAR(100) NOT NULL,
    country VARCHAR(50) NOT NULL,
    category VARCHAR(50),
    partnership_type VARCHAR(50) DEFAULT 'Title Sponsor',
    deal_value_million DECIMAL(10,2),
    contract_start YEAR,
    contract_end YEAR,
    constructor_id INT NOT NULL,
    FOREIGN KEY (constructor_id) REFERENCES constructors(constructor_id)
);

--^ Pricipal partners
CREATE TABLE IF NOT EXISTS principal_partners (
    sponsor_id INT AUTO_INCREMENT PRIMARY KEY,
    sponsor_name VARCHAR(100) NOT NULL,
    country VARCHAR(50) NOT NULL,
    category VARCHAR(50),
    partnership_type VARCHAR(50) DEFAULT 'Principal Partner',
    deal_value_million DECIMAL(10,2),
    contract_start YEAR,
    contract_end YEAR,
    constructor_id INT NOT NULL,
    FOREIGN KEY (constructor_id) REFERENCES constructors(constructor_id)
);

--^ Team Partners (all others)
CREATE TABLE IF NOT EXISTS team_partners (
    partner_id INT AUTO_INCREMENT PRIMARY KEY,
    partner_name VARCHAR(100) NOT NULL,
    country VARCHAR(50) NOT NULL,
    category VARCHAR(50),
    partnership_type VARCHAR(50) DEFAULT 'Team Partner',
    deal_value_million DECIMAL(10,2),
    contract_start YEAR,
    contract_end YEAR,
    constructor_id INT NOT NULL,
    FOREIGN KEY (constructor_id) REFERENCES constructors(constructor_id)
);

--~ sponsors (F1  level)
--^ Global partners
CREATE TABLE IF NOT EXISTS global_partners (
    partner_id INT AUTO_INCREMENT PRIMARY KEY,
    partner_name VARCHAR(100) NOT NULL,
    country VARCHAR(50) NOT NULL,
    category VARCHAR(50),
    partnership_type VARCHAR(50) DEFAULT 'Global Partner',
    deal_value_million DECIMAL(10,2),
    contract_start YEAR,
    contract_end YEAR
);

--^ official suppliers 
CREATE TABLE IF NOT EXISTS official_suppliers (
    supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    supplier_name VARCHAR(100) NOT NULL,
    country VARCHAR(50) NOT NULL,
    category VARCHAR(50),
    partnership_type VARCHAR(50) DEFAULT 'Official Supplier',
    deal_value_million DECIMAL(10,2),
    contract_start YEAR,
    contract_end YEAR
);
 
--^ media broadcasters
CREATE TABLE IF NOT EXISTS media_broadcast_partners (
    partner_id INT AUTO_INCREMENT PRIMARY KEY,
    partner_name VARCHAR(100) NOT NULL,
    country VARCHAR(50) NOT NULL,
    category VARCHAR(50) DEFAULT 'Media',
    partnership_type VARCHAR(50) DEFAULT 'Broadcast Partner',
    deal_value_million DECIMAL(10,2),
    contract_start YEAR,
    contract_end YEAR
);

--~ prize money distribution
CREATE TABLE IF NOT EXISTS f1_prize_money (
    prize_id INT AUTO_INCREMENT PRIMARY KEY,
    constructor_id INT NOT NULL,
    position_bonus_million DECIMAL(10,2),
    heritage_bonus_million DECIMAL(10,2),
    long_standing_bonus_million DECIMAL(10,2),
    total_prize_million DECIMAL(10,2) GENERATED ALWAYS AS 
        (position_bonus_million + heritage_bonus_million + long_standing_bonus_million) STORED,
    FOREIGN KEY (constructor_id) REFERENCES constructors(constructor_id)
);
