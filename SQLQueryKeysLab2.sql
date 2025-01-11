-- 1. Таблиця Користувачі (Users) – базова таблиця, без зовнішніх ключів
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

-- 2. Таблиця Документи (Documents)
CREATE TABLE Documents (
    document_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    document_type NVARCHAR(50),
    document_number NVARCHAR(20),
    issue_date DATE,
    expiry_date DATE,
    CONSTRAINT FK_Documents_Users FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- 3. Таблиця Роботодавці (Employers)
CREATE TABLE Employers (
    employer_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    tax_id NVARCHAR(15) UNIQUE,
    address NVARCHAR(MAX),
    phone_number NVARCHAR(15)
);

-- 4. Таблиця Історія працевлаштування (EmploymentHistory)
CREATE TABLE EmploymentHistory (
    job_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    employer_id INT NOT NULL,
    position NVARCHAR(100),
    start_date DATE,
    end_date DATE,
    CONSTRAINT FK_EmploymentHistory_Users FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    CONSTRAINT FK_EmploymentHistory_Employers FOREIGN KEY (employer_id) REFERENCES Employers(employer_id) ON DELETE CASCADE
);

-- 5. Таблиця Внески (Contributions)
CREATE TABLE Contributions (
    contribution_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    employer_id INT,
    fund_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    contribution_date DATE NOT NULL,
    CONSTRAINT FK_Contributions_Users FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    CONSTRAINT FK_Contributions_Employers FOREIGN KEY (employer_id) REFERENCES Employers(employer_id),
    CONSTRAINT FK_Contributions_Funds FOREIGN KEY (fund_id) REFERENCES Funds(fund_id) ON DELETE CASCADE
);

-- 6. Таблиця Платежі (Payments)
CREATE TABLE Payments (
    payment_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    payment_date DATE NOT NULL,
    CONSTRAINT FK_Payments_Users FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- 7. Таблиця Фонди (Funds)
CREATE TABLE Funds (
    fund_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    type NVARCHAR(50),
    description NVARCHAR(MAX)
);

-- 8. Таблиця Типи внесків (ContributionTypes)
CREATE TABLE ContributionTypes (
    type_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(50) NOT NULL,
    description NVARCHAR(MAX)
);

-- 9. Таблиця Адміністратори (Admins)
CREATE TABLE Admins (
    admin_id INT IDENTITY(1,1) PRIMARY KEY,
    full_name NVARCHAR(100),
    email NVARCHAR(50),
    role NVARCHAR(50)
);

-- 10. Таблиця Заявки (Applications)
CREATE TABLE Applications (
    application_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    fund_id INT,
    application_date DATE NOT NULL,
    status_id INT NOT NULL,
    CONSTRAINT FK_Applications_Users FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    CONSTRAINT FK_Applications_Funds FOREIGN KEY (fund_id) REFERENCES Funds(fund_id) ON DELETE CASCADE,
    CONSTRAINT FK_Applications_Status FOREIGN KEY (status_id) REFERENCES ApplicationStatuses(status_id)
);

-- 11. Таблиця Статуси заявок (ApplicationStatuses)
CREATE TABLE ApplicationStatuses (
    status_id INT IDENTITY(1,1) PRIMARY KEY,
    status_name NVARCHAR(50)
);

-- 12. Таблиця Ліміти внесків (ContributionLimits)
CREATE TABLE ContributionLimits (
    limit_id INT IDENTITY(1,1) PRIMARY KEY,
    fund_id INT NOT NULL,
    max_amount DECIMAL(10, 2),
    min_amount DECIMAL(10, 2),
    CONSTRAINT FK_ContributionLimits_Funds FOREIGN KEY (fund_id) REFERENCES Funds(fund_id) ON DELETE CASCADE
);

-- 13. Таблиця Логи перевірок (Audits)
CREATE TABLE Audits (
    audit_id INT IDENTITY(1,1) PRIMARY KEY,
    table_name NVARCHAR(50),
    action NVARCHAR(50),
    performed_by NVARCHAR(50),
    action_date DATETIME DEFAULT GETDATE()
);

-- 14. Таблиця Звіти (Reports)
CREATE TABLE Reports (
    report_id INT IDENTITY(1,1) PRIMARY KEY,
    report_name NVARCHAR(100),
    created_by NVARCHAR(50),
    created_date DATE DEFAULT GETDATE(),
    file_path NVARCHAR(MAX)
);

-- 15. Таблиця Податки (Taxes)
CREATE TABLE Taxes (
    tax_id INT IDENTITY(1,1) PRIMARY KEY,
    contribution_id INT NOT NULL,
    tax_rate DECIMAL(5, 2),
    tax_amount DECIMAL(10, 2),
    CONSTRAINT FK_Taxes_Contributions FOREIGN KEY (contribution_id) REFERENCES Contributions(contribution_id) ON DELETE CASCADE
);
GO
