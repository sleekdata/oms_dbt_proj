{{ dbt_utils.deduplicate(
    relation=source('landing', 'orderitems'),
    partition_by='orderid',
    order_by="updated_at desc",
   )
}}