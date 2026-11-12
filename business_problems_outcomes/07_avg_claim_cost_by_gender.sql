-- KPI 7: Avg Claim Cost by Gender
-- Objective: Identify any cost variation in healthcare claims between different gender groups.

SELECT 
    PatientGender,
    ROUND(AVG(Gross_Expenses), 2) AS avg_claim_cost
FROM facttable f
JOIN dimpatient p ON f.dimPatientPK = p.dimPatientPK
GROUP BY PatientGender
ORDER BY avg_claim_cost DESC;
