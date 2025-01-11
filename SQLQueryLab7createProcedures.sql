use PensionFund;
GO
CREATE PROCEDURE GetFunds
    @FilterName NVARCHAR(100) = NULL,      
    @FilterType NVARCHAR(50) = NULL,      
    @SortColumn NVARCHAR(50) = 'fund_id', 
    @SortDirection NVARCHAR(4) = 'ASC', 
    @PageNumber INT = 1,                  
    @PageSize INT = 10          
AS
BEGIN
    SET NOCOUNT ON;

    -- ���������� �������� ������ ��� ��������
    DECLARE @Offset INT;
    SET @Offset = (@PageNumber - 1) * @PageSize;

    -- ���������� ������
    WITH PaginatedFunds AS (
        SELECT 
            fund_id, 
            name, 
            type, 
            ROW_NUMBER() OVER (ORDER BY 
                CASE 
                    WHEN @SortColumn = 'name' THEN name
                    WHEN @SortColumn = 'type' THEN type
                    ELSE CAST(fund_id AS NVARCHAR)
                END 
                ASC
            ) AS RowNum
        FROM 
            Funds
        WHERE 
            (@FilterName IS NULL OR name LIKE '%' + @FilterName + '%')
            AND (@FilterType IS NULL OR type = @FilterType)
    )
    SELECT 
        fund_id, 
        name, 
        type 
    FROM 
        PaginatedFunds
    WHERE 
        RowNum BETWEEN @Offset + 1 AND @Offset + @PageSize
    ORDER BY 
        CASE 
            WHEN @SortDirection = 'ASC' THEN RowNum
            ELSE -RowNum
        END;
END;
EXEC GetFunds 
    @FilterName = NULL, 
    @FilterType = '���������', 
    @SortColumn = 'name', 
    @SortDirection = 'ASC', 
    @PageNumber = 1, 
    @PageSize = 5;
GO

CREATE OR ALTER PROCEDURE dbo.sp_GetUsers
    @UserId INT = NULL,                    -- Գ�������� �� user_id
    @Name NVARCHAR(100) = NULL,            -- Գ�������� �� full_name
    @Gender NVARCHAR(10) = NULL,           -- Գ�������� �� gender
    @PageSize INT = 20,                    -- ʳ������ ������ �� �������
    @PageNumber INT = 1,                   -- ����� �������
    @SortColumn NVARCHAR(128) = 'user_id', -- ���������� �� ��������
    @SortDirection BIT = 0                 -- ������ ���������� (0-ASC, 1-DESC)
AS
BEGIN
    SET NOCOUNT ON;

    -- �������� �������� �����������, ���� ������� @UserId
    IF @UserId IS NOT NULL
    AND NOT EXISTS (SELECT 1 FROM dbo.Users WHERE user_id = @UserId)
    BEGIN
        PRINT 'Incorrect value of @UserId';
        RETURN;
    END

    -- �������� ����������
    SELECT *
    FROM dbo.Users
    WHERE (user_id = @UserId OR @UserId IS NULL)  -- Գ���� �� user_id
      AND (full_name LIKE @Name + '%' OR @Name IS NULL)  -- Գ���� �� ��'��
      AND (gender = @Gender OR @Gender IS NULL)  -- Գ���� �� ������
    ORDER BY
        CASE WHEN @SortDirection = 0 THEN
            CASE @SortColumn
                WHEN 'user_id' THEN CAST(user_id AS NVARCHAR)
                WHEN 'full_name' THEN full_name
                WHEN 'date_of_birth' THEN CAST(date_of_birth AS NVARCHAR)
                WHEN 'gender' THEN gender
                WHEN 'registration_date' THEN CAST(registration_date AS NVARCHAR)
            END
        END ASC,
        CASE WHEN @SortDirection = 1 THEN
            CASE @SortColumn
                WHEN 'user_id' THEN CAST(user_id AS NVARCHAR)
                WHEN 'full_name' THEN full_name
                WHEN 'date_of_birth' THEN CAST(date_of_birth AS NVARCHAR)
                WHEN 'gender' THEN gender
                WHEN 'registration_date' THEN CAST(registration_date AS NVARCHAR)
            END
        END DESC
    OFFSET (@PageNumber - 1) * @PageSize ROWS  -- ��������: ���������� ������
    FETCH NEXT @PageSize ROWS ONLY;            -- ������� ������� ������
END;

EXEC dbo.sp_GetUsers
    @Name = '����',
    @PageNumber = 1,
    @SortColumn = 'user_id',
    @SortDirection = 0;
