{{config (
    materialized = 'incremental',
    unique_key = 'customer_id',
    incremental_strategy = 'merge',
    merge_update_columns = [
        'dwh_modified_timestamp',
        'customer_name',
        'customer_group_id',
        'customer_email',
        'customer_phone_number',
        'customer_group_type',
        'customer_group_name',
        'customer_group_registry_number']
)}}

SELECT 
    CURRENT_TIMESTAMP() AS dwh_created_timestamp,
    CURRENT_TIMESTAMP() AS dwh_modified_timestamp,
    c.customer_id,
    c.customer_name,
    IFNULL(c.customer_group_id,0) as customer_group_id,
    CASE 
        WHEN c.email='' THEN NULL
        ELSE c.email
    END AS customer_email,
    CASE 
        WHEN c.phone_number='' THEN NULL
        ELSE c.phone_number
    END AS customer_phone_number,
    cg.group_type AS customer_group_type,
    cg.group_name, AS customer_group_name,
    cg.registry_number AS customer_group_registry_number
FROM {{ source('aeroplane_csv_sources','raw_air_boltic_customer_data') }} c
LEFT JOIN {{ source('aeroplane_csv_sources','raw_air_boltic_customer_group_data') }} cg
    ON c.customer_group_id = cg.customer_group_id
