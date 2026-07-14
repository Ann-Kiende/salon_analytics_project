SELECT * FROM AppointmentServices
SELECT * FROM RawSalonRecords

SELECT * FROM Clients
SELECT * FROM PaymentModes

SELECT * FROM Services
SELECT * FROM Appointments
SELECT * FROM NailTechs

-- Compare revenue by service - Normalize tables
SELECT
    rsr.AppointmentDate,
    c.ClientID,
    rsr.Tip,
    pm.PaymentModeID
FROM RawSalonRecords rsr
JOIN Clients c
    ON rsr.PhoneNumber = c.PhoneNumber
JOIN PaymentModes pm
    ON rsr.PaymentMode = pm.PaymentModeName