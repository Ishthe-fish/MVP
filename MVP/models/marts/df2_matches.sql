with clean AS (
    SELECT fname,lname,address,gender, email,og_loc,og_loc_x,match_conf,confidence_match_score
    FROM {{ref('int_match_and_df2')}}
    ORDER BY confidence_match_score DESC
)

SELECT *
FROM clean