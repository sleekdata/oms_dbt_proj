SELECT
    OS.StoreID,
    SUM(OFACT.Revenue) AS TotalRevenue
FROM
    {{ ref('orders_stg') }} OS
JOIN
    {{ ref('orders_fact') }} OFACT ON OS.OrderID = OFACT.OrderID
GROUP BY 1

