-- KPI 11: Physician Efficiency (Cost per Patient)
-- Objective: Determine cost effectiveness of physicians based on per-patient average treatment expense.

SELECT 
    ProviderName,
    COUNT(DISTINCT f.dimPatientPK) AS unique_patients,
    ROUND(SUM(Gross_Expenses), 2) AS total_cost,
    ROUND(SUM(Gross_Expenses)::numeric / NULLIF(COUNT(DISTINCT f.dimPatientPK), 0), 2) AS cost_per_patient
FROM facttable f
JOIN dimphysician p ON f.dimPhysicianPK = p.dimPhysicianPK
GROUP BY ProviderName
ORDER BY cost_per_patient DESC;
