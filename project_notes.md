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

## Issue 6: Eliminating redundant column

### Problem

Amount of each service was redundant as it was appearing in multiple tables: Appointments and AppointmentServices

### Learning

To be able to clean and analyze data with high optimization, Amount column in Appointments table was dropped.
