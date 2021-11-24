
WITH table1 AS (select distinct CAST(incident_zip AS STRING) as zipcode   
     from `data-project-329222.newyork_311.311-service-requests`),

table2 AS (select distinct CAST(zip_code AS STRING) as zipcode  
     from `data-project-329222.newyork_311.collisions`),

final as ( SELECT * from table1
UNION ALL
SELECT * from table2),

boroughs as (SELECT CAST(Zip AS STRING) AS Zip, Borough FROM `data-project-329222.newyork_311.Boroughs2`),

finalborough as (SELECT Borough,zipcode FROM final INNER JOIN boroughs ON Zip = zipcode)

SELECT distinct {{ dbt_utils.surrogate_key(['Borough', 'zipcode']) }} as location_dim_id,Borough,zipcode FROM finalborough