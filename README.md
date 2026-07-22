# 💅 Salon Analytics Project

An end-to-end SQL Server data analytics project built using real salon transaction data.

This project demonstrates the complete data analytics workflow—from cleaning raw transactional data and designing a normalized relational database to answering real business questions using SQL.

---

# 📌 Project Overview

The objective of this project was to transform raw salon transaction records into a well-structured SQL Server database capable of generating meaningful business insights.

The project focuses on:

- Data cleaning
- Database normalization
- ETL (Extract, Transform, Load)
- Business analytics
- SQL reporting
- Technical documentation

---

# 📊 Dataset Overview

Source: Real salon transaction records collected from Google Sheets.

| Metric           |       Value |
| ---------------- | ----------: |
| Raw Records      |       1,276 |
| Clients          |         371 |
| Appointments     |         836 |
| Services         |          22 |
| Nail Technicians |           3 |
| Total Revenue    | KSh 947,205 |

---

# 🛠 Technologies Used

- SQL Server 2022
- Docker
- DataGrip
- Git
- GitHub

---

# 🗄 Database Schema

The database was normalized to reduce redundancy and improve data integrity.

### Tables

- Clients
- Appointments
- AppointmentServices
- Services
- NailTechs
- PaymentModes

> **Note:** An ER Diagram will be added in a future update.

---

# 🔄 ETL Process

The ETL pipeline involved:

- Importing raw CSV data into a staging table
- Cleaning inconsistent client information
- Standardizing date formats
- Handling missing and placeholder values
- Building normalized production tables
- Validating transformed data against the original source
- Reconciling total revenue to ensure data integrity

---

# 📈 Business Questions Answered

The project answers several real business questions, including:

- Which payment method generates the most revenue?
- Which nail technician generates the highest revenue?
- Which nail technician performs the most services?
- Which technician receives the highest average tip?
- Which services generate the highest revenue?
- Which services are frequently purchased together? _(Market Basket Analysis)_
- Who are the highest-spending clients?
- Who are the most loyal clients?
- What is each client's lifetime value?
- What are the busiest days of the week?
- What are the slowest days of the month?
- What is the average appointment value?
- What is the average number of services per appointment?
- Which clients have not returned in the last 60 days?
- How much does the owner spend on perks each quarter?

---

# 🧠 SQL Concepts Demonstrated

Throughout this project, I applied:

- INNER JOIN
- LEFT JOIN
- SELF JOIN
- Aggregate Functions
- GROUP BY
- HAVING
- CASE Expressions
- Data Cleaning
- ETL Design
- Database Normalization
- Primary Keys
- Foreign Keys
- Composite Keys
- Data Validation
- Revenue Reconciliation

---

# 🏗 Engineering Challenges Solved

This project involved solving several real-world engineering problems, including:

- Modeling appointments with multiple services
- Handling inconsistent client names while preserving business rules
- Importing inconsistent date formats
- Eliminating redundant data during normalization
- Discovering hidden business rules through ETL
- Rebuilding normalized tables after identifying modeling issues
- Reconciling normalized revenue with the original dataset
- Removing sensitive client information from Git history
- Implementing Market Basket Analysis using SQL Self Joins

Each challenge and its solution is documented in **project_notes.md**.

---

# 📂 Project Structure

```
salon-analytics-project/

│
├── sql/
│   ├── 01_create_tables.sql
│   ├── 02_insert_reference_data.sql
│   ├── 03_load_clients.sql
│   ├── 04_load_appointments.sql
│   ├── 05_load_appointment_services.sql
│   ├── 06_validation_queries.sql
│   └── 07_answer_business_questions.sql
│
├── project_notes.md
├── questions.md
└── README.md
```

---

# 📚 Key Lessons Learned

This project significantly strengthened my understanding of:

- Relational database design
- SQL Server development
- ETL processes
- Data cleaning
- Business analytics
- Git version control
- Technical documentation
- Problem-solving using SQL

---

# 🚀 Future Improvements

Planned enhancements include:

- Build an interactive Power BI dashboard
- Create SQL Views for reporting
- Implement Stored Procedures
- Add indexes and compare query performance
- Automate parts of the ETL pipeline
- Add an ER Diagram to the repository

---

# 👩🏽‍💻 About This Project

Unlike many portfolio projects that start with already-clean data, this project documents the complete engineering process.

The repository captures not only the final SQL solution but also the challenges encountered during development, the reasoning behind design decisions, and the lessons learned while working with real-world transactional data.

The goal was not simply to answer business questions, but to build a robust, maintainable analytics database from raw operational data.

---

## ⭐ If you found this project interesting, feel free to explore the SQL scripts and project notes to see the complete development journey.
