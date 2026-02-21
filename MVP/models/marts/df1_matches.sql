with clean AS (
    SELECT fname,lname,email,og_loc,og_loc_y,match_conf,confidence_match_score
    FROM {{ref('int_match_and_df1')}}
    ORDER BY confidence_match_score DESC
)

SELECT *
FROM clean