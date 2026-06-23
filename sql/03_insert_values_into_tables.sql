-- Insert values PaymentModes

INSERT INTO PaymentModes (PaymentMode)
    VALUES
        ('Paybill'),
        ('Cash'),
        ('M-Pesa'),
        ('Till'),
        ('Owner Perks'),
        ('Card');

-- Insert values Services 

INSERT INTO Services (ServiceName)
    VALUES
        ('Gel'),
        ('Builder Gel'),
        ('Tips Gel'),
        ('Tips Builder Gel'),
        ('Tips Gum Gel'),
        ('Eyelashes'),
        ('Eyelashes Removal'),
        ('Pedicure'),
        ('Gum Gel'),
        ('Gum Gel Refill'),
        ('Top Coat'),
        ('Soak Off'),
        ('Eyebrows Razor'),
        ('Eyebrows Tweezing'),
        ('Nail Repair'),
        ('Acrylics'),
        ('Acrylics Refill'),
        ('Builder Gel Extensions'),
        ('Gum Gel Extensions'),
        ('Manicure'),
        ('Press Ons'),
        ('Eyelashes Repair');


-- Insert real data from staging RawSalonData to::::

-- NailTechs Table

INSERT INTO NailTechs (NailTechName)
SELECT DISTINCT NailTech
FROM RawSalonRecords
WHERE NailTech IS NOT NULL

-- Clients Table

INSERT INTO Clients(ClientName, PhoneNumber)
SELECT DISTINCT
    TRIM(ClientName),
    TRIM(PhoneNumber)
FROM RawSalonRecords
WHERE ClientName IS NOT NULL
  AND PhoneNumber IS NOT NULL
AND TRIM(ClientName) <> ''
AND TRIM(PhoneNumber) <> ''

-- Appointments Table
INSERT INTO Appointments(AppointmentDate, ClientID, Tip, PaymentModeID)

SELECT
    TRY_CONVERT(date, rs.AppointmentDate, 106) AS AppointmentDate,
    c.ClientID,
--     c.ClientName,
    MAX(ISNULL(Tip, 0)) AS Tip,
    p.PaymentModeID
FROM RawSalonRecords rs
JOIN Clients c
    ON TRIM(rs.ClientName) = c.ClientName
    AND TRIM(rs.PhoneNumber) = c.PhoneNumber
JOIN PaymentModes p
    ON rs.PaymentMode = p.PaymentModeName
GROUP BY
    TRY_CONVERT(date, rs.AppointmentDate, 106),
    c.ClientID,
    p.PaymentModeID

-- AppointmentServices Table
INSERT INTO AppointmentServices (
    AppointmentID,
    ServiceID,
    ServiceAmount,
    NailTechID
)
SELECT
    a.AppointmentID,
    s.ServiceID,
    rs.Amount,
    nt.NailTechID
FROM RawSalonRecords rs

JOIN Clients c
    ON TRIM(rs.ClientName) = c.ClientName
   AND TRIM(rs.PhoneNumber) = c.PhoneNumber

JOIN PaymentModes pm
    ON rs.PaymentMode = pm.PaymentModeName

JOIN Appointments a
    ON a.AppointmentDate = TRY_CONVERT(date, rs.AppointmentDate, 106)
   AND a.ClientID = c.ClientID
   AND a.PaymentModeID = pm.PaymentModeID

JOIN Services s
    ON TRIM(rs.ServiceName) = s.ServiceName

JOIN NailTechs nt
    ON TRIM(rs.NailTech) = nt.NailTechName;
