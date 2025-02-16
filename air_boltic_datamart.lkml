explore: air_boltic_trips {
  label: "Air Boltic Trips"
  description: "Explores Air Boltic trip, customer and order data from the datamart."
  sql_table_name: tbl_air_boltic_datamart
}

view: air_boltic_datamart_trips {
  sql_table_name: `dev.air_boltic_datamart_trips`;

# ------ DIMENSIONS --------
  dimension: order_id {
    type: string
    primary_key: yes
    sql: ${TABLE}.order_id ;;
  }
  
  dimension: price_eur {
    type: number
    sql: ${TABLE}.price_eur ;;
  }
    
  dimension: seat_no {
    type: string
    sql: ${TABLE}.seat_no ;;
  }
  
  dimension: trip_status {
    type: string
    sql: ${TABLE}.trip_status ;;
  }


  dimension: origin_city {
    type: string
    sql: ${TABLE}.origin_city ;;
  }
  
  dimension: destination_city {
    type: string
    sql: ${TABLE}.destination_city ;;
  }
  
  dimension_group: trip_start_timestamp {
    type: time
    timeframes: [time, date, week, month, quarter, year]
    sql: ${TABLE}.trip_start_timestamp ;;
  }
  
  dimension: trip_end_timestamp {
    type: time
    timeframes: [time, date, week, month, quarter, year]
    sql: ${TABLE}.trip_end_timestamp ;;
  }
  
  dimension: trip_duration_hours {
    type: number
    sql: ${TABLE}.trip_duration_hours ;;
  }

  dimension: is_trip_completed {
    type: yesno
    sql: ${TABLE}.is_trip_completed ;;
  }

  dimension: customer_name {
    type: string
    sql: ${TABLE}.customer_name ;;
  }
  
  dimension: customer_email {
    type: string
    sql: ${TABLE}.customer_email ;;
  }
  
  dimension: customer_phone_number {
    type: string
    sql: ${TABLE}.customer_phone_number ;;
  }
  
  dimension: customer_group_id {
    type: string
    sql: ${TABLE}.customer_group_id ;;
  }
  
  dimension: customer_group_type {
    type: string
    sql: ${TABLE}.customer_group_type ;;
  }
  
  dimension: customer_group_name {
    type: string
    sql: ${TABLE}.customer_group_name ;;
  }

  
 dimension: airplane_model {
    type: string
    sql: ${TABLE}.airplane_model ;;
  }
  
  dimension: manufacturer {
    type: string
    sql: ${TABLE}.manufacturer ;;
  }
  
  dimension: max_seats {
    type: number
    sql: ${TABLE}.max_seats ;;
  }

  dimension: max_distance {
    type: number
    sql: ${TABLE}.max_distance ;;
  }

  dimension: engine_type {
    type: string
    sql: ${TABLE}.engine_type ;;
  } 
#---- MEASURES -----
  measure: price_eur_total {
    type: sum
    sql: ${TABLE}.price_eur ;;
  }
  
  measure: total_trip_duration_hours {
    type: sum
    sql: ${TABLE}.trip_duration_hours ;;
  }
    
  measure: total_max_seats {
    type: sum
    sql: ${TABLE}.max_seats ;;
  }
  
  dimension: max_weight {
    type: number
    sql: ${TABLE}.max_weight ;;
  }
  
  measure: total_max_weight {
    type: sum
    sql: ${TABLE}.max_weight ;;
  }
  
  
  measure: total_max_distance {
    type: sum
    sql: ${TABLE}.max_distance ;;
  }
  