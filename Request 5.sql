/*5. Create a report featuring the Top 5 products, ranked by Incremental Revenue Percentage (IR%), across all campaigns. 
The report will provide essential informattion including product name,category, and ir%.The analysis helps
identify the most successful products in terms of incremental revenue across our campaigns, assisting in products optimixation.
*/

with cte1 as(
select 
	category,
	product_name,
	sum(base_price * quantity_sold_before_promo) as Total_Revenue_BP,
	sum(
		case
			when promo_type = "BOGOF" then base_price * 0.5 * 2*(quantity_sold_after_promo)
			when promo_type = "50% OFF" then base_price * 0.5 * quantity_sold_after_promo
			when promo_type = "25% OFF" then base_price * 0.75* quantity_sold_after_promo
			when promo_type = "33% OFF" then base_price * 0.67 * quantity_sold_after_promo
			when promo_type = "500 cashback" then (base_price-500)*  quantity_sold_after_promo
			end) as Total_Revenue_AP FROM retail_events_db.fact_events 
join 
	dim_products 
		using (product_code) 
group by 
	product_name,
    category
),
cte2 as(
select *,
	(total_revenue_AP - total_revenue_BP) as IR,  
	((total_revenue_AP - total_revenue_BP)/total_revenue_BP) * 100 as IR_pct
from 
	cte1
)
select 
	product_name,
	category,
	IR,
	IR_pct, 
rank() over(order by IR_pct DESC ) as Rank_IR 
from cte2 
limit 5;
