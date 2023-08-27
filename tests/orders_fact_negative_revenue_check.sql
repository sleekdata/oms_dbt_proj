SELECT OrderID
FROM {{ ref('orders_fact') }}
WHERE Revenue < 0