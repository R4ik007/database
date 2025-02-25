ALTER TABLE dbo.EmploymentHistory ADD
    ValidFrom DATETIME2 GENERATED ALWAYS AS ROW START HIDDEN
        CONSTRAINT DF_EmploymentHistory_ValidFrom DEFAULT SYSUTCDATETIME(),
    ValidTo DATETIME2 GENERATED ALWAYS AS ROW END HIDDEN
        CONSTRAINT DF_EmploymentHistory_ValidTo DEFAULT CONVERT(DATETIME2, '9999-12-31 23:59:59.9999999'),
    PERIOD FOR SYSTEM_TIME (ValidFrom, ValidTo);
GO

ALTER TABLE dbo.EmploymentHistory
    SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.EmploymentHistory_History));
GO

ALTER TABLE dbo.Contributions ADD
    ValidFrom DATETIME2 GENERATED ALWAYS AS ROW START HIDDEN
        CONSTRAINT DF_Contributions_ValidFrom DEFAULT SYSUTCDATETIME(),
    ValidTo DATETIME2 GENERATED ALWAYS AS ROW END HIDDEN
        CONSTRAINT DF_Contributions_ValidTo DEFAULT CONVERT(DATETIME2, '9999-12-31 23:59:59.9999999'),
    PERIOD FOR SYSTEM_TIME (ValidFrom, ValidTo);
GO

ALTER TABLE dbo.Contributions
    SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.Contributions_History));
GO

ALTER TABLE dbo.Payments ADD
    ValidFrom DATETIME2 GENERATED ALWAYS AS ROW START HIDDEN
        CONSTRAINT DF_Payments_ValidFrom DEFAULT SYSUTCDATETIME(),
    ValidTo DATETIME2 GENERATED ALWAYS AS ROW END HIDDEN
        CONSTRAINT DF_Payments_ValidTo DEFAULT CONVERT(DATETIME2, '9999-12-31 23:59:59.9999999'),
    PERIOD FOR SYSTEM_TIME (ValidFrom, ValidTo);
GO

ALTER TABLE dbo.Payments
    SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.Payments_History));
GO

SELECT * 
FROM dbo.Contributions 
FOR SYSTEM_TIME FROM '2024-01-01' TO '2024-12-31';

SELECT * 
FROM dbo.Payments 
FOR SYSTEM_TIME AS OF '2023-02-01';


SELECT * 
FROM dbo.EmploymentHistory 
WHERE user_id = 1;

SELECT * 
FROM dbo.Payments 
WHERE payment_id = 3;

SELECT *
FROM dbo.Contributions
FOR SYSTEM_TIME FROM '2010-01-01' TO '2024-12-31'
WHERE fund_id = 2;
