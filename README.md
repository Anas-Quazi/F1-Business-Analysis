# 🏎️📊 F1 Business Analysis
### A Relational Database Project | MySQL | 2024 Season

> Modelling the financial ecosystem of Formula 1 — from title sponsorships and engine supply deals to driver contracts and factory expenses — using relational database design and advanced SQL analysis.

---

## 📌 Overview

Formula 1 is not just a sport — it is a multi-billion dollar business ecosystem. Each constructor operates as a commercial enterprise, managing relationships with engine suppliers, fuel partners, technology sponsors, AI partners, and a roster of high-value drivers.

This project builds a normalized relational database to represent those relationships, populated with realistic data from the 2024 F1 season, and uses SQL to extract meaningful business insights across the grid.

---

## 📁 Project Structure

```
f1_business_analysis/
│
├── schema_design.sql       # Entity definitions and relational constraints
├── data_insertion.sql      # Realistic 2024 season data for all 10 constructors
├── analysis.sql            # Business insight queries (JOINs, aggregations, window functions)
└── README.md               # Project documentation
```

---

## 🗃️ Database Design

The `constructors` table serves as the **central entity**. Every other table references it via a `constructor_id` foreign key, reflecting how all commercial relationships in F1 revolve around the team.

| Table | Description |
|---|---|
| `constructors` | All 10 F1 teams — name, nationality, headquarters |
| `drivers` | Driver roster, salaries, and contract durations |
| `team_principal` | Principal per constructor with compensation |
| `engine_suppliers` | Engine supply agreements and annual fees |
| `fuel_suppliers` | Fuel and lubricant partnerships |
| `title_sponsors` | Primary commercial sponsors and deal values |
| `tech_sponsors` | Technology partners (hardware, software, infrastructure) |
| `ai_partners` | AI and cloud computing partnerships |
| `factory_expenses` | Annual operational costs broken down by category |

---

## 📑 Schema Diagram

<img src="Diagrams/schema _diagram.jpg" alt="Schema Diagram" width="700">

---

## ⚙️ How to Run

Execute the files in the following order:

**1️⃣ Set up the database**
```sql
CREATE DATABASE f1_business;
USE f1_business;
```

**2️⃣ Create the schema**
```sql
SOURCE schema_design.sql;
```

**3️⃣ Insert the data**
```sql
SOURCE data_insertion.sql;
```

**4️⃣ Run the analysis**
```sql
SOURCE analysis.sql;
```

---

## 📊 Business Insights Covered

The `analysis.sql` file is designed to answer real business questions, including:

- 💰 Which constructor generates the highest total sponsorship revenue?
- 🔧 Which engine supplier powers the most cars on the grid?
- 📈 What is each team's estimated net profit/loss (total revenue vs. total expenses)?
- 🌐 Which company has commercial partnerships with the most constructors?
- 👨‍✈️ Which team carries the highest combined driver and principal payroll?
- 📅 Which sponsorship or supply contracts are due to expire this season?
- 🏆 How do teams rank by total partnership value using window functions?

---

## 📝 Data Notes

Financial figures — including sponsorship deal values, engine supply fees, driver salaries, and operational costs — are approximations based on publicly available estimates from sources such as **Forbes**, **Motorsport Week**, and **RacingNews365**. Official figures are not publicly disclosed by teams or commercial partners.

All data reflects the **2024 Formula 1 season**.

---

## 🛠️ Tools & Concepts

| Category | Details |
|---|---|
| **Database** | MySQL |
| **Schema Design** | Normalization, primary keys, foreign keys, constraints |
| **Data Manipulation** | DDL (CREATE, DROP), DML (INSERT, UPDATE) |
| **Querying** | INNER JOIN, LEFT JOIN, GROUP BY, HAVING, subqueries |
| **Advanced SQL** | Window functions — RANK(), SUM() OVER(), ROW_NUMBER() |
| **Business Analysis** | Revenue vs. expense modelling, partner network mapping |

---

## 👤 Author

Developed independently as part of a **Data Science Internship** project.  
Designed to demonstrate end-to-end relational database skills — from schema design to business insight generation.
