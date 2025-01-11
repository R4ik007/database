use PensionFund;
Go
--Реєстрація нового внеску
CREATE OR ALTER PROCEDURE dbo.sp_RegisterContribution
    @user_id INT,
    @employer_id INT = NULL,
    @fund_id INT,
    @amount DECIMAL(10, 2),
    @contribution_date DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        IF NOT EXISTS (SELECT 1 FROM Users WHERE user_id = @user_id)
        BEGIN
            PRINT 'Error: User does not exist.';
            RETURN;
        END

        IF NOT EXISTS (SELECT 1 FROM Funds WHERE fund_id = @fund_id)
        BEGIN
            PRINT 'Error: Fund does not exist.';
            RETURN;
        END

        IF @contribution_date IS NULL
        BEGIN
            SET @contribution_date = GETDATE();
        END

        EXEC dbo.sp_UpsertContribution
            @contribution_id = NULL, 
            @user_id = @user_id, 
            @employer_id = @employer_id, 
            @fund_id = @fund_id, 
            @amount = @amount, 
            @contribution_date = @contribution_date;

        PRINT 'Contribution registered successfully.';
    END TRY
    BEGIN CATCH

        PRINT 'Error occurred during the contribution registration.';
        PRINT ERROR_MESSAGE();
    END CATCH
END;

EXEC dbo.sp_RegisterContribution 
    @user_id = 1,
    @employer_id = 2,
    @fund_id = 3,
    @amount = 1000.00;

select * from Contributions;
GO

CREATE OR ALTER PROCEDURE dbo.sp_CreateContributionReport
    @user_id INT,
    @created_by NVARCHAR(50),
    @file_path NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        IF NOT EXISTS (SELECT 1 FROM Users WHERE user_id = @user_id)
        BEGIN
            PRINT 'Error: User does not exist.';
            RETURN;
        END

        DECLARE @report_content NVARCHAR(MAX);
        SET @report_content = 
            (SELECT STRING_AGG(CONVERT(NVARCHAR(MAX), 
                'Contribution ID: ' + CAST(contribution_id AS NVARCHAR) + ', Amount: ' + CAST(amount AS NVARCHAR) 
                + ', Date: ' + CAST(contribution_date AS NVARCHAR)), CHAR(10))
             FROM Contributions WHERE user_id = @user_id);

        

        EXEC dbo.sp_AddOrUpdateReports 
            @report_id = NULL, 
            @report_name = CONCAT('Звіт внесків для користувача', @user_id), 
            @created_by = @created_by, 
            @file_path = @file_path, 
            @created_date = GETDATE();

        PRINT 'Звіт внесків додано';
    END TRY
    BEGIN CATCH
        PRINT 'Помилка';
        PRINT ERROR_MESSAGE();
    END CATCH
END;

SELECT *
FROM sys.procedures
;
