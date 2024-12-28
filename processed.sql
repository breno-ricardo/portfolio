-- I’m cleaning and preparing the table for future use. I start by inspecting the data, renaming columns for consistency, checking for null values, analyzing the table structure, and then standardizing the data types to ensure consistency and accuracy.

-- I start by previewing the first 10 records from the [Store Sales] table in the dbo schema to get an initial sense of the data.
SELECT TOP 10 *
FROM [dbo].[Store Sales]

-- -- I rename the columns to remove brackets and double quotes from their names. This makes the column names cleaner and easier to work with in queries.
EXEC sp_rename 'dbo.[Store Sales].["Store_Number"]', 'Store_Number', 'COLUMN';
EXEC sp_rename 'dbo.[Store Sales].["SKU_Coded"]', 'SKU_Coded', 'COLUMN';
EXEC sp_rename 'dbo.[Store Sales].["Product_Class_Code"]', 'Product_Class_Code', 'COLUMN';
EXEC sp_rename 'dbo.[Store Sales].["Sold_Date"]', 'Sold_Date', 'COLUMN';
EXEC sp_rename 'dbo.[Store Sales].["Qty_Sold"]', 'Qty_Sold', 'COLUMN';
EXEC sp_rename 'dbo.[Store Sales].["Total_Sale_Value"]', 'Total_Sale_Value', 'COLUMN';
EXEC sp_rename 'dbo.[Store Sales].["On_Promo"]', 'On_Promo', 'COLUMN';

-- I count the number of null values in each column to check for missing data that might need cleaning or handling later.
SELECT 
    SUM(CASE WHEN Store_Number IS NULL THEN 1 ELSE 0 END) AS Store_Number_Null,
    SUM(CASE WHEN SKU_Coded IS NULL THEN 1 ELSE 0 END) AS SKU_Coded_Null,
    SUM(CASE WHEN Product_Class_Code IS NULL THEN 1 ELSE 0 END) AS Product_Class_Code_Null,
    SUM(CASE WHEN Sold_Date IS NULL THEN 1 ELSE 0 END) AS Sold_Date_Null,
    SUM(CASE WHEN Qty_Sold IS NULL THEN 1 ELSE 0 END) AS Qty_Sold_Null,
    SUM(CASE WHEN Total_Sale_Value IS NULL THEN 1 ELSE 0 END) AS Total_Sale_Value_Null,
    SUM(CASE WHEN On_Promo IS NULL THEN 1 ELSE 0 END) AS On_Promo_Null
FROM dbo.[Store Sales];

-- I examine the table’s metadata to understand the column names, data types, maximum lengths, and whether null values are allowed. This helps me plan any required structural changes to the table.
SELECT 
    COLUMN_NAME AS NomeColuna, 
    DATA_TYPE AS TipoDado, 
    CHARACTER_MAXIMUM_LENGTH AS TamanhoMaximo,
    IS_NULLABLE AS PodeSerNulo
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Store Sales'
  AND TABLE_SCHEMA = 'dbo';

-- I adjust the data types of the columns to ensure they are properly formatted.
ALTER TABLE [dbo].[Store Sales]
ALTER COLUMN Store_Number INT;

ALTER TABLE [dbo].[Store Sales]
ALTER COLUMN SKU_Coded VARCHAR(20);

ALTER TABLE [dbo].[Store Sales]
ALTER COLUMN Product_Class_Code VARCHAR(10);

ALTER TABLE [dbo].[Store Sales]
ALTER COLUMN Sold_Date DATE;

ALTER TABLE [dbo].[Store Sales]
ALTER COLUMN Qty_Sold INT;

ALTER TABLE [dbo].[Store Sales]
ALTER COLUMN Total_Sale_Value DECIMAL(10, 2);

ALTER TABLE [dbo].[Store Sales]
ALTER COLUMN On_Promo BIT;