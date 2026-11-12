-- Dimension: Patient
CREATE TABLE dimpatient (
    dimPatientPK INTEGER PRIMARY KEY,
    PatientNumber VARCHAR(50),
    FirstName VARCHAR(100),
    LastName VARCHAR(100),
    Email VARCHAR(255),
    PatientGender VARCHAR(10),
    PatientAge INTEGER,
    PatientHeight_in_cms VARCHAR(10),
    Year_of_Birth INTEGER,
    Month INTEGER,
    Day INTEGER,
    BloodGroup VARCHAR(10),
    Tobacco VARCHAR(10),
    Alcohol VARCHAR(10),
    Exercise VARCHAR(20),
    Diet VARCHAR(20),
    Ethinicity VARCHAR(50),
    Zip_Codes VARCHAR(20),
    State_Code VARCHAR(10),
    City VARCHAR(100),
    State VARCHAR(100),
    Region VARCHAR(100)
);

-- Dimension: Physician
CREATE TABLE dimphysician (
    dimPhysicianPK INTEGER PRIMARY KEY,
    ProviderNpi VARCHAR(50),
    ProviderName VARCHAR(100),
    SpecialityCode VARCHAR(20),
    ProviderFTE VARCHAR(50)
);

-- Dimension: Speciality
CREATE TABLE dimspeciality (
    SpecialityCode VARCHAR(20) PRIMARY KEY,
    ProviderSpecialty VARCHAR(100),
    SpecialityType VARCHAR(100),
    SpecialityDesc VARCHAR(255)
);

-- Dimension: Hospital
CREATE TABLE dimhospital (
    dimLocationPK INTEGER PRIMARY KEY,
    LocationName VARCHAR(100)
);

-- Dimension: Payer
CREATE TABLE dimpayer (
    dimPayerPK INTEGER PRIMARY KEY,
    PayerName VARCHAR(100)
);

-- Dimension: CPT Code
CREATE TABLE dimcptcode (
    dimCPTCodePK INTEGER PRIMARY KEY,
    CptCode VARCHAR(50),
    CptDesc VARCHAR(255),
    CptGrouping VARCHAR(100)
);

-- Dimension: Diagnosis Code
CREATE TABLE dimdiagnosiscode (
    dimDiagnosisCodePK INTEGER PRIMARY KEY,
    DiagnosisCode VARCHAR(50),
    DiagnosisCodeDescription VARCHAR(255),
    DiagnosisCodeGroup VARCHAR(100)
);

-- Dimension: Date
CREATE TABLE dimdate (
    Date DATE PRIMARY KEY,
    Year INTEGER,
    Month INTEGER,
    MonthPeriod VARCHAR(20),
    MonthYear VARCHAR(20),
    Day INTEGER,
    DayName VARCHAR(20)
);

-- Dimension: Transaction
CREATE TABLE dimtransaction (
    dimTransactionPK INTEGER PRIMARY KEY,
    TransactionType VARCHAR(100),
    Transaction VARCHAR(100),
    AdjustmentReason VARCHAR(255)
);

-- Fact Table
CREATE TABLE facttable (
    FactTablePK INTEGER PRIMARY KEY,
    Check_Dimension VARCHAR(50),
    dimPatientPK INTEGER,
    dimPhysicianPK INTEGER,
    dimDateServicePK DATE,
    dimDatePostPK DATE,
    dimCPTCodePK INTEGER,
    dimPayerPK INTEGER,
    dimTransactionPK INTEGER,
    dimLocationPK INTEGER,
    PatientNumber VARCHAR(50),
    dimDiagnosisCodePK INTEGER,
    CPTUnits INTEGER,
    Gross_Expenses NUMERIC(12,2),
    Adjustment NUMERIC(12,2),
    Insurance_Payment NUMERIC(12,2),
    Patient_Payment NUMERIC(12,2),
    AR NUMERIC(12,2)
);
