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

### Code See:

code/01-basic-redcap-api/redcap_api_basic.m
```
## Method 2: Field-Level Data Selection

The second implementation improves control over the data retrieved from REDCap.

Instead of retrieving an entire dataset, the API request explicitly identifies the variables required for reporting.

The implementation also demonstrates retrieving the API token from a local protected text file rather than embedding the token directly in the Power Query script.

### Key concepts
Explicit field selection
External token storage
HTTPS API requests
CSV parsing
Header promotion
REDCap filter logic
Reduced unnecessary data transfer

```
### Workflow
Protected token location
          |
          v
      Power Query
          |
          v
     REDCap API
          |
          v
 Selected variables
          |
          v
      Power BI
```
### Important security note

Field-level selection reduces the amount of data retrieved, but it does not automatically guarantee that PHI/PII is excluded.

If selected fields contain identifiers or sensitive information, those fields will still be transferred into Power BI.

Therefore, field selection should be considered a data-minimization technique rather than a complete PHI/PII protection mechanism.

### Code See:

code/02-field-level-data-selection/redcap_field_selection.m

## Method 3: REDCap Report-Level Data Minimization

The third implementation uses a REDCap report as the source of the Power BI extraction.

Instead of allowing Power BI to determine the complete set of records and fields directly, the REDCap report is configured in REDCap to contain only the data appropriate for downstream reporting.

Power BI then requests that report through the REDCap API.

### Workflow
```

REDCap Project
     |
     v
REDCap Report
(approved fields only)
     |
     v
REDCap API
     |
     v
Power Query
     |
     v
Power BI
```

This approach introduces an additional governance layer between the underlying REDCap project and the reporting environment.

## Why this approach?

A REDCap report can be configured so that the downstream reporting dataset contains only the variables necessary for the intended analytical or visualization purpose.

This supports the principle of data minimization:

Only transfer the information necessary for the intended reporting purpose.

## Important distinction

The security of this approach depends on how the REDCap report is configured.

A report containing PHI/PII will still transfer PHI/PII to Power BI.

Therefore, organizations should ensure that:

- The REDCap report contains only approved variables
- Direct identifiers are excluded when not required
- Access permissions are appropriately configured
- Power BI workspace permissions are appropriately configured
- API credentials are protected
- Organizational data governance requirements are followed

### Code See:

code/03-report-level-data-minimization/redcap_report_export.m

## Security and Data Protection

Security should be considered throughout the entire data pipeline rather than only within the Power Query code.

## This repository intentionally contains:

- No real API tokens
- No production REDCap URLs
- No patient-level data
- No PHI/PII
- No organization-specific credentials
- No production report identifiers

All sensitive values have been replaced with placeholders.

### API Token Handling

The examples demonstrate retrieving the API token from a protected local location rather than hard-coding the credential directly into the M script.

Example:

YOUR_FIREWALL_LOCATION/TOKEN.txt

The actual token file should never be committed to GitHub.

### Data Minimization

Data minimization can occur at multiple stages:

- REDCap project configuration
- REDCap reports
- API request parameters
- Power Query transformations
- Power BI data model
- Power BI workspace and access controls

The preferred approach is to minimize sensitive data as early in the pipeline as practical.
```
### Project Architecture

The overall architecture demonstrated in this repository is:

                  REDCap
                    |
                    |
              REDCap API
                    |
                    v
              Power Query
                  (M)
                    |
                    v
             Data Transformation
                    |
                    v
                Power BI
                    |
                    v
              Dashboard

For the report-based approach:

                  REDCap
                    |
                    v
             Approved Report
                    |
                    v
              REDCap API
                    |
                    v
              Power Query
                  (M)
                    |
                    v
                Power BI

```
### Prerequisites

The examples assume access to:

- A REDCap project
- REDCap API access
- An appropriately scoped REDCap API token
- Microsoft Power BI Desktop
- Power Query
- Permission to access the REDCap API endpoint
- An organizational environment that permits the intended data flow
- 
## Configuration

Replace the following placeholders with environment-specific values.
```
YOUR_REDCAP_URL
YOUR_RELATIVE_PATH
YOUR_PROJECT_TOKEN
YOUR_REPORT_ID
YOUR_FIREWALL_LOCATION
```
Do not commit actual credentials or sensitive configuration values.

### Example REDCap API Parameters

The examples use parameters such as:
```
content
format
form
fields
filterLogic
report_id
```
These parameters control what REDCap returns to Power Query.

The exact fields and filtering logic should be adapted to the REDCap project and reporting requirements.

## Reproducibility

The repository is designed to demonstrate the technical pattern rather than provide a production-ready implementation for every REDCap environment.

Organizations may need to modify:
```
API endpoints
Authentication mechanisms
Network configuration
Token storage
REDCap permissions
Report configuration
Data governance controls
Power BI security
Refresh configuration
```
## Use Cases
Potential applications include:
```
Survey reporting
Program monitoring
Quality improvement dashboards
Research reporting
Administrative reporting
Health program evaluation
Agency-level performance monitoring
```
## Key Takeaway

The progression across the three approaches demonstrates an important principle:

Connecting REDCap to Power BI is not only an ETL problem. It is also a data governance and data minimization problem.

A successful implementation should consider not only how to retrieve data, but also:
```
What data should be retrieved?
Where should sensitive data be filtered?
Who should have access?
How should credentials be protected?
How can unnecessary PHI/PII exposure be minimized?
How can the reporting workflow be automated and standardized?
```
## Conference Poster

This repository accompanies my REDCap conference poster on API-driven REDCap → Power BI integration.

The poster provides the high-level workflow and methodology, while this repository provides the corresponding example Power Query (M) implementations.

#### Poster: REDCap → Power BI ETL and data-minimization approaches

## Disclaimer

These examples are provided for educational and demonstration purposes.

They are not intended to replace institutional information security policies, REDCap governance procedures, HIPAA requirements, data use agreements, or organizational policies governing protected or sensitive information.

Before implementing these workflows with real-world data, organizations should conduct an appropriate security, privacy, and governance review.

## Author

Dr. Keshav Kumar
k.keshav@wustl.edu

