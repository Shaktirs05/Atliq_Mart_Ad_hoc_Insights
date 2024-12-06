/*4.Produce a report that calculates the Incremental sold Quantity (ISU%) for each category during the Diwali campaign.
Additionally,provide rankings for the categories based on their ISU% The report will include three key firlds:
category,isu%, and rank order. The information will assist in assessing the category-wise
success and impact of the Diwali campaign on incremental sales.

Note: ISU% (Incremental Sold Quantity Percentage) is calculated as the percentage increase/decreases in quantity sold (after promo) 
compared to quantity sold (befor promo)
*/

with cte1 as (
select *,
	(if (promo_type = 'BOGOF',e.quantity_sold_after_promo*2,e.quantity_sold_after_promo)) as quantit_sold_after_promo
from 
	fact_events e
join 
	dim_campaigns c 
		using(campaign_id)
join 
	dim_products p 
		using (product_code)
where 
	campaign_name = 'Diwali'
),
cte2 as (
select
	campaign_name,
    category,
	((sum(quantit_sold_after_promo)-sum(quantity_sold_before_promo))/sum(quantity_sold_before_promo))*100 as ISU_pct
from 
	cte1 
group by 
	category
)
select 
	campaign_name,
	category,
	ISU_pct,
rank() over (order by ISU_pct desc) as rank_order 
from cte2;
