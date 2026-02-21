WITH source AS (SELECT *,
    CASE
        WHEN confidence_match_score >= 88 THEN 'high'
        WHEN confidence_match_score >= 80 THEN 'medium'
        ELSE 'low'
    END AS match_conf
FROM {{ref('stg_dedup_matches')}}
), 
cleaned AS (
    SELECT d.*, s.og_loc_x, s.og_loc_y, s.match_conf, s.confidence_match_score,
    ROW_NUMBER() OVER(PARTITION BY d.og_loc,s.og_loc_x ORDER BY confidence_match_score DESC) as cleaning_col
    FROM source s
    LEFT JOIN {{ref('stg_df1')}} d
    ON s.og_loc_x = d.og_loc
)
SELECT * 
FROM cleaned 
WHERE cleaning_col = 1