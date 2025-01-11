use PensionFund;

--Вибірка для того,щоб переглянути список користувачів із внесками за певний період
SELECT 
    u.full_name AS Користувач, 
    c.amount AS Сума_внеску, 
    c.contribution_date AS Дата_внеску
FROM 
    Users u
JOIN 
    Contributions c ON u.user_id = c.user_id
WHERE 
    c.contribution_date BETWEEN '2020-01-01' AND '2021-12-31'
ORDER BY 
    c.contribution_date DESC;

--Вибірка , яка повертає список користувачів, які працювали у певного роботодавця
SELECT 
    u.full_name AS Користувач, 
    e.name AS Роботодавець, 
    eh.position AS Посада, 
    eh.start_date AS Початок_роботи, 
    eh.end_date AS Кінець_роботи
FROM 
    Users u
JOIN 
    EmploymentHistory eh ON u.user_id = eh.user_id
JOIN 
    Employers e ON eh.employer_id = e.employer_id
WHERE 
    e.name = 'ТОВ "Зоря"';

--Заявки користувачів (статус і назва фонду)
SELECT 
    u.full_name AS Користувач, 
    f.name AS Фонд, 
    a.application_date AS Дата_заявки, 
    s.status_name AS Статус_заявки
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

--Суми внесків у кожен фонд із групуванням за типом фонду
SELECT 
    f.name AS Фонд, 
    f.type AS Тип_фонду, 
    SUM(c.amount) AS Загальна_сума_внесків
FROM 
    Contributions c
JOIN 
    Funds f ON c.fund_id = f.fund_id
GROUP BY 
    f.name, f.type
ORDER BY 
    SUM(c.amount) DESC;

-- Список внесків із розрахованими податками і залишком після вирахування податку:
SELECT 
    u.full_name AS Користувач, 
    c.amount AS Сума_внеску, 
    t.tax_rate AS Ставка_податку, 
    t.tax_amount AS Податок, 
    (c.amount - t.tax_amount) AS Сума_після_податку
FROM 
    Contributions c
JOIN 
    Taxes t ON c.contribution_id = t.contribution_id
JOIN 
    Users u ON c.user_id = u.user_id
ORDER BY 
    c.contribution_date DESC;
--Активні користувачі (ті, хто має внески та отримував виплати):
SELECT 
    u.full_name AS Користувач, 
    SUM(c.amount) AS Загальна_сума_внесків, 
    SUM(p.amount) AS Загальна_сума_виплат
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
--Деталі по внесках із перевіркою лімітів фонду:
SELECT 
    u.full_name AS Користувач, 
    f.name AS Фонд, 
    c.amount AS Сума_внеску, 
    cl.max_amount AS Максимальний_ліміт, 
    cl.min_amount AS Мінімальний_ліміт,
    CASE 
        WHEN c.amount > cl.max_amount THEN 'Перевищує ліміт'
        WHEN c.amount < cl.min_amount THEN 'Менше мінімального ліміту'
        ELSE 'У межах ліміту'
    END AS Статус_внеску
FROM 
    Contributions c
JOIN 
    Users u ON c.user_id = u.user_id
JOIN 
    Funds f ON c.fund_id = f.fund_id
JOIN 
    ContributionLimits cl ON c.fund_id = cl.fund_id;

