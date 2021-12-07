SELECT unique_key,
created_date_dim.DATE_DIM_ID as Created_Date_Dim_ID,
closed_date_dim.DATE_DIM_ID as Closed_Date_Dim_ID, 
agency_dim_id, 
complaint_dim_id, 
time_dimension_closed.time_dim_id as closed_time, 
time_dimension_open.time_dim_id as open_time,
location_dimension.location_dim_id,
FROM `data-project-329222.newyork_311.311-service-requests` AS sr
INNER JOIN {{ref('date_dimension')}} AS created_date_dim 
On created_date_dim.DATE_DAY = date(sr.created_date)
INNER JOIN {{ref('date_dimension')}} AS closed_date_dim 
On closed_date_dim.DATE_DAY = date(sr.closed_date)
INNER JOIN {{ref('agency_dimension')}} AS agency_dim
On agency_dim.agency = sr.agency AND agency_dim.agency_name = sr.agency_name
INNER JOIN {{ref('complaint_dimension')}} AS complaint_dim ON
complaint_dim.complaint_type = sr.complaint_type AND complaint_dim.descriptor =
sr.descriptor
inner join {{ref('location_dimension')}} as location_dimension on location_dimension.Borough = sr.borough
and cast(location_dimension.zipcode as string) = cast(sr.incident_zip as string)
inner join {{ref('time_dimension')}} as time_dimension_open on time_dimension_open.fulltime = time(sr.created_date)
inner join {{ref('time_dimension')}} as time_dimension_closed on time_dimension_closed.fulltime = time(sr.closed_date)


