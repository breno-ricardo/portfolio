-- Checked the total number of records available in the table
SELECT COUNT(*) AS TotalRows
FROM dbo.[Store Sales];

-- Determined the total number of unique stores and distinct products (SKUs) sold.
SELECT 
    COUNT(DISTINCT Store_Number) AS Total_Stores, 
    COUNT(DISTINCT SKU_Coded) AS Total_SKUs
FROM 
    dbo.[Store Sales];

-- Calculated the average price and identified products with the highest sales volume and total revenue.
SELECT 
    SKU_Coded, 
    CAST(ROUND(AVG(Total_Sale_Value / Qty_Sold), 2) AS DECIMAL(10,2)) AS AvgPrice, 
    SUM(Qty_Sold) AS Qty_Sold, 
    SUM(Total_Sale_Value) AS Total_Sales
FROM 
    dbo.[Store Sales]
GROUP BY 
    SKU_Coded
ORDER BY 
    Total_Sales DESC;

-- Analyzed sales performance by store, including total sales and average price per unit sold.
SELECT 
    Store_Number, 
    SUM(Total_Sale_Value) AS TotalSales, 
    ROUND(AVG(Total_Sale_Value / Qty_Sold), 2) AS AvgPrice
FROM 
    dbo.[Store Sales]
GROUP BY 
    Store_Number
ORDER BY 
    TotalSales DESC;

-- Summarized total sales by date and promotional status, including average price.
SELECT 
    Sold_Date, 
    On_Promo, 
    COUNT(*) AS TotalRecords, 
    SUM(Total_Sale_Value) AS TotalSales, 
    ROUND(AVG(Total_Sale_Value / Qty_Sold), 2) AS AvgPrice
FROM 
    dbo.[Store Sales]
GROUP BY 
    Sold_Date, On_Promo
ORDER BY 
    Sold_Date, On_Promo;
