-- Insert values PaymentModes

INSERT INTO PaymentModes (PaymentMode)
    VALUES
        ('Paybill'),
        ('Cash'),
        ('Mpesa'),
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