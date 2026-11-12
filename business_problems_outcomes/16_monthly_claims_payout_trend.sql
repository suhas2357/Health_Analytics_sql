-- KPI 16: Monthly Claims & Payout Trend
-- Objective: Track monthly trends in claim volume and total payout (insurance + patient) for forecasting and performance monitoring.

SELECT 
    d.MonthYear,
    COUNT(*) AS total_claims,
    ROUND(SUM(f.Insurance_Payment + f.Patient_Payment), 2) AS total_received,
    ROUND(AVG(f.Gross_Expenses), 2) AS avg_claim
FROM facttable f
JOIN dimdate d ON f.dimDatePostPK = d.Date
GROUP BY d.MonthYear
ORDER BY d.MonthYear;
