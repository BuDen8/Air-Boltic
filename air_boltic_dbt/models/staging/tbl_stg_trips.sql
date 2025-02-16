{{config (
    unique_key = 'trip_id',
    incremental_strategy = 'merge',
    merge_update [
        'dwh_modified_timestamp',
        'origin_city',
        'destination_city',
        'airplane_id',
        'trip_start_timestamp',
        'trip_end_timesatmp',
        'trip_duration_hours',
        'is_trip_completed'
    ]
    materialized = 'incremental',
    partition_by = {
        "field": "start_timestamp",
        "data_type": "timestamp",
        "granularity": "day",
    }
    cluster_by = 'trip_id')}}

SELECT 
    CURRENT_TIMESTAMP() as dwh_created_timestamp,
    CURRENT_TIMESTAMP() AS dwh_modified_timestamp,
    t.trip_id,
    t.origin_city,
    t.destination_city,
    t.airplane_id,
    t.start_timestamp AS trip_start_timestamp,
    t.end_timestamp AS trip_end_timesatmp,
    TIMESTAMPDIFF(HOUR, departure_time, arrival_time) AS trip_duration_hours,
    CASE
        WHEN end_timestamp IS NULL THEN 0
        ELSE 1
    END AS is_trip_completed
FROM {{source ('aeroplane_csv_sources','raw_air_boltic_trip_data')}} t
{if is_incremental() %}
WHERE t.start_timestamp > (select max(trip_start_timestamp) from {{ this }}) 
{% endif %}