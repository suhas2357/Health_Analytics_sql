-- KPI 3: Insurance vs Out-of-Pocket Ratio
-- Objective: Compare the proportion of insurance payments vs patient out-of-pocket costs for all claims.

SELECT 
    ROUND(SUM(Insurance_Payment), 2) AS total_insurance_payment,
    ROUND(SUM(Patient_Payment), 2) AS total_patient_payment,
    ROUND(SUM(Patient_Payment) / NULLIF(SUM(Gross_Expenses), 0) * 100, 2) AS oop_percentage
FROM facttable;
