<!-- See all tables in Salon Database in SQL Server DataGrip -->

SELECT name
FROM sys.tables
ORDER BY name

<!-- Checking SQL server environment variables: using terminal -->

docker inspect <container_name>

<!-- Rename a column name is SQL Server -->

Syntax: EXEC sp_rename 'YourTableName.OldColumnName', 'NewColumnName', 'COLUMN';

Example:
EXEC sp_rename 'Appointments.AppointmentsID', 'AppointmentID', 'COLUMN'

sp_rename: system stored procedure

<!-- Left Join Syntax -->

SELECT columns
FROM left_table
LEFT JOIN right_table ON
join_condition;

<!-- How to find constraint name, that is, foreign keys -->

Syntax:
SELECT name
FROM sys.foreign_keys
WHERE parent_object_id = OBJECT_ID('YourTableName');

Example:
SELECT name
FROM sys.foreign_keys
WHERE parent_object_id = OBJECT_ID('Appointments')

<!-- ALTER a table AppointmentServices and add a FOREIGN KEY Constraint -->

ALTER TABLE AppointmentServices
ADD NailTechID INT NOT NULL
CONSTRAINT FK_AppointmentServices_NailTechs
FOREIGN KEY (NailTechID) REFERENCES NailTechs(NailTechID)

<!-- How to find the data type of a column -->

SELECT
COLUMN_NAME,
DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='Clients'
