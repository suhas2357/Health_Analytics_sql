-- KPI 12: Claim Volume by Specialty
-- Objective: Track volume of claims per medical specialty to identify demand areas.

SELECT 
    s.ProviderSpecialty,
    COUNT(*) AS total_claims
FROM facttable f
JOIN dimphysician p ON f.dimPhysicianPK = p.dimPhysicianPK
JOIN dimspeciality s ON p.SpecialityCode = s.SpecialityCode
GROUP BY s.ProviderSpecialty
ORDER BY total_claims DESC;
