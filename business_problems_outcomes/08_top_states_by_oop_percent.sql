-- KPI 8: Top 5 States by Out-of-Pocket %
-- Objective: Identify which states have the highest patient out-of-pocket costs compared to total treatment cost.

SELECT 
    State,
    ROUND(SUM(Patient_Payment), 2) AS total_patient_payment,
    ROUND(SUM(Gross_Expenses), 2) AS total_expense,
    ROUND(SUM(Patient_Payment) * 100.0 / NULLIF(SUM(Gross_Expenses), 0), 2) AS oop_percent
FROM facttable f
JOIN dimpatient p ON f.dimPatientPK = p.dimPatientPK
GROUP BY State
ORDER BY oop_percent DESC
LIMIT 5;
