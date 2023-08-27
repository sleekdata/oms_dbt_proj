-- Define the expected record counts for each table
{% set expected_counts = {
  'customers': 50,
  'employees': 20,
  'stores': 10,
  'suppliers': 5,
  'products': 100,
  'orderitems': 1000,
  'orders': 200
} %}

-- Test the count of records in each table
{% for table, expected_count in expected_counts.items() %}
  SELECT '{{ table }}' AS table_name,
         (SELECT COUNT(*) FROM {{ source('landing', table) }}) AS record_count,
         {{ expected_count }} AS expected_count
  WHERE (SELECT COUNT(*) FROM {{ source('landing', table) }}) < {{ expected_count }}
  {% if not loop.last %} UNION ALL {% endif %}
{% endfor %}