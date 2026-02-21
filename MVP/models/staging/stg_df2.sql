WITH source as (
    SELECT *
    FROM {{source('raw','df2')}}
),

cleaned as (
    SELECT 
        LOWER(TRIM(fname)) as fname,
        LOWER(TRIM(lname)) as lname,
        LOWER(TRIM(email)) as email,
        LOWER(TRIM(address)) as address,
        LOWER(TRIM(gender)) as gender,
        row_number() over () - 1 as og_loc
        
    FROM source
)

SELECT * 
FROM cleaned
