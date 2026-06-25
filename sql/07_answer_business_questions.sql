
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