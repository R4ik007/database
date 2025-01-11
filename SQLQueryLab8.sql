use PensionFund;
GO

CREATE OR ALTER PROCEDURE sp_UpsertUser
    @user_id INT = NULL,
    @full_name NVARCHAR(100),
    @date_of_birth DATE,
    @gender NVARCHAR(10),
    @address NVARCHAR(MAX),
    @phone_number NVARCHAR(15),
    @email NVARCHAR(50),
    @registration_date DATE = NULL
AS
BEGIN
    BEGIN TRY
        IF @user_id IS NULL
        BEGIN
            INSERT INTO Users (full_name, date_of_birth, gender, address, phone_number, email, registration_date)
            VALUES (@full_name, @date_of_birth, @gender, @address, @phone_number, @email, ISNULL(@registration_date, GETDATE()));
        END
        ELSE
        BEGIN
            UPDATE Users
            SET full_name = @full_name,
                date_of_birth = @date_of_birth,
                gender = @gender,
                address = @address,
                phone_number = @phone_number,
                email = @email,
                registration_date = ISNULL(@registration_date, registration_date)
            WHERE user_id = @user_id;

            IF @@ROWCOUNT = 0
                THROW 50001, 'User not found.', 1;
        END
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END;
GO

EXEC sp_UpsertUser @full_name = 'Роман Петренко', @date_of_birth = '1990-01-01', @gender = 'Чоловік', @address = 'вул. Миру 6, Тлумач', @phone_number = '380685784320', @email = 'romanpetrenko@example.com';

GO
select * from Users

GO

CREATE OR ALTER PROCEDURE sp_UpsertDocument
    @document_id INT = NULL,
    @user_id INT,
    @document_type NVARCHAR(50),
    @document_number NVARCHAR(20),
    @issue_date DATE,
    @expiry_date DATE
AS
BEGIN
    BEGIN TRY
        IF @document_id IS NULL
        BEGIN
            INSERT INTO Documents (user_id, document_type, document_number, issue_date, expiry_date)
            VALUES (@user_id, @document_type, @document_number, @issue_date, @expiry_date);
        END
        ELSE
        BEGIN
            UPDATE Documents
            SET user_id = @user_id,
                document_type = @document_type,
                document_number = @document_number,
                issue_date = @issue_date,
                expiry_date = @expiry_date
            WHERE document_id = @document_id;

            IF @@ROWCOUNT = 0
                THROW 50002, 'Document not found.', 1;
        END
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END;
GO
select * from Documents;
GO
EXEC sp_UpsertDocument @user_id = 1, @document_type = 'Паспорт', @document_number = 'AБ123456', @issue_date = '2020-01-01', @expiry_date = '2030-01-01';
GO

CREATE OR ALTER PROCEDURE sp_UpsertEmployer
    @employer_id INT = NULL,
    @name NVARCHAR(100),
    @tax_id NVARCHAR(15),
    @address NVARCHAR(MAX),
    @phone_number NVARCHAR(15)
AS
BEGIN
    BEGIN TRY
        IF @employer_id IS NULL
        BEGIN
            INSERT INTO Employers (name, tax_id, address, phone_number)
            VALUES (@name, @tax_id, @address, @phone_number);
        END
        ELSE
        BEGIN
            UPDATE Employers
            SET name = @name,
                tax_id = @tax_id,
                address = @address,
                phone_number = @phone_number
            WHERE employer_id = @employer_id;

            IF @@ROWCOUNT = 0
                THROW 50003, 'Employer not found.', 1;
        END
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END;
GO
select * from Employers;
GO
EXEC sp_UpsertEmployer @name = 'ПП "Імідж"', @tax_id = '1725830825', @address = 'вул. Шевченка,34,Івано-Франківськ', @phone_number = '380447896534';

GO

CREATE OR ALTER PROCEDURE sp_UpsertContribution
    @contribution_id INT = NULL,
    @user_id INT,
    @employer_id INT = NULL,
    @fund_id INT,
    @amount DECIMAL(10, 2),
    @contribution_date DATE
AS
BEGIN
    BEGIN TRY
        IF @contribution_id IS NULL
        BEGIN
            INSERT INTO Contributions (user_id, employer_id, fund_id, amount, contribution_date)
            VALUES (@user_id, @employer_id, @fund_id, @amount, @contribution_date);
        END
        ELSE
        BEGIN
            UPDATE Contributions
            SET user_id = @user_id,
                employer_id = @employer_id,
                fund_id = @fund_id,
                amount = @amount,
                contribution_date = @contribution_date
            WHERE contribution_id = @contribution_id;

            IF @@ROWCOUNT = 0
                THROW 50005, 'Contribution not found.', 1;
        END
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END;
GO
select * from Contributions;

GO 
EXEC sp_UpsertContribution @user_id = 1, @employer_id = 1, @fund_id = 1, @amount = 100500, @contribution_date = '2023-12-01';

GO

CREATE OR ALTER PROCEDURE dbo.sp_AddOrUpdateReports
    @report_id INT = NULL,
    @report_name NVARCHAR(100),
    @created_by NVARCHAR(50),
    @file_path NVARCHAR(MAX),
    @created_date DATE = NULL 
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        IF @created_date IS NULL
        BEGIN
            SET @created_date = GETDATE();
        END

        IF @report_id IS NULL OR NOT EXISTS (SELECT 1 FROM Reports WHERE report_id = @report_id)
        BEGIN
            INSERT INTO Reports (report_name, created_by, created_date, file_path)
            VALUES (@report_name, @created_by, @created_date, @file_path);

            PRINT 'Новий звіт додано успішно';
        END
        ELSE
        BEGIN
            UPDATE Reports
            SET report_name = @report_name,
                created_by = @created_by,
                created_date = @created_date,
                file_path = @file_path
            WHERE report_id = @report_id;

            PRINT 'Звіт оновлено';
        END
    END TRY
    BEGIN CATCH
        PRINT 'Помилк при додаванні або оновленні';
        PRINT ERROR_MESSAGE();
    END CATCH
END;
