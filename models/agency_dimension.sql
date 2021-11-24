select distinct
    {{ dbt_utils.surrogate_key(['agency_name', 'agency']) }} as agency_dim_id,
    agency_name,
    agency   
    from 
    ( select distinct agency_name, agency   
     from `data-project-329222.newyork_311.311-service-requests`
    )
