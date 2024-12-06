/*2.Generate a report that provides an overview of the number of stores in each city the results will be sorted
descinding order of stores counts, allowing us to identify the cities with the highest store presence.
The report includes two essential fields : city and store count, which will assist in optimizing our retail operations
*/
select 
	s.city,
	count(s.store_id) as store_count
from 
	dim_stores s
group by 
	city
order by 
	store_count desc;
