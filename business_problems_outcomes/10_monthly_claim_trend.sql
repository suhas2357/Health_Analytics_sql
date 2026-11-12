-- KPI 10: Monthly Claim Trend
-- Objective: Track claim submission trends over months for volume and cost forecasting.

SELECT 
    d.MonthYear,
    COUNT(*) AS total_claims,
    ROUND(SUM(f.Gross_Expenses), 2) AS total_expense,
    ROUND(AVG(f.Gross_Expenses), 2) AS avg_expense
FROM facttable f
JOIN dimdate d ON f.dimDateServicePK = d.Date
GROUP BY d.MonthYear
ORDER BY d.MonthYear;
