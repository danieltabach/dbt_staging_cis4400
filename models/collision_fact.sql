select date_dim_id, time_dim_id, location_dim_id, unique_key, number_of_cyclist_injured, 
number_of_cyclist_killed, number_of_motorist_injured, number_of_motorist_killed,
number_of_pedestrians_injured, number_of_pedestrians_killed,number_of_persons_injured,number_of_persons_killed
from `data-project-329222.newyork_311.collisions` as col
    inner join {{ref('date_dimension')}}as date_dimension on date_dimension.DATE_DAY = date(col.timestamp)
    inner join {{ref('location_dimension')}} as location_dimension on location_dimension.Borough = col.borough 
    and cast(location_dimension.zipcode as int) =col.zip_code
    inner join {{ref('time_dimension')}} as time_dimension on time_dimension.fulltime = time(col.timestamp)