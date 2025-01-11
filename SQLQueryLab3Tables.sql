use PensionFund;

INSERT INTO Users (full_name, date_of_birth, gender, address, phone_number, email)
VALUES 
('���� ��������', '1960-05-15', '������', '���. ��������, 10, �����-���������', '380501234567', 'ivan.ivanenko@example.com'),
('���� ��������', '1955-12-20', 'Ƴ���', '���. ������������, 5, ����', '380673456789', 'maria.petrivna@example.com'),
('����� ���������', '1970-08-10', 'Ƴ���', '���. ������, 15, �����', '380939876543', 'olena.kovalenko@example.com');

INSERT INTO Employers (name, tax_id, address, phone_number)
VALUES 
('��� "����"', '1234567890', '���. ����������, 25, ���', '380442223344'),
('�� "�����"', '9876543210', '��-� ����, 12, �����', '380577776655'),
('�� "���"', '4567891230', '���. ���������, 7, �����', '380567890123');

INSERT INTO Funds (name, type, description)
VALUES 
('��������� �������� ����', '���������', '�������� ��������� �������� ����'),
('��������� �������� ���� "�������"', '���������', '��������� ���� ��� ��������������� �����'),
('������������� ���� "����"', '�������������', '���� ��� ���������� ���������� "����"');

INSERT INTO Documents (user_id, document_type, document_number, issue_date, expiry_date)
VALUES 
(1, '�������', '��123456', '1990-05-20', NULL),
(2, '�������', '��654321', '1985-07-15', NULL),
(3, 'ID-������', '123456789', '2015-08-01', '2035-08-01');

INSERT INTO EmploymentHistory (user_id, employer_id, position, start_date, end_date)
VALUES 
(1, 1, '�������', '1980-01-15', '2005-05-30'),
(2, 2, '���������', '1975-03-01', '2000-12-31'),
(3, 3, '��������', '1995-06-01', '2010-10-15');

INSERT INTO Contributions (user_id, employer_id, fund_id, amount, contribution_date)
VALUES 
(1, 1, 1, 5000.00, '2020-01-15'),
(2, 2, 1, 7000.00, '2020-02-20'),
(3, 3, 2, 3000.00, '2020-03-10');

INSERT INTO Payments (user_id, amount, payment_date)
VALUES 
(1, 2500.00, '2023-01-01'),
(2, 2700.00, '2023-02-01'),
(3, 1500.00, '2023-03-01');

INSERT INTO ContributionTypes (name, description)
VALUES 
('�����������', '��������� ������ �������� �� ������'),
('�����������', '�������� ��������� ������');

INSERT INTO Admins (full_name, email, role)
VALUES 
('��������� ������', 'oleksandr.bondar@example.com', '�������'),
('������� �������', 'svitlana.gumenyuk@example.com', '���������'),
('������ ��������', 'dmytro.shevchenko@example.com', '���������');

INSERT INTO Applications (user_id, fund_id, application_date, status_id)
VALUES 
(1, 1, '2023-04-01', 1), 
(2, 1, '2023-05-15', 2),
(3, 2, '2023-06-20', 3);

INSERT INTO ApplicationStatuses (status_id, status_name)
VALUES 
(1,'����� ��������'),
(2,'�����������'),
(3,'³�������'); 

INSERT INTO ContributionLimits (fund_id, max_amount, min_amount)
VALUES 
(1, 10000.00, 500.00),
(2, 20000.00, 1000.00),
(3, 15000.00, 700.00);

INSERT INTO Audits (table_name, action, performed_by, action_date)
VALUES 
('Users', 'INSERT', '��������� ������', '2023-01-15'),
('Payments', 'UPDATE', '������� �������', '2023-03-10');

INSERT INTO Reports (report_name, created_by, file_path)
VALUES 
('��������� ��� ����', '��������� ������', '/reports/january_report.pdf'),
('������� ���', '������� �������', '/reports/annual_report.pdf');

INSERT INTO Taxes (contribution_id, tax_rate, tax_amount)
VALUES 
(1, 15.00, 750.00),
(2, 18.00, 1260.00),
(3, 10.00, 300.00);

select * from Users;		