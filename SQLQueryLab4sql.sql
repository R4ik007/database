use PensionFund;

--������ ��� ����,��� ����������� ������ ������������ �� �������� �� ������ �����
SELECT 
    u.full_name AS ����������, 
    c.amount AS ����_������, 
    c.contribution_date AS ����_������
FROM 
    Users u
JOIN 
    Contributions c ON u.user_id = c.user_id
WHERE 
    c.contribution_date BETWEEN '2020-01-01' AND '2021-12-31'
ORDER BY 
    c.contribution_date DESC;

--������ , ��� ������� ������ ������������, �� ��������� � ������� �����������
SELECT 
    u.full_name AS ����������, 
    e.name AS ������������, 
    eh.position AS ������, 
    eh.start_date AS �������_������, 
    eh.end_date AS ʳ����_������
FROM 
    Users u
JOIN 
    EmploymentHistory eh ON u.user_id = eh.user_id
JOIN 
    Employers e ON eh.employer_id = e.employer_id
WHERE 
    e.name = '��� "����"';

--������ ������������ (������ � ����� �����)
SELECT 
    u.full_name AS ����������, 
    f.name AS ����, 
    a.application_date AS ����_������, 
    s.status_name AS ������_������
FROM 
    Applications a
JOIN 
    Users u ON a.user_id = u.user_id
JOIN 
    Funds f ON a.fund_id = f.fund_id
JOIN 
    ApplicationStatuses s ON a.status_id = s.status_id
ORDER BY 
    a.application_date DESC;

--���� ������ � ����� ���� �� ����������� �� ����� �����
SELECT 
    f.name AS ����, 
    f.type AS ���_�����, 
    SUM(c.amount) AS ��������_����_������
FROM 
    Contributions c
JOIN 
    Funds f ON c.fund_id = f.fund_id
GROUP BY 
    f.name, f.type
ORDER BY 
    SUM(c.amount) DESC;

-- ������ ������ �� ������������� ��������� � �������� ���� ����������� �������:
SELECT 
    u.full_name AS ����������, 
    c.amount AS ����_������, 
    t.tax_rate AS ������_�������, 
    t.tax_amount AS �������, 
    (c.amount - t.tax_amount) AS ����_����_�������
FROM 
    Contributions c
JOIN 
    Taxes t ON c.contribution_id = t.contribution_id
JOIN 
    Users u ON c.user_id = u.user_id
ORDER BY 
    c.contribution_date DESC;
--������ ����������� (�, ��� �� ������ �� ��������� �������):
SELECT 
    u.full_name AS ����������, 
    SUM(c.amount) AS ��������_����_������, 
    SUM(p.amount) AS ��������_����_������
FROM 
    Users u
LEFT JOIN 
    Contributions c ON u.user_id = c.user_id
LEFT JOIN 
    Payments p ON u.user_id = p.user_id
WHERE 
    c.amount IS NOT NULL AND p.amount IS NOT NULL
GROUP BY 
    u.full_name
ORDER BY 
    u.full_name;
--����� �� ������� �� ��������� ���� �����:
SELECT 
    u.full_name AS ����������, 
    f.name AS ����, 
    c.amount AS ����_������, 
    cl.max_amount AS ������������_���, 
    cl.min_amount AS ̳��������_���,
    CASE 
        WHEN c.amount > cl.max_amount THEN '�������� ���'
        WHEN c.amount < cl.min_amount THEN '����� ���������� ����'
        ELSE '� ����� ����'
    END AS ������_������
FROM 
    Contributions c
JOIN 
    Users u ON c.user_id = u.user_id
JOIN 
    Funds f ON c.fund_id = f.fund_id
JOIN 
    ContributionLimits cl ON c.fund_id = cl.fund_id;

