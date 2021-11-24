select distinct
    {{ dbt_utils.surrogate_key(['complaint_type', 'descriptor']) }} as complaint_dim_id,
    complaint_type,
    descriptor   
    from 
    ( select distinct complaint_type, descriptor   
     from `data-project-329222.newyork_311.311-service-requests`
     WHERE complaint_type = 'Street Condition'
    )