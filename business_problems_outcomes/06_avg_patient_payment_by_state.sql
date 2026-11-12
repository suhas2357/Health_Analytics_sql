-- KPI 6: Avg Patient Payment by State
-- Objective: Evaluate how average out-of-pocket payments vary by state to detect regional financial trends.

SELECT 
    State,
    ROUND(AVG(Patient_Payment), 2) AS avg_patient_payment
FROM facttable f
JOIN dimpatient p ON f.dimPatientPK = p.dimPatientPK
GROUP BY State
ORDER BY avg_patient_payment DESC;
