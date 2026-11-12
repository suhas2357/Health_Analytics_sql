-- KPI 4: Patients Without Insurance Payment
-- Objective: Count claims with zero insurance payment and calculate patient-paid percentage for those cases.

SELECT 
    COUNT(*) AS uninsured_cases,
    ROUND(SUM(Patient_Payment), 2) AS total_patient_payment,
    ROUND(SUM(Gross_Expenses), 2) AS total_cost,
    ROUND(SUM(Patient_Payment) * 100.0 / NULLIF(SUM(Gross_Expenses), 0), 2) AS oop_percentage
FROM facttable
WHERE Insurance_Payment = 0;
