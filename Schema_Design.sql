
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
)

--? constructor 
CREATE TABLE IF NOT EXISTS constructors (
    constructor_id INT AUTO_INCREMENT PRIMARY KEY,
    teamName VARCHAR(100) NOT NULL, 
    fullName VARCHAR(150),
    nationality VARCHAR(50) NOT NULL,
    founded_year YEAR,
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

