use PensionFund;

INSERT INTO Users (full_name, date_of_birth, gender, address, phone_number, email)
VALUES 
('Іван Іваненко', '1960-05-15', 'Чоловік', 'вул. Шевченка, 10, Івано-Франківськ', '380501234567', 'ivan.ivanenko@example.com'),
('Марія Петренко', '1955-12-20', 'Жінка', 'вул. Грушевського, 5, Львів', '380673456789', 'maria.petrivna@example.com'),
('Олена Коваленко', '1970-08-10', 'Жінка', 'вул. Садова, 15, Одеса', '380939876543', 'olena.kovalenko@example.com');

INSERT INTO Employers (name, tax_id, address, phone_number)
VALUES 
('ТОВ "Зоря"', '1234567890', 'вул. Центральна, 25, Київ', '380442223344'),
('АТ "Сонце"', '9876543210', 'пр-т Миру, 12, Харків', '380577776655'),
('ПП "Мрія"', '4567891230', 'вул. Набережна, 7, Дніпро', '380567890123');

INSERT INTO Funds (name, type, description)
VALUES 
('Державний Пенсійний Фонд', 'Державний', 'Основний державний пенсійний фонд'),
('Приватний Пенсійний Фонд "Майбутнє"', 'Приватний', 'Приватний фонд для накопичувальних пенсій'),
('Корпоративний Фонд "Зоря"', 'Корпоративний', 'Фонд для працівників корпорації "Зоря"');

INSERT INTO Documents (user_id, document_type, document_number, issue_date, expiry_date)
VALUES 
(1, 'Паспорт', 'АБ123456', '1990-05-20', NULL),
(2, 'Паспорт', 'ВГ654321', '1985-07-15', NULL),
(3, 'ID-картка', '123456789', '2015-08-01', '2035-08-01');

INSERT INTO EmploymentHistory (user_id, employer_id, position, start_date, end_date)
VALUES 
(1, 1, 'Інженер', '1980-01-15', '2005-05-30'),
(2, 2, 'Бухгалтер', '1975-03-01', '2000-12-31'),
(3, 3, 'Менеджер', '1995-06-01', '2010-10-15');

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
('Обов’язковий', 'Обов’язкові внески відповідно до закону'),
('Добровільний', 'Додаткові добровільні внески');

INSERT INTO Admins (full_name, email, role)
VALUES 
('Олександр Бондар', 'oleksandr.bondar@example.com', 'Керівник'),
('Світлана Гуменюк', 'svitlana.gumenyuk@example.com', 'Спеціаліст'),
('Дмитро Шевченко', 'dmytro.shevchenko@example.com', 'Інспектор');

INSERT INTO Applications (user_id, fund_id, application_date, status_id)
VALUES 
(1, 1, '2023-04-01', 1), 
(2, 1, '2023-05-15', 2),
(3, 2, '2023-06-20', 3);

INSERT INTO ApplicationStatuses (status_id, status_name)
VALUES 
(1,'Очікує розгляду'),
(2,'Затверджено'),
(3,'Відхилено'); 

INSERT INTO ContributionLimits (fund_id, max_amount, min_amount)
VALUES 
(1, 10000.00, 500.00),
(2, 20000.00, 1000.00),
(3, 15000.00, 700.00);

INSERT INTO Audits (table_name, action, performed_by, action_date)
VALUES 
('Users', 'INSERT', 'Олександр Бондар', '2023-01-15'),
('Payments', 'UPDATE', 'Світлана Гуменюк', '2023-03-10');

INSERT INTO Reports (report_name, created_by, file_path)
VALUES 
('Щомісячний звіт січня', 'Олександр Бондар', '/reports/january_report.pdf'),
('Щорічний звіт', 'Світлана Гуменюк', '/reports/annual_report.pdf');

INSERT INTO Taxes (contribution_id, tax_rate, tax_amount)
VALUES 
(1, 15.00, 750.00),
(2, 18.00, 1260.00),
(3, 10.00, 300.00);

select * from Users;		