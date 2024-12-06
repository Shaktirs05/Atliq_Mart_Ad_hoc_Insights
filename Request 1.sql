/* 1.Provide a list of products with a base price greater than 500 and that are featured in promo type of
'BOGOF' (Buy One Get One Free). This information will help us identify high-value products that are currently
being heavily discounted, which can be useful for evaluating our pricing and promotion strategies
*/

select 
	p.product_name,
	e.base_price,
	e.promo_type
from 
	fact_events e 
join dim_products p
	on e.product_code = p.product_code
where base_price > 500 
	and promo_type = 'BOGOF'
group by 
	product_name,
	promo_type,
	base_price;
