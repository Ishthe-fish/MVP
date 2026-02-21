WITH source as (
    SELECT *
    FROM {{source('raw','df1')}}
),

cleaned as (
    SELECT 
        LOWER(TRIM(fname)) as fname,
        LOWER(TRIM(lname)) as lname,
        LOWER(TRIM(email)) as email,
        row_number() over () - 1 as og_loc

    FROM source
)

SELECT * 
FROM cleaned


