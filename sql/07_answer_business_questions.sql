-- 15. Monthly revenue trend // How much revenue did the business generate each month?

SELECT
    DATENAME(month, a.AppointmentDate) AS Month,
    SUM(aps.ServiceAmount) AS RevenuePM
FROM Appointments a
JOIN AppointmentServices aps
    ON a.AppointmentID = aps.AppointmentID
GROUP BY
    MONTH(a.AppointmentDate),
    DATENAME(month, a.AppointmentDate)
ORDER BY
    MONTH(a.AppointmentDate)

-- 17. Monthly appointments // How do appointment volumes vary by month?

SELECT
--     YEAR(AppointmentDate) AS Year,
    DATENAME(month, AppointmentDate) AS MonthNumber,
    COUNT(*) AS NumberOfAppointments
FROM Appointments
GROUP BY
--     YEAR(AppointmentDate),
    MONTH(AppointmentDate),
    DATENAME(month, AppointmentDate)
ORDER BY
    MONTH(AppointmentDate)
--     NumberOfAppointments


-- 11. Which services are often bought together (Market Basket Analysis)

SELECT
    s1.ServiceName AS Service1,
    s2.ServiceName AS Service2,
    COUNT(*) AS TimesBoughtTogether
FROM AppointmentServices aps1

JOIN AppointmentServices aps2
    ON aps1.AppointmentID = aps2.AppointmentID
    AND aps1.ServiceID < aps2.ServiceID

JOIN Services s1
    ON aps1.ServiceID = s1.ServiceID

JOIN Services s2
    ON aps2.ServiceID = s2.ServiceID

-- 3. How much has each client spent since becoming a customer?

SELECT
    c.ClientName,
    c.PhoneNumber,
    SUM(aps.ServiceAmount) AS LifetimeValue
FROM Appointments a
JOIN Clients c
    ON a.ClientID = c.ClientID
JOIN AppointmentServices aps
    ON a.AppointmentID = aps.AppointmentID
GROUP BY c.ClientName, c.PhoneNumber
ORDER BY LifetimeValue DESC

-- 17. Average number of services per appointment

SELECT
    AVG(CAST(ServiceCount AS DECIMAL(10, 2))) AS AvgServicesPerAppointment
    FROM
( SELECT
    AppointmentID,
    COUNT(*) AS ServiceCount
FROM AppointmentServices
GROUP BY AppointmentID ) AS AppointmentSummary

-- Compare revenue by service - Raw

SELECT
    ServiceName,
    COUNT(*) AS Rows,
    SUM(Amount) as Revenue
FROM RawSalonRecords
GROUP BY ServiceName
ORDER BY ServiceName ASC

-- 13. Which clients haven't returned in 60 days?

SELECT
    c.ClientID,
    c.ClientName,
    c.PhoneNumber,
    MAX(a.AppointmentDate) AS LastVisit,
    DATEDIFF(
        dd,
        MAX(a.AppointmentDate),
        GETDATE()
    ) AS DaysSinceLastVisit
FROM Clients c
JOIN Appointments a
    ON c.ClientID = a.ClientID
GROUP BY
    c.ClientID,
    c.ClientName,
    c.PhoneNumber
HAVING DATEDIFF(dd, MAX(a.AppointmentDate), GETDATE()) > 60
ORDER BY DaysSinceLastVisit DESC


-- 4. Which services generate the most revenue

-- ## Business Insight
-- Builder Gel = 207750
-- Tips Gel = 163045
-- Gel = 160465

SELECT TOP 3
    s.ServiceName,
    SUM(aps.ServiceAmount) as Revenue
FROM AppointmentServices aps
JOIN Services s
    ON aps.ServiceID = s.ServiceID
GROUP BY
    s.ServiceName
ORDER BY
    Revenue DESC

-- 5. Which nail tech generates the most revenue 
-- OR
-- 1. Revenue per Nail Tech

-- ## Business Insight
-- 2,392605
-- 3,307010
-- 4,141840
-- 1,91980
-- 5,13770

SELECT
    nt.NailTechID,
    SUM(aps.ServiceAmount) as TotalSales
FROM AppointmentServices aps
JOIN NailTechs nt
    ON aps.NailTechID = nt.NailTechID
GROUP BY
    nt.NailTechID
ORDER BY
    TotalSales DESC

-- 6. Which nail tech performs the most services
-- Insights
-- 2

