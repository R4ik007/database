
CREATE VIEW UserContributionsView AS
SELECT 
    u.full_name AS ����������, 
    e.name AS ������������, 
    f.name AS ����, 
    c.amount AS ����_������, 
    c.contribution_date AS ����_������
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
    u.full_name AS ����������, 
    f.name AS ����, 
    a.application_date AS ����_������, 
    s.status_name AS ������
FROM 
    Applications a
JOIN 
    Users u ON a.user_id = u.user_id
JOIN 
    Funds f ON a.fund_id = f.fund_id
JOIN 
    ApplicationStatuses s ON a.status_id = s.status_id
WHERE 
    s.status_name = '����� ��������';

GO

CREATE VIEW UserSummaryView AS
SELECT 
    u.full_name AS ����������, 
    ISNULL(SUM(c.amount), 0) AS ��������_����_������, 
    ISNULL(SUM(p.amount), 0) AS ��������_����_������
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
    u.full_name AS ����������, 
    f.name AS ����, 
    c.amount AS ����_������, 
    cl.max_amount AS ������������_���
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
    u.full_name AS ����������, 
    e.name AS ������������, 
    eh.position AS ������, 
    eh.start_date AS �������_������, 
    eh.end_date AS ʳ����_������
FROM 
    EmploymentHistory eh
JOIN 
    Users u ON eh.user_id = u.user_id
JOIN 
    Employers e ON eh.employer_id = e.employer_id;
GO

CREATE VIEW UserDocumentsView AS
SELECT 
    u.full_name AS ����������, 
    d.document_type AS ���_���������, 
    d.document_number AS �����_���������, 
    d.issue_date AS ����_������, 
    d.expiry_date AS ����_���������
FROM 
    Documents d
JOIN 
    Users u ON d.user_id = u.user_id;
GO
CREATE VIEW AuditActionsView AS
SELECT 
    a.table_name AS �������, 
    a.action AS ĳ�, 
    a.performed_by AS ����������, 
    a.action_date AS ����_䳿
FROM 
    Audits a
WHERE 
    a.action_date >= '2023-01-01';
GO

Select * from UserContributionsView AS ������_������_������������;
Select * from ActiveApplicationsView AS ������_������_������������;
Select * from UserSummaryView AS ��������_����_������_�_������_������������;
Select * from ExceededContributionLimitsView AS  ������_��_�����������_����_�����;
Select * from EmploymentHistoryView AS "������ ��������� ������������ �� ������������";
Select * from UserDocumentsView AS "����������� � ����� �����������";
Select * from AuditActionsView AS "����� �� �� �������";

