
-- PaymentModes Table

CREATE TABLE PaymentModes (
    PaymentModeID INT IDENTITY(1,1) PRIMARY KEY,
    PaymentModeName VARCHAR(50) NOT NULL
);

INSERT INTO PaymentModes (PaymentMode)
    VALUES
        ('Paybill'),
        ('Cash'),
        ('Mpesa'),
        ('Till'),
        ('Owner Perks'),
        ('Card');


-- NailTechs Table

CREATE TABLE NailTechs(
    NailTechID INT IDENTITY (1,1) PRIMARY KEY,
    NailTechName VARCHAR(100) NOT NULL
)

-- Services Table

CREATE TABLE Services(
    ServiceID INT IDENTITY (1,1) PRIMARY KEY,
    ServiceName VARCHAR(100) NOT NULL
)

-- Clients Table

CREATE TABLE Clients(
    ClientID INT IDENTITY (1,1) PRIMARY KEY,
    ClientName VARCHAR(100) NOT NULL,
    PhoneNumber VARCHAR(20)
)