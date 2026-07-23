# 🚀 Salon Analytics Project Roadmap

This document outlines the remaining milestones for completing the Salon Analytics Project and preparing for a Junior Data Analyst role.

The goal is not only to finish this project, but also to become confident in designing databases, writing SQL, building dashboards, and communicating business insights.

---

# ✅ Current Project Status

## Database Design

- [x] Designed normalized database
- [x] Created SQL Server tables
- [x] Built staging table
- [x] Implemented ETL pipeline
- [x] Cleaned inconsistent data
- [x] Handled NULL and placeholder values
- [x] Rebuilt Clients table using PhoneNumber as the business key
- [x] Populated normalized tables
- [x] Reconciled normalized revenue with the source dataset
- [x] Validated ETL results

---

## Business Questions Completed

- [x] Revenue per Nail Technician
- [x] Most profitable service
- [x] Client Lifetime Value
- [x] Services generating the most revenue
- [x] Technician generating the most revenue
- [x] Technician performing the most services
- [x] Most loyal clients
- [x] Highest-spending clients
- [x] Most popular payment method
- [x] Highest revenue day
- [x] Market Basket Analysis (Services bought together)
- [x] Clients receiving the most services
- [x] Clients who haven't returned in 60 days
- [x] Technician receiving the highest average tip
- [x] Average spend per appointment
- [x] Average number of services per appointment

---

# 📌 Remaining Business Questions

Complete these before moving to reporting.

- [ ] Monthly revenue trend
- [ ] Monthly appointment trend
- [ ] Revenue by weekday vs weekend
- [ ] Average revenue per client
- [ ] Revenue contribution (%) by each service
- [ ] Revenue contribution (%) by each technician

---

# 📖 SQL Topics to Learn

## 1. SQL Views

Learn:

- CREATE VIEW
- ALTER VIEW
- DROP VIEW

Create:

- [ ] vw_ClientLifetimeValue
- [ ] vw_ServiceRevenue
- [ ] vw_TechnicianPerformance
- [ ] vw_MonthlyRevenue
- [ ] vw_ClientAppointments

---

## 2. Stored Procedures

Learn:

- CREATE PROCEDURE
- ALTER PROCEDURE
- EXEC
- Parameters

Create:

- [ ] usp_GetTopClients
- [ ] usp_GetRevenueByMonth
- [ ] usp_GetClientHistory

---

## 3. Indexes

Learn:

- Clustered Indexes
- Non-clustered Indexes

Practice:

- [ ] Create indexes
- [ ] Compare query performance before and after indexing

---

## 4. Window Functions

Learn:

- [ ] ROW_NUMBER()
- [ ] RANK()
- [ ] DENSE_RANK()
- [ ] NTILE()
- [ ] SUM() OVER()
- [ ] AVG() OVER()
- [ ] COUNT() OVER()
- [ ] LEAD()
- [ ] LAG()

Rewrite existing business questions using Window Functions where appropriate.

---

## 5. Common Table Expressions (CTEs)

Learn:

- WITH

Practice rewriting existing queries using CTEs.

---

## 6. Transactions

Learn:

- BEGIN TRANSACTION
- COMMIT
- ROLLBACK

Understand when and why transactions are used.

---

# 📊 Dashboard Development

Learn Power BI.

Connect Power BI directly to SQL Server.

Build the following dashboards.

## Executive Dashboard

- [ ] Total Revenue
- [ ] Total Appointments
- [ ] Total Clients
- [ ] Average Appointment Value

---

## Revenue Dashboard

- [ ] Revenue by Month
- [ ] Revenue by Week
- [ ] Revenue by Day
- [ ] Revenue by Payment Method

---

## Technician Dashboard

- [ ] Revenue by Technician
- [ ] Services Completed
- [ ] Average Tip
- [ ] Revenue Contribution

---

## Client Dashboard

- [ ] Highest Spending Clients
- [ ] Client Lifetime Value
- [ ] Returning Clients
- [ ] Inactive Clients

---

## Service Dashboard

- [ ] Revenue by Service
- [ ] Most Popular Services
- [ ] Market Basket Analysis

---

# 📝 Documentation

## README

Improve README by adding:

- [ ] ER Diagram
- [ ] Dashboard Screenshots
- [ ] SQL Folder Structure
- [ ] ETL Workflow
- [ ] Architecture Overview

---

## Project Notes

Continue documenting:

- Engineering challenges
- Root causes
- Solutions
- Lessons learned

---

# 💼 Portfolio Preparation

## GitHub

- [ ] Final repository cleanup
- [ ] Organize SQL scripts
- [ ] Add screenshots
- [ ] Improve repository structure

---

## Resume

Update resume with:

- SQL Server
- Database Normalization
- ETL
- Docker
- Git
- Data Cleaning
- Business Analytics
- Power BI

---

## LinkedIn

- [ ] Update headline
- [ ] Add Salon Analytics Project
- [ ] Add GitHub repository
- [ ] Showcase Power BI dashboard

---

# 🎯 Job Applications

After completing the dashboard:

- [ ] Update resume
- [ ] Polish LinkedIn
- [ ] Apply for Junior Data Analyst roles
- [ ] Continue improving SQL skills while interviewing

---

# 🌟 Future Portfolio Projects

After this project, build projects in different industries.

Ideas:

- [ ] Retail Sales Analytics
- [ ] Hospital Analytics
- [ ] Banking Analytics
- [ ] E-commerce Analytics
- [ ] Hotel Booking Analytics

---

# 📚 Learning Order

1. Finish remaining business questions
2. Learn SQL Views
3. Learn Stored Procedures
4. Learn Indexes
5. Learn Window Functions
6. Learn Common Table Expressions (CTEs)
7. Learn Transactions
8. Learn Power BI
9. Build Dashboard
10. Improve README
11. Final GitHub polish
12. Update Resume
13. Update LinkedIn
14. Apply for Junior Data Analyst roles
15. Start Project 2

---

# 🎯 Final Goal

Build a portfolio that demonstrates the complete analytics workflow:

Raw Data
→ Data Cleaning
→ ETL
→ Database Design
→ SQL Analysis
→ Business Insights
→ Dashboard Development
→ Technical Documentation
→ GitHub Portfolio

The objective is not just to learn SQL, but to become capable of solving real business problems using data.
