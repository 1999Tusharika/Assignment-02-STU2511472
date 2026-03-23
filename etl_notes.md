## ETL Decisions

### Decision 1 — Date Format Standardization
Problem: The raw data contained inconsistent date formats such as `29/08/2023`, `2023-02-05`, and `12-12-2023`. This inconsistency made it difficult to join with the date dimension and run time-based queries.
Resolution: All dates were converted into ISO format (`YYYY-MM-DD`) during the ETL process. This ensured uniformity and allowed easy mapping to the `dim_date` table.

### Decision 2 — Category Casing Normalization
Problem: Product categories were inconsistently labeled, e.g., `electronics`, `Electronics`, `Groceries`, and `Grocery`. This inconsistency caused grouping errors in analytical queries.
Resolution: Categories were standardized to three consistent values: **Electronics**, **Clothing**, and **Grocery**. This normalization ensured accurate aggregation and reporting.

### Decision 3 — Missing Store City Values
Problem: Several records had missing or NULL values in the `store_city` column (e.g., `Mumbai Central, , Atta 10kg`). This created issues when analyzing sales by city.
Resolution: Missing city values were filled based on the store name. For example, `Mumbai Central` was mapped to `Mumbai`, `Chennai Anna` to `Chennai`, etc. This ensured completeness of the `dim_store` table and reliable city-level reporting.
