# __8 Figure : AI Data Engineering Assesment__

## __1. Overview__

This project demonstrates a data engineering workflow built for an assessment. It showcases skills in data ingestion via API, data transformation using Python, and data persistence in a multi-layered medallion architecture (Bronze, Silver, Gold). The entire ETL (Extract, Transform, Load) process is orchestrated and automated using n8n. The final aggregated metrics are stored in PostgreSQL and made available for visualization in Metabase.

## __2. Objective__
The goal is to evaluate the approach to data ingestion, modeling, and making metrics accessible. This is not intended to be a production-ready system but a clear demonstration of:

- __Data Engineering Thinking__: Architectural design and data modeling.

- __SQL Proficiency__: Complex query writing for data transformation and aggregation.

- __Automation Skills__: Using n8n to build a robust, scheduled data pipeline.



## __3. Architecture & Technology Stack__
3.1. Medallion Architecture
The data is processed through three distinct layers, each serving a specific purpose:

- Bronze (Raw Layer): Stores the raw, unprocessed data as it was ingested from the source. The schema is applied, and basic data typing is enforced.

- Silver (Refined Layer): Contains cleaned, enriched, and transformed data. This layer often involves joining datasets and preparing data for business analysis.

- Gold (Aggregated Layer): Stores highly aggregated data, often in the form of business-level metrics, ready for consumption by dashboards and reports.

### __3.2. Tools & Technologies__
Component	Technology	Purpose
Orchestration	n8n	Workflow automation and pipeline orchestration.
Ingestion	n8n HTTP Request Node	Pulling raw CSV data from a remote source.
Transformation	n8n Code Node (Python)	Parsing, cleaning, and type casting raw data.
Persistence	PostgreSQL	Relational database for storing Bronze, Silver, and Gold layer tables.
Visualization	Metabase	Business Intelligence tool for exploring and visualizing the 


