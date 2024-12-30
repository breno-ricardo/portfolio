-- Added a calculated column to determine the unit price of each product.
ALTER TABLE dbo.[Store Sales]
ADD Unit_Price AS (Total_Sale_Value / Qty_Sold);

-- Added a calculated column to indicate whether a product was on promotion with a 'Yes' or 'No' label.
ALTER TABLE dbo.[Store Sales]
ADD Promo_Status AS 
CASE WHEN On_Promo = 1 THEN 'Yes' ELSE 'No' END;

-- Created a summarized table to calculate total monthly sales grouped by year and month.
SELECT 
    YEAR(Sold_Date) AS Year,
    MONTH(Sold_Date) AS Month,
    SUM(Total_Sale_Value) AS Monthly_Sales
INTO Sales_By_Month
FROM dbo.[Store Sales]
GROUP BY YEAR(Sold_Date), MONTH(Sold_Date);

-- Created a summarized table to calculate the average sales per store.
SELECT 
    Store_Number, 
    AVG(Total_Sale_Value) AS Avg_Sales_Per_Store
INTO Store_Performance
FROM [Store Sales]
GROUP BY Store_Number;
