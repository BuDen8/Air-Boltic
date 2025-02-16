-- Create table for raw_air_boltic_aeroplane_data
CREATE TABLE raw_air_boltic_aeroplane_data (
    airplane_id INT,
    airplane_model STRING,
    manufacturer STRING
)
USING DELTA
LOCATION 's3://air-boltic/path/to/csv/raw_air_boltic_aeroplane_data.csv';

-- Create table for raw_air_boltic_customer_data
CREATE TABLE raw_air_boltic_customer_data (
    customer_id INT,
    customer_name STRING,
    customer_group_id INT,
    email STRING,
    phone_number STRING

)
USING DELTA
LOCATION 's3://air-boltic/path/to/csv/raw_air_boltic_customer_data.csv';

-- Create table for raw_air_boltic_customer_group_data
CREATE TABLE raw_air_boltic_customer_group_data(
    customer_group_id INT,
    group_type STRING,
    group_name STRING,
    registry_number STRING
)
USING DELTA
LOCATION 's3://air-boltic/path/to/csv/raw_air_boltic_customer_group_data.csv'
;

-- Create table for raw_air_boltic_order_data
CREATE TABLE raw_air_boltic_order_data (
    order_id INT,
    customer_id INT,
    trip_id INT,
    price_eur INT,
    seat_no STRING,
    trip_status STRING
)
USING DELTA
LOCATION 's3://air-boltic/path/to/csv/raw_air_boltic_order_data.csv'
;

-- Create external Delta table for raw_air_boltic_trip_data
CREATE TABLE IF NOT EXISTS raw_air_boltic_trip_data (
    trip_id INT,
    origin_city STRING,
    destination_city STRING,
    airplane_id INT,
    start_timestamp STRING,
    end_timestamp STRING
)
USING DELTA
LOCATION 's3://air-boltic/path/to/csv/raw_air_boltic_trip_data.csv'
;

-- Read JSON data from S3
CREATE OR REPLACE TEMP VIEW aircraft_specs_json AS
SELECT
    explode(from_json(json_data, 'map<string,map<string,struct<max_seats:int,max_weight:int,max_distance:int,engine_type:string>>>')) AS (manufacturer, models)
FROM (
    SELECT
        cast(content AS string) AS json_data
    FROM
        json.`s3://air-boltic/path/to/json/aeroplane_model.json`
);

-- Create table for aircraft_specs
CREATE TABLE IF NOT EXISTS air_boltic_aeroplane_model_data
USING DELTA
AS
SELECT
    manufacturer,
    model,
    specs.max_seats,
    specs.max_weight,
    specs.max_distance,
    specs.engine_type
FROM (
    SELECT
        manufacturer,
        model,
        specs
    FROM (
        SELECT
            manufacturer,
            explode(models) AS (model, specs)
        FROM
            aircraft_specs_json
    )
);