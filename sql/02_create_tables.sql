
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
    PhoneNumber VARCHAR(20) NOT NULL
)

-- Appointments Table

CREATE TABLE Appointments (
    AppointmentID INT IDENTITY(1,1) PRIMARY KEY,
    AppointmentDate DATE NOT NULL,
    ClientID INT NOT NULL,
    Tip INT DEFAULT 0,
    PaymentModeID INT NOT NULL

    FOREIGN KEY (ClientID) REFERENCES Clients(ClientID),
    FOREIGN KEY (PaymentModeID) REFERENCES PaymentModes(PaymentModeID)
)

-- AppointmentServices Table

CREATE TABLE AppointmentServices (
    AppointmentServiceID INT IDENTITY(1,1) PRIMARY KEY,

    AppointmentID INT NOT NULL,
    ServiceID INT NOT NULL,
    ServiceAmount INT NOT NULL,
    NailTechID INT NOT NULL,

    FOREIGN KEY (AppointmentID)
        REFERENCES Appointments(AppointmentID),

    FOREIGN KEY (ServiceID)
        REFERENCES Services(ServiceID),

    FOREIGN KEY (NailTechID)
        REFERENCES NailTechs(NailTechID)
);