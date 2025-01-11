
CREATE VIEW UserContributionsView AS
SELECT 
    u.full_name AS Користувач, 
    e.name AS Роботодавець, 
    f.name AS Фонд, 
    c.amount AS Сума_внеску, 
    c.contribution_date AS Дата_внеску
FROM 
    Contributions c
JOIN 
    Users u ON c.user_id = u.user_id
JOIN 
    Employers e ON c.employer_id = e.employer_id
JOIN 
    Funds f ON c.fund_id = f.fund_id;

GO

CREATE VIEW ActiveApplicationsView AS
SELECT 
    u.full_name AS Користувач, 
    f.name AS Фонд, 
    a.application_date AS Дата_заявки, 
    s.status_name AS Статус
FROM 
    Applications a
JOIN 
    Users u ON a.user_id = u.user_id
JOIN 
    Funds f ON a.fund_id = f.fund_id
JOIN 
    ApplicationStatuses s ON a.status_id = s.status_id
WHERE 
    s.status_name = 'Очікує розгляду';

GO

CREATE VIEW UserSummaryView AS
SELECT 
    u.full_name AS Користувач, 
    ISNULL(SUM(c.amount), 0) AS Загальна_сума_внесків, 
    ISNULL(SUM(p.amount), 0) AS Загальна_сума_виплат
FROM 
    Users u
LEFT JOIN 
    Contributions c ON u.user_id = c.user_id
LEFT JOIN 
    Payments p ON u.user_id = p.user_id
GROUP BY 
    u.full_name;
GO

CREATE VIEW ExceededContributionLimitsView AS
SELECT 
    u.full_name AS Користувач, 
    f.name AS Фонд, 
    c.amount AS Сума_внеску, 
    cl.max_amount AS Максимальний_ліміт
FROM 
    Contributions c
JOIN 
    Users u ON c.user_id = u.user_id
JOIN 
    Funds f ON c.fund_id = f.fund_id
JOIN 
    ContributionLimits cl ON c.fund_id = cl.fund_id
WHERE 
    c.amount > cl.max_amount;
GO

CREATE VIEW EmploymentHistoryView AS
SELECT 
    u.full_name AS Користувач, 
    e.name AS Роботодавець, 
    eh.position AS Посада, 
    eh.start_date AS Початок_роботи, 
    eh.end_date AS Кінець_роботи
FROM 
    EmploymentHistory eh
JOIN 
    Users u ON eh.user_id = u.user_id
JOIN 
    Employers e ON eh.employer_id = e.employer_id;
GO

CREATE VIEW UserDocumentsView AS
SELECT 
    u.full_name AS Користувач, 
    d.document_type AS Тип_документа, 
    d.document_number AS Номер_документа, 
    d.issue_date AS Дата_видачі, 
    d.expiry_date AS Дата_закінчення
FROM 
    Documents d
JOIN 
    Users u ON d.user_id = u.user_id;
GO
CREATE VIEW AuditActionsView AS
SELECT 
    a.table_name AS Таблиця, 
    a.action AS Дія, 
    a.performed_by AS Виконавець, 
    a.action_date AS Дата_дії
FROM 
    Audits a
WHERE 
    a.action_date >= '2023-01-01';
GO

Select * from UserContributionsView AS Список_внесків_користувачів;
Select * from ActiveApplicationsView AS Активні_заявки_користувачів;
Select * from UserSummaryView AS Загальна_сума_внесків_і_виплат_користувачів;
Select * from ExceededContributionLimitsView AS  Внески_які_перевищують_ліміти_фондів;
Select * from EmploymentHistoryView AS "Історія зайнятості користувачів із роботодавцем";
Select * from UserDocumentsView AS "Користувачі з їхніми документами";
Select * from AuditActionsView AS "Аудит дій із таблиць";

