with source AS (
    SELECT *
    FROM {{source('raw','dedup_matches_final')}}
)

SELECT *
FROM source