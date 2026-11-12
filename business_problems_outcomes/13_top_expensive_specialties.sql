-- KPI 13: Top 5 Expensive Specialties
-- Objective: Identify which physician specialties generate the highest total treatment costs.

SELECT 
    s.ProviderSpecialty,
    ROUND(SUM(f.Gross_Expenses), 2) AS total_expense
FROM facttable f
JOIN dimphysician p ON f.dimPhysicianPK = p.dimPhysicianPK
JOIN dimspeciality s ON p.SpecialityCode = s.SpecialityCode
GROUP BY s.ProviderSpecialty
ORDER BY total_expense DESC
LIMIT 5;
