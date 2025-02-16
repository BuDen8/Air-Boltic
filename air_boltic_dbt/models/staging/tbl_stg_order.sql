{{config (materialized='incremental', 
          unique_key='order_id',
          incremental_strategy='merge',
          merge_update_columns=[
                'dwh_modified_timestamp',
                'customer_id',
                'trip_id',
                'price_eur',
                'seat_no',
                'trip_status',
          cluster_by='order_id'
            ])
}}

SELECT 
    CURRENT_TIMESTAMP() as dwh_created_timestamp,
    CURRENT_TIMESTAMP() AS dwh_modified_timestamp,
    o.order_id,
    o.customer_id,
    o.trip_id,
    o.price_eur,
    o.seat_no,
    o.trip_status
FROM {{ source('aeroplane_csv_sources','raw_air_boltic_order_data') }} o
WHERE o.order_id > (select max(order_id) from {{ this }})