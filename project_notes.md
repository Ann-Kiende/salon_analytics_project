# Salon Analytics Project Notes

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

# Salon Analytics Project Notes

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
