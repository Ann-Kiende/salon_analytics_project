# Salon Analytics Project Notes

This document records the real engineering and data challenges encountered while designing and building the Salon Analytics Project. Each issue documents:

- the business or technical problem,
- how it was investigated,
- the solution implemented,
- and the SQL or database concepts learned.

Rather than only presenting the final solution, these notes capture the reasoning and decisions made throughout the project.

## Table of Contents

### Project Overview

- Project Statistics

### Data Modeling & ETL

- Issue 1: Multiple services per appointment
- Issue 2: Raw CSV date import failure
- Issue 3: Inconsistent date formats
- Issue 4: Data cleaning for missing values
- Issue 5: Empty string vs NULL
- Issue 6: Revenue stored in the wrong table
- Issue 7: Appointment schema did not reflect business reality
- Issue 8: ETL revealed hidden business rules
- Issue 9: Composite key did not match real salon transactions

### Engineering Lessons

- Issue 10: Removing sensitive data from Git history
- Issue 11: Inconsistent client names
- Issue 12: Identity values do not reset after DELETE
- Issue 13: Revenue reconciliation after normalization

### Business Analytics

- Issue 14: Market Basket Analysis using Self Joins

## Project Overview

### Dataset Statistics

- Raw records: 1,276
- Clients: 371
- Services: 22
- Appointments: 836
- Nail technicians: 3
- Total Revenue: Ksh. 947,205

### Database

- SQL Server
- Docker
- DataGrip

### Current Status

- ✔ Database normalized to 3NF
- ✔ ETL pipeline completed
- ✔ Revenue fully reconciled
- ✔ Business questions implemented

## Issue 1: Multiple services per appointment

### Problem

Initial Appointments table contained ServiceID, which assumed one appointment could only have one service.

### Discovery

Real salon data showed a single appointment may include multiple services.

### Solution

Removed ServiceID from Appointments table and created AppointmentServices junction table.

### Concept Learned

Many-to-many relationships and composite primary keys.

---

## Issue 2: Raw CSV date import failure

### Problem

DataGrip import failed when loading AppointmentDate as DATE.

Example:
03 Jan 2026

### Cause

The CSV date format did not match SQL Server's expected date format during import.

### Solution

Changed AppointmentDate in RawSalonRecords staging table from DATE to VARCHAR(20) and imported raw values first.

### Concept Learned

Staging tables should mirror source data and not enforce strict typing too early.

---

## Issue 3: Inconsistent date formats

### Problem

Raw data contained:
03 Jan 2026
03 Jan 26

### Solution

Use TRY_CONVERT during transformation and identify rows that fail conversion before loading into production tables.

### Concept Learned

Real-world data is rarely perfectly consistent and requires validation before loading.

## Issue 4: Data cleaning for missing or placeholder values

### Problem

Some records contained placeholder values:

- ClientName = '--'
- PhoneNumber = '--'

This caused issues for building a proper Clients table with UNIQUE constraints on PhoneNumber.

### Solution

All placeholder values were replaced with:

- ClientName → "Walk-In Client"
- PhoneNumber → "Unknown"

This ensured:

- No violation of UNIQUE constraints
- No loss of transactional data
- Walk-in customers are still included in analysis

---

## Issue 5: Understanding empty string vs NULL in SQL

### Problem

During data insertion, filtering conditions included:

```sql
PhoneNumber IS NOT NULL
PhoneNumber <> ''
```

### Insight

SQL treats missing data in two ways:

- NULL → value does not exist
- '' → value exists but is empty

Both must be filtered to ensure clean inserts into production tables.

### Learning

Data cleaning must account for both NULL and empty string values, especially when importing from CSV/Excel sources.

---

## Issue 6: Revenue stored in the wrong table

### Problem

The Amount column existed in both Appointments and AppointmentServices.

This created redundancy because service revenue was being stored in two places.

### Discovery

A single appointment can contain multiple services, each with its own price.

Example:

- Builder Gel = 1000
- Nail Art = 300

Appointment total = 1300

The revenue belongs to the services performed, not the appointment itself.

### Solution

Removed Amount from Appointments and stored service revenue in AppointmentServices using the ServiceAmount column.

### Concept Learned

A fact should be stored in one place whenever possible to reduce redundancy and avoid update anomalies.

---

## Issue 7: Appointment schema did not reflect business reality

### Problem

The original schema assumed:

- One appointment → One service
- One appointment → One nail technician

However, real salon data showed:

- One appointment can contain multiple services
- One appointment can be handled by multiple nail technicians

### Discovery

Analysis of RawSalonRecords showed:

- 1276 service records
- 836 unique appointments

This confirmed that services and appointments are different business entities.

### Solution

Redesigned the schema:

Appointments

- AppointmentID
- AppointmentDate
- ClientID
- Tip
- PaymentModeID

AppointmentServices

- AppointmentID
- ServiceID
- ServiceAmount
- NailTechID

This allows multiple services and multiple nail technicians to be associated with a single appointment.

### Concept Learned

Database design should model the real business process rather than forcing the business process to fit the database structure.

---

## Issue 8: ETL revealed hidden business rules

### Problem

Initial assumptions suggested that each row in the spreadsheet represented one appointment.

### Discovery

Inspection of the data showed that each row actually represented one service performed.

Multiple rows could belong to the same customer visit.

### Solution

Used grouping logic during ETL to identify unique appointments separately from individual services.

### Concept Learned

Understanding the grain of the data is one of the most important steps in data modeling and analytics.

---

## Issue 9: Composite key did not match real salon transactions

### Problem:

AppointmentServices used a composite primary key
(AppointmentID, ServiceID).

