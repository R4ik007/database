-- Створення бази даних
CREATE DATABASE PensionFund;
GO

USE PensionFund;
GO


CREATE TABLE Users (
    user_id INT IDENTITY(1,1) PRIMARY KEY,
    full_name NVARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender NVARCHAR(10),
    address NVARCHAR(MAX),
    phone_number NVARCHAR(15),
    email NVARCHAR(50),
    registration_date DATE DEFAULT GETDATE()
);

CREATE TABLE Documents (
    document_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL FOREIGN KEY REFERENCES Users(user_id),
    document_type NVARCHAR(50),
    document_number NVARCHAR(20),
    issue_date DATE,
    expiry_date DATE
);

CREATE TABLE Employers (
    employer_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    tax_id NVARCHAR(15) UNIQUE,
    address NVARCHAR(MAX),
    phone_number NVARCHAR(15)
);

CREATE TABLE EmploymentHistory (
    job_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL FOREIGN KEY REFERENCES Users(user_id),
    employer_id INT NOT NULL FOREIGN KEY REFERENCES Employers(employer_id),
    position NVARCHAR(100),
    start_date DATE,
    end_date DATE
);

CREATE TABLE Contributions (
    contribution_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL FOREIGN KEY REFERENCES Users(user_id),
    employer_id INT FOREIGN KEY REFERENCES Employers(employer_id),
    fund_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    contribution_date DATE NOT NULL
);

CREATE TABLE Payments (
    payment_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL FOREIGN KEY REFERENCES Users(user_id),
    amount DECIMAL(10, 2) NOT NULL,
    payment_date DATE NOT NULL
);

CREATE TABLE Funds (
    fund_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    type NVARCHAR(50),
    description NVARCHAR(MAX)
);

CREATE TABLE ContributionTypes (
    type_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(50) NOT NULL,
    description NVARCHAR(MAX)
);

CREATE TABLE Admins (
    admin_id INT IDENTITY(1,1) PRIMARY KEY,
    full_name NVARCHAR(100),
    email NVARCHAR(50),
    role NVARCHAR(50)
);

CREATE TABLE Applications (
    application_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL FOREIGN KEY REFERENCES Users(user_id),
    fund_id INT FOREIGN KEY REFERENCES Funds(fund_id),
    application_date DATE NOT NULL,
    status_id INT NOT NULL
);

CREATE TABLE ApplicationStatuses (
    status_id INT IDENTITY(1,1) PRIMARY KEY,
    status_name NVARCHAR(50)
);

CREATE TABLE ContributionLimits (
    limit_id INT IDENTITY(1,1) PRIMARY KEY,
    fund_id INT NOT NULL FOREIGN KEY REFERENCES Funds(fund_id),
    max_amount DECIMAL(10, 2),
    min_amount DECIMAL(10, 2)
);

CREATE TABLE Audits (
    audit_id INT IDENTITY(1,1) PRIMARY KEY,
    table_name NVARCHAR(50),
    action NVARCHAR(50),
    performed_by NVARCHAR(50),
    action_date DATETIME DEFAULT GETDATE()
);

CREATE TABLE Reports (
    report_id INT IDENTITY(1,1) PRIMARY KEY,
    report_name NVARCHAR(100),
    created_by NVARCHAR(50),
    created_date DATE DEFAULT GETDATE(),
    file_path NVARCHAR(MAX)
);

CREATE TABLE Taxes (
    tax_id INT IDENTITY(1,1) PRIMARY KEY,
    contribution_id INT NOT NULL FOREIGN KEY REFERENCES Contributions(contribution_id),
    tax_rate DECIMAL(5, 2),
    tax_amount DECIMAL(10, 2)
);
GO
