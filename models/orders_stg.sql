{{
    config( materialized='incremental',
            unique_key='ORDERID')
}}

SELECT
    OrderID,
    OrderDate,
    CustomerID,
    EmployeeID,
    StoreID,
    Status AS StatusCD,
    CASE
        WHEN Status = '01' THEN 'In Progress'
        WHEN Status = '02' THEN 'Completed'
        WHEN Status = '03' THEN 'Cancelled'
        ELSE NULL
    END AS StatusDesc,
    CASE
        WHEN StoreID = 1000 THEN 'Online'
        ELSE 'In-store'
    END AS ORDER_CHANNEL,
    Updated_at,
    current_timestamp as dbt_updated_at
FROM
    {{ source('landing', 'orders') }}

{% if is_incremental() %}
where  Updated_at >= (select max(dbt_updated_at) from {{ this }})
{% endif %}