SELECT
    nt.NailTechID,
    COUNT(s.ServiceID) as TotalServices
FROM AppointmentServices aps
JOIN NailTechs nt
    ON aps.NailTechID = nt.NailTechID
JOIN Services s
    ON aps.ServiceID = s.ServiceID
GROUP BY
    nt.NailTechID
ORDER BY
    TotalServices DESC

-- 12. Which clients have had the most services & how much have they spent in the first half of 2026 (the data that we currently have) 
-- Insights
-- 389,133,85020
-- 378,18,14100
-- 127,11,12010
-- 121,12,10050
-- 9,11,9570

SELECT
    c.ClientID,
    COUNT(*) as Visits,
    SUM(Amount) AS TotalAmount
FROM RawSalonRecords rs
JOIN Clients c
    ON rs.PhoneNumber = c.PhoneNumber
GROUP BY
    c.ClientID
ORDER BY
    TotalAmount DESC

-- 7. Which clients visit most often
-- Insight
-- 389,72
-- 9,10
-- 157,10
-- 256,10
-- 120,8

SELECT
    c.ClientID,
    COUNT(aps.AppointmentID) as NumberOfAppointments
FROM Clients c
    JOIN Appointments aps
    ON c.ClientID = aps.ClientID
GROUP BY
    c.ClientID
ORDER BY
    NumberOfAppointments DESC

-- 9. Which payment method is most popular
-- Insights
-- 1,Paybill,1069
-- 2,Cash,150
-- 3,M-Pesa,46
-- 5,Owner Perks,11


SELECT
    pm.PaymentModeID,
    pm.PaymentModeName,
    COUNT(rs.PaymentMode) AS PMOccurences
FROM PaymentModes pm
JOIN RawSalonRecords rs
    ON pm.PaymentModeName = rs.PaymentMode
GROUP BY
    PaymentModeID,
    PaymentModeName
ORDER BY
    PMOccurences DESC

-- 10. Which day makes the most money
-- Insights
-- Saturday,197445
-- Thursday,152090
-- Friday,139290
-- Wednesday,132190
-- Tuesday,129020
-- Sunday,111420
-- Monday,85750


SELECT
    DATENAME(WEEKDAY, a.AppointmentDate) AS DayName,
    SUM(aps.ServiceAmount) as DoWRevenue
FROM Appointments a
JOIN AppointmentServices aps
    ON a.AppointmentID = aps.AppointmentID
GROUP BY
    DATENAME(WEEKDAY, a.AppointmentDate)
ORDER BY
    DoWRevenue DESC

-- 8. Who are the highest-spending clients
-- Insights
-- 361,85020
-- 350,14100
-- 116,12010
-- 110,10050
-- 9,9570

SELECT
    c.ClientID,
--     c.ClientName,
--     c.PhoneNumber,
    SUM(aps.ServiceAmount) AS TotalAmount
FROM Clients c
JOIN Appointments a
    ON c.ClientID = a.ClientID
JOIN AppointmentServices aps
    ON a.AppointmentID = aps.AppointmentID
GROUP BY
    c.ClientID, c.ClientName, c.PhoneNumber
ORDER BY
    TotalAmount DESC

-- 15. Average spend by payment method


-- 15. Average service price

SELECT
    AVG(aps.ServiceAmount) AS AvgAmount
FROM Appointments A
JOIN AppointmentServices aps
    ON a.AppointmentID = aps.AppointmentID

-- 15. Average spend per appointment

SELECT
    AVG(AppointmentTotal) AS AverageSpendPerAppointment
FROM (
SELECT
    AppointmentID,
    SUM(ServiceAmount) AS AppointmentTotal
FROM AppointmentServices
GROUP BY AppointmentID ) AS AppointmentTotal

-- 14. Which technician receives the highest average tip?

SELECT
    n.NailTechID,
    COUNT(DISTINCT a.AppointmentID) AS TippedAppointments,
    SUM(a.Tip) AS TotalTip,
    AVG(CAST(a.Tip AS DECIMAL(10,2))) AS AvgAppointmentTip
FROM NailTechs n
JOIN AppointmentServices aps
    ON n.NailTechID = aps.NailTechID
JOIN Appointments a
    ON aps.AppointmentID = a.AppointmentID
WHERE a.Tip > 0
GROUP BY
    n.NailTechID
ORDER BY AvgAppointmentTip DESC