# Air-Boltic

## Overview  
This repository contains the implementation of an **incremental data pipeline** for Air-Boltic using **dbt, Databricks, and Looker**.  

## Repository Structure  
The repo consists of the following components:  

1. **dbt Core Project**  
   - A `dbt` project configured with `dbt-databricks` to transform raw data into a structured **datamart**.  
   - Implements **incremental models** with `merge_update_columns` for optimized data updates.  

2. **Delta Table Script (`delta_tables_script.sql`)**  
   - An example SQL script demonstrating how **Delta tables** would be created in **Databricks**.  
   - Assumes a fictional **S3 storage location** for raw data ingestion.  

3. **LookML Configuration**  
   - Defines an **Explore** that connects Looker to the **final datamart** in dbt.  


## Additional Resources  
For a deeper understanding of the solution architecture and implementation details, refer to the **context document**:  
[Solution Documentation & ERD](https://docs.google.com/document/d/1W04gBfo_bpGOIeDRofLLMP1Sk-_qe_6f2Auk6QofioI/edit?tab=t.0)  
