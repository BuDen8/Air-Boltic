config (materialized='incremental',
    unique_key='order_id',
    incremental_strategy='merge',
    merge_update_columns=[
    'dwh_modified_timestamp',
    'price_eur',
    'seat_no',
    'trip_status',
    'origin_city',
    'destination_city',
    'trip_start_timestamp',
    'trip_end_timestamp',
    'trip_duration_hours',
    'is_trip_completed',
    'customer_name',
    'customer_email',
    'customer_phone_number',
    'customer_group_id',
    'customer_group_type',
    'customer_group_name',
    'customer_group_registry_number',
    'airplane_model',
    'manufacturer',
    'max_seats',
    'max_weight',
    'max_distance',
    'engine_type'
    ],
    partition_by={
        "field": "start_timestamp",
        "data_type": "timestamp",
        "granularity": "day",
    }
    cluster_by = 'order_id'
)

SELECT 
    CURRENT_TIMESTAMP() as dwh_created_timestamp,
    CURRENT_TIMESTAMP() AS dwh_modified_timestamp,
    o.order_id,
    o.customer_id,
    o.price_eur,
    o.seat_no,
    o.trip_status,
    t.origin_city,
    t.destination_city,
    t.airplane_id,
    t.trip_start_timestamp,
    t.trip_end_timestamp,
    t.trip_duration_hours,
    t.is_trip_completed,
    c.customer_name,
    c.customer_email,
    c.customer_phone_number,
    c.customer_group_id,
    c.customer_group_type,
    c.customer_group_name,
    c.customer_group_registry_number
    a.airplane_model,
    a.manufacturer,
    a.max_seats,
    a.max_weight,
    a.max_distance,
    a.engine_type
FROM {{ref('tbl_stg_orders')}} o
INNER JOIN {{ref('tbl_stg_trips')}} t
    ON o.trip_id = t.trip_id
INNER JOIN {{ref('tbl_stg_customers')}} c
    ON o.customer_id = c.customer_id
INNER JOIN {{ref('tbl_stg_airplane_models')}} a
    ON t.airplane_id = a.airplane_id
WHERE 1=1
{if is_incremental() %}
AND
    (o.dwh_modified_timestamp > CURRENT_TIMESTAMP() - INTERVAL 1 DAY
    OR t.dwh_modified_timestamp > CURRENT_TIMESTAMP() - INTERVAL 1 DAY
    OR c.dwh_modified_timestamp > CURRENT_TIMESTAMP() - INTERVAL 1 DAY)
{% endif %}