### Discovery:

Real payment data showed the same service could appear
multiple times within a single appointment.

Examples:

- Client pays for herself and another person.
- Same service performed multiple times during one visit.

### Solution:

Replaced composite primary key with
AppointmentServiceID surrogate key.

### Concept Learned:

A database key should reflect real-world uniqueness,
not assumptions about how data should behave.

## Issue 10: Removing sensitive data from Git history

### Problem

During development, real client phone numbers and employee names were committed to Git as commented examples. Although they were not used by the SQL queries, they became part of the repository history.

### Risk

Simply deleting or editing the latest version of the file does not remove sensitive information from previous Git commits. Anyone with access to the repository history can still retrieve the deleted data.

### Solution

Used an interactive Git rebase to rewrite the affected commits, removed the sensitive comments, amended the commits, and updated the remote repository with the cleaned history.

### Concept Learned

Git records the complete history of a project. Removing sensitive information requires rewriting the commit history rather than only editing the latest version of a file.

### Best Practice Going Forward

- Never commit real client or employee information to a public repository.
- Use anonymized or synthetic sample data when demonstrating SQL projects.
- Review staged changes before every commit using:

```bash
git diff --staged
```

to verify that no sensitive information is being committed.

## Issue 11: Inconsistent client names

### Problem

The same client appeared multiple times with different spellings or name formats while using the same phone number.
Examples:
Jane Wangechi
Jane Wangeci
Jane Wangeci Njane

### Cause

Client names were entered manually, resulting in inconsistent spelling and varying levels of detail.

### Solution

Treat PhoneNumber as the unique client identifier during ETL and consolidate duplicate records into a single client record.

### Concept Learned

In real-world datasets, natural identifiers such as names are often unreliable. Selecting an appropriate business key (in this case, PhoneNumber) is essential for accurate deduplication and maintaining data quality.

## Issue 12: Identity values do not reset after DELETE

### Problem

After deleting all rows from tables with IDENTITY columns, newly inserted records continued from the previous identity value instead of restarting at 1.

### Cause

In SQL Server, DELETE removes rows but does not reset the identity seed.
Solution

### Used:

DBCC CHECKIDENT ('TableName', RESEED, 0);
to reset the identity seed after clearing the table.

### Concept Learned

DELETE removes data, while TRUNCATE removes data and resets identity values. However, TRUNCATE cannot be used on tables referenced by foreign key constraints, making DELETE followed by DBCC CHECKIDENT the appropriate approach when rebuilding related tables.

## Issue 13: Revenue reconciliation after normalization

### Problem

After populating the normalized tables, the total revenue no longer matched the source data.

| Source              | Total Revenue |
| ------------------- | ------------: |
| RawSalonRecords     |  Ksh. 947,205 |
| AppointmentServices |  Ksh. 891,265 |

A total of Ksh. 55,940 was missing after the transformation.

### Investigation

To isolate the problem, revenue was compared at multiple levels:

- Overall revenue
- Revenue per service
- Total row counts between tables

Although both RawSalonRecords and AppointmentServices contained 1,276 rows, several services showed lower revenue after normalization.

This indicated that rows were not being lost, but some records were being linked to the wrong appointments during the transformation process.

### Root Cause

The Clients table had been rebuilt using one record per unique phone number, selecting a single client name with:

MAX(ClientName)

However, the ETL process continued joining RawSalonRecords to Clients using both:

- ClientName
- PhoneNumber

Because the raw data contained inconsistent client names for the same phone number (for example, "Jane Wangechi", "Jane Wangeci", and "Jane Wangeci Njane"), some records were linked incorrectly during the transformation.

### Solution

The ETL process was updated to use PhoneNumber as the business key when joining to the Clients table.

The Appointments table was then rebuilt before repopulating AppointmentServices.

Additional validation included:

- Comparing total row counts
- Comparing total revenue
- Comparing revenue by service
- Verifying the transformed dataset before inserting into production tables

### Result

Revenue reconciliation was successfully completed.

| Table               | Total Revenue |
| ------------------- | ------------: |
| RawSalonRecords     |  Ksh. 947,205 |
| AppointmentServices |  Ksh. 947,205 |

The normalized database now preserves 100% of the source revenue.
Concepts Learned

- Data reconciliation
- ETL validation
- Identifying the correct business key
- Importance of validating transformations before loading
- Using aggregate comparisons to detect transformation errors

## Issue 14: Market Basket Analysis using Self Joins

### Problem

The business needed to identify which salon services are frequently purchased together during the same appointment. This information can be used to:

- Create bundled service packages
- Recommend complementary services to clients
- Design targeted promotions
- Better understand customer purchasing behaviour

### Challenge

Each appointment may contain multiple services stored as separate rows in the `AppointmentServices` table. The challenge was comparing every service within the same appointment without creating duplicate combinations such as:

```sql
Builder Gel + Pedicure
Pedicure + Builder Gel
```

or pairing a service with itself.

### Solution

Used a self join on the `AppointmentServices` table to compare services belonging to the same appointment.

The join condition:

```sql
aps1.AppointmentID = aps2.AppointmentID
```

ensures that only services from the same appointment are compared.

The additional condition:

```sql
aps1.ServiceID < aps2.ServiceID
```

eliminates duplicate combinations and prevents a service from being paired with itself.

The resulting service pairs were then grouped and counted to determine how frequently each combination occurs.

### Concepts Learned

- Self joins
- Market Basket Analysis
- Customer purchasing behaviour analysis
- Eliminating duplicate pairs using comparison operators
- Using COUNT() and GROUP BY for frequency analysis
