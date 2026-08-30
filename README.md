# REDCap-PowerBI-ETL
An API-driven approach for connecting REDCap data with Microsoft Power BI using Power Query (M), with an emphasis on automation, data minimization, and PHI/PII control.

## Overview

This repository provides example Power Query (M) implementations for extracting data from a REDCap project through the REDCap API and preparing the data for Power BI.

The project demonstrates three progressively improved approaches:

1. Basic REDCap API extraction
2. Field-level data selection
3. REDCap report-level extraction for improved data minimization

The goal is to demonstrate how API-driven data integration can reduce manual CSV exports, streamline reporting workflows, and improve access to timely survey data.

> **Important:** These scripts are provided as templates. They contain placeholders and should be adapted to the security, governance, and infrastructure requirements of the organization implementing them.

---

## Why REDCap → Power BI?

Traditional survey reporting workflows may require repeated manual exports, file handling, and data preparation before information can be visualized.

An API-driven workflow can instead allow Power BI to retrieve the latest available REDCap data during refresh and transform the response directly within Power Query.

### Traditional workflow

REDCap  
↓  
Manual CSV export  
↓  
Save/manage files  
↓  
Import into Power BI  
↓  
Transform data  
↓  
Dashboard

### API-driven workflow

REDCap  
↓  
REDCap API  
↓  
Power Query (M)  
↓  
Data transformation  
↓  
Power BI  
↓  
Dashboard

This approach can reduce repetitive manual steps and support more standardized reporting workflows.

---

# Methods

## Method 1: Basic REDCap API Extraction

The first implementation demonstrates a direct API request to REDCap using Power Query.

The request:

- Connects to the REDCap API endpoint
- Sends the project API token securely through the request body
- Requests records in CSV format
- Specifies a REDCap form
- Selects specific fields
- Applies REDCap filter logic
- Imports the response into Power BI

### Workflow

```text
Power BI
   |
   v
Power Query
   |
   v
REDCap API
   |
   v
CSV response
   |
   v
Power BI data model
