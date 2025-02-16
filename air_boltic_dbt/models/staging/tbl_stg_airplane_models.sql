{{config (materialized='table')}}

SELECT 
    a.airplane_id,
    a.airplane_model,
    a.manufacturer,
    b.max_seats,
    b.max_weight,
    b.max_distance,
    b.engine_type
FROM {{ source ('aeroplane_csv_sources','raw_air_boltic_aeroplane_data')}} as a
INNER JOIN {{ source ('aeroplane_csv_sources','air_boltic_aeroplane_model_data')}} as b
ON a.airplane_model = b.model AND a.manufacturer = b.manufacturer
