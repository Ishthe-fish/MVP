# Dedup Matcher

Open-source duplicate detection tool for messy cross-source CSV data.

A common problem in analytics/compliance roles: the same person appears across multiple data sources (or even within one) with slight variations in name, email, etc. This tool helps identify those matches efficiently.

Uses:
- **Blocking heuristics** (prefix concatenation on multiple columns) to reduce comparisons.
- **RapidFuzz** for accurate fuzzy similarity scoring.
- Hybrid confidence score combining blocking strength + fuzzy match.

Runs locally on any two CSVs — no cloud, no setup.

## Demo & Test Data

Included `master_example.csv` contains 20 fake records:
- 10 belong to `df1.csv`
- 10 belong to `df2.csv`
- Intentional duplicates with variations (nicknames, typos, email differences) marked in `dupe?` column.

Running the tool on this data correctly identifies 5 cross-table matches with high confidence (97–78 scores), proving it catches real-world messy duplicates.

## Usage Notes

To run the tool:

- **Input Files**:
  - Two CSVs to compare: name them `df1.csv` and `df2.csv` (or edit filenames in code).
  
- **Schema File** (`colsofinterest.csv`):
  - Single column named exactly `col_name`.
  - List only **string columns** to match on (e.g., fname, lname, email).
  - Names must match CSV headers exactly.

  Example:

  col_name
  fname
  lname
  email


  
- **Tips**:
- Tool prioritizes **cross-table matches** (records linking df1 ↔ df2).
- Internal duplicates (within same file) are detected via blocking but not prioritized in output.
- To find **internal duplicates only**, run the tool on one CSV against a copy of itself (df1 vs df1).
- String columns are auto-lowercased and stripped.
- Output saved to `dedup_matches.csv` — sorted by confidence (higher = stronger match).

- **Planned for v2**:
- Configurable thresholds
- Numeric/date fuzzy support
- Simple web UI
- Better internal duplicate handling

Feedback, issues, or feature requests welcome — always building!

#Python #DataCleaning #DataEngineering #Pandas #OpenSource #DataQuality

