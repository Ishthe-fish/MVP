## Usage Notes

To run the tool successfully, follow these requirements:

- **Input Files**:
  - Name your two data CSVs exactly: `df1.csv` and `df2.csv` (or change the filenames in the code).
  - These are the two sources you want to deduplicate/match across.

- **Schema File** (`colsofinterest.csv`):
  - Must contain **one column** named exactly `col_name` (no header typos).
  - List **only string-type columns** you want to match on (e.g., `fname`, `lname`, `email`).
  - Column names **must match exactly** the headers in df1.csv and df2.csv.
  - Example content:
    ```
    col_name
    fname
    lname
    email
    ```

- **Important Tips**:
  - The tool currently focuses on **cross-table matches** (records linking df1 ↔ df2).
  - Internal duplicates (within the same file) are detected but not prioritized in the final output.
  - All string columns in the schema are automatically lowercased and stripped during cleaning.
  - Results are saved to `dedup_matches.csv` — sorted by hybrid confidence score (higher = better match).
  - For best results, include strong identifiers like name parts, email, phone, or address fields.

- **Future Improvements (Planned for v2)**:
  - Configurable thresholds
  - Support for numeric/date fuzzy matching
  - Simple web/UI version
  - Internal duplicate prioritization

Feel free to open an issue with feedback or feature requests!
