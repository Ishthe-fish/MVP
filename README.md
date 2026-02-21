# Dedup Matcher v2 — Python + Postgres + dbt

A warehouse-integrated duplicate detection pipeline built for messy, cross-source data.

What started as a standalone Python fuzzy matching script has evolved into a production-style analytics engineering workflow. This version separates compute (Python) from modeling (dbt) and treats deduplication as part of a structured warehouse system rather than a local-only script.

---

## Problem

In analytics, compliance, and operational roles, the same individual often appears across multiple data sources (or within one source) with slight variations:

- Nicknames vs. legal names  
- Typos  
- Email variations  
- Formatting inconsistencies  

Identifying those duplicates accurately — without exploding comparison volume — is a common and expensive problem.

---

## Architecture Overview

### 1️⃣ Raw Layer (PostgreSQL)

- Raw CSVs are ingested into a dedicated `raw` schema in Postgres.
- Data is preserved exactly as received.
- Matching results from Python are written back into the warehouse.

---

### 2️⃣ Compute Layer (Python)

- Blocking heuristics reduce comparison volume using prefix concatenation across multiple columns.
- RapidFuzz performs fuzzy similarity scoring.
- A hybrid confidence score combines blocking strength and fuzzy similarity.
- Results are written to `raw.dedup_matches_final`.

---

### 3️⃣ Modeling Layer (dbt)

dbt structures transformations into three layers:

#### 🔹 Staging
- Standardizes raw inputs (lowercasing, trimming, type enforcement)
- Ensures consistent schemas
- Prepares data for joins and scoring

#### 🔹 Intermediate
- Applies business logic
- Joins standardized inputs with Python match results
- Categorizes confidence scores (high / medium / low)
- Uses window functions to remove duplicate match artifacts

#### 🔹 Marts
- Materialized as **tables** (not views)
- Produce decision-ready datasets for stakeholder review
- Allow teams to compare matched records directly against original sources
- Designed for operational use and audit workflows

---

## Key Features

- Blocking heuristics to reduce computational complexity  
- RapidFuzz fuzzy similarity scoring  
- Hybrid confidence scoring model  
- Warehouse-native architecture  
- dbt lineage documentation (`dbt docs generate`)  
- Layered transformation structure (staging → intermediate → marts)  
- Match score integrity validation tests  

---

## Demo Data

The repository includes `master_example.csv` containing 20 synthetic records:

- 10 belong to `df1`
- 10 belong to `df2`
- Intentional cross-table duplicates with realistic variations

Running the pipeline correctly identifies 5 cross-table matches with high confidence scores (97–78 range), demonstrating effectiveness on messy real-world scenarios.

---

## How to Run

### 🐍 Python Matching Engine

1. Provide:
   - `df1.csv`
   - `df2.csv`
   - `colsofinterest.csv`

2. `colsofinterest.csv` must contain a single column named exactly:
Example:
col_name
fname
lname
email

3. Run the Python matching script.
4. Results are saved and written into Postgres.

---

### 🔄 dbt Transformation

1. Configure `profiles.yml` to connect to Postgres.
2. Run:
3. Generate documentation:
dbt docs generate
dbt docs serve

This exposes full lineage and model documentation via a local web server.

---

## Architectural Evolution (v1 → v2)

### v1
- Local-only script  
- CSV in → CSV out  
- No warehouse integration  

### v2
- CSV → Postgres raw schema  
- Python compute layer  
- Results written back to warehouse  
- dbt structured modeling  
- Business-ready mart tables  
- Full lineage documentation  

The biggest shift is architectural.  
Separating compute from modeling transforms this from a script into a scalable analytics engineering workflow.

---

## Future Improvements

- Configurable confidence thresholds  
- Numeric and date fuzzy support  
- Incremental dbt models  
- UI for stakeholder review  
- Match audit logging  

---

## Why This Matters

This project demonstrates how data quality logic can be embedded inside a warehouse-native transformation workflow rather than living as an isolated script.

It reflects production-style thinking around:

- Separation of concerns  
- Schema design  
- Materialization strategy  
- Model layering  
- Data lineage  
- Business-ready outputs  

---

Built to explore scalable duplicate detection within a modern analytics engineering stack.
