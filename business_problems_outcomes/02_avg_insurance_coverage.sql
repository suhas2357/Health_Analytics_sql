-- KPI 2: Avg Insurance Payment + Coverage % by Payer
-- Objective: Evaluate insurance provider efficiency by average payout and % coverage of total billed cost.

SELECT 
    PayerName,
    ROUND(AVG(Insurance_Payment), 2) AS avg_insurance_payment,
    ROUND(AVG(Insurance_Payment) / NULLIF(AVG(Gross_Expenses), 0) * 100, 2) AS insurance_coverage_percent
FROM facttable f
JOIN dimpayer p ON f.dimPayerPK = p.dimPayerPK
GROUP BY PayerName
ORDER BY avg_insurance_payment DESC;
