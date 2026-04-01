# 🏎️📊 F1 Business Analysis
### A Relational Database Project | MySQL | 2026 Season

> Modelling the financial ecosystem of Formula 1 — from title sponsorships and engine supply deals to driver contracts and factory expenses — using relational database design and advanced SQL analysis.

---

## 📌 Overview

Formula 1 is not just a sport — it is a multi-billion dollar business ecosystem. Each constructor operates as a commercial enterprise, managing relationships with engine suppliers, fuel partners, title sponsors, global partners, and a roster of high-value drivers.

This project builds a normalized relational database to represent those relationships, populated with realistic data from the 2026 F1 season, and uses SQL to extract meaningful business insights across the grid.

---

<img width="700" height="300" alt="image" src="https://github.com/user-attachments/assets/0222735e-05a2-4655-873a-60f0e3ccc90d" />

## 🔄 Project Pipeline

| Stage | Description | File |
|---|---|---|
| 📌 Problem Domain | Map F1 commercial ecosystem — teams, sponsors, suppliers, contracts | — |
| 🗃️ Schema Design | Design normalized relational database with 16 tables and 1 VIEW | `schema_design.sql` |
| 🔍 Data Collection | Research real 2026 F1 season data from Forbes, Motorsport Week, RacingNews365 | — |
| 💻 Data Insertion | Populate all tables with realistic financial and partnership data | `data_insertion.sql` |
| 📊 Analysis & Insights | Business insight queries using JOINs, window functions, aggregations | `analysis\` |

---

## 📁 Project Structure

```
F1-Business-Analysis/
│
├── schema_design.sql          # CREATE TABLE statements for all 17 tables 
├── data_insertion.sql         # INSERT statements with real 2026 F1 season data
│
├── analysis/
│   ├── 01_foundation_views.sql      # Base VIEWs (team_finance ,sponsorship_revenue, expense_breakdown)
│   ├── 02_revenue_sponsorship.sql   # Revenue & sponsorship analysis queries
│   ├── 03_cost_profitability.sql    # Cost, expenses & net profit queries
│   ├── 04_driver_economics.sql      # Driver salaries, contracts & ROI
│   ├── 05_supplier_network.sql      # Engine, fuel, tyre supplier analysis
│   ├── 06_factory_efficiency.sql    # Factory costs & operational efficiency
│   ├── 07_window_functions.sql      # Rankings, cumulative & percentile analysis
│   └── 08_strategic_insights.sql   # M&A value, risk heatmap, dream team etc.
│
├── assets/
│   └── schema_diagram.png     # ER diagram
│
├── README.md                  # Project documentation
└── .gitignore                 # Ignored files
```

---

## 🗃️ Database Design

The `constructors` table serves as the **central entity**. Every other table references it via a `constructor_id` foreign key, reflecting how all commercial relationships in F1 revolve around the team.

| Table | Description |
|---|---|
| `constructors` | All 11 F1 teams — name, nationality, headquarters |
| `drivers` | Driver roster, salaries, and contract durations |
| `team_management` | Principals and team management expenses |
| `engine_suppliers` | Engine supply agreements and annual fees |
| `fuel_suppliers` | Fuel and lubricant partnerships |
| `tyre_suppliers` | tyre supplier partnership |
| `title_sponsors` | Primary commercial sponsors and deal values |
| `team partners` | other partner companies |
| `factory_expenses` | Annual operational costs broken down by category |
| `governing bodies` | governing and organizing bodies |
| `global_partners` | sponsorship for goevrning bodies |

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

Analysis is organized across **8 sections** in the `analysis/` folder:

**💰 Revenue & Sponsorship Analysis**

**📉 Cost & Profitability Analysis**

**🏎️ Driver & Talent Economics**

**🔧 Supplier & Partnership Network**

**🏭 Factory & Operational Efficiency**

**🌐 Window Function Analysis**

**🎯 Strategic Business Insights**

---

## 📝 Data Notes

Financial figures — including sponsorship deal values, engine supply fees, driver 
salaries, and operational costs — are based on publicly available estimates and 
approximations sourced from **Forbes**, **Motorsport Week**, **RacingNews365**, and 
**official team websites**. Exact figures are not publicly disclosed by teams or 
commercial partners. Data accuracy is estimated at **70–80%** and is intended for 
analytical and educational purposes only.

All data reflects the **2026 Formula 1 season**.

---

## 🛠️ Tools & Concepts

| Category | Details |
|---|---|
| **Database** | MySQL 8.0 |
| **Schema Design** | Normalization, primary keys, foreign keys, composite keys, constraints, ALTER TABLE |
| **Data Manipulation** | DDL (CREATE, DROP, ALTER), DML (INSERT, UPDATE) |
| **Querying** | INNER JOIN, LEFT JOIN, GROUP BY, HAVING, UNION ALL, subqueries, COALESCE, NULLIF |
| **Advanced SQL** | Window functions — RANK(), SUM() OVER(), NTILE(), ROW_NUMBER(), cumulative aggregates |
| **Views** | CREATE VIEW, foundation views, nested views |
| **Business Analysis** | Revenue vs expense modelling, partner network mapping, risk analysis, M&A valuation |
| **Tools Used** | MySQL Workbench, Luna Modeler, VS Code, Git & GitHub |
| **AI Assistant** | Claude (Anthropic) — schema design guidance, query logic, data research |

---

## 👤 Author

Developed independently as part of a **Data Science Internship** project.  
Designed to demonstrate end-to-end relational database skills — from schema design to business insight generation.
