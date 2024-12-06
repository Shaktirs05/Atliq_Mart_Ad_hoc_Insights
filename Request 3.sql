/*3.Generate report that displays each campaign along with the total revenue genearted before and after the campaign? 
The report includes three key fields:
campaign_name,total_revenue(before_promotion),total_revenue(after_promotion).
This report should help in evaluating the financial impact of our promotional campaigns.(Dispaly the values in millions
*/

/*NOTE :- we use alter function to change name of column from `quantity_sold(before_promo)` to quantity_sold_before_promo
`quantity_sold(after_promo)` to quantity_sold_after_promo
ALTER TABLE fact_events 
CHANGE `quantity_sold(before_promo)` quantity_sold_before_promo INT NOT null;
select quantity_sold_before_promo from fact_events;

alter table fact_events
change `quantity_sold(after_promo)` quantity_sold_after_promo INT NOT NULL;
select quantity_sold_after_promo from fact_events;
*/

select 
     campaign_name,
     concat(round(sum(base_price * quantity_sold_before_promo) / 1000000,2),' M') as revenue_before_promo,
     concat(round(sum(case
            when promo_type = 'BOGOF' then base_price * 0.5 * (quantity_sold_after_promo * 2)
            when promo_type = '500 Cashback' then (base_price - 500) * quantity_sold_after_promo
            when promo_type = '50% OFF' then base_price * 0.5 * quantity_sold_after_promo
            when promo_type = '33% OFF' then base_price * 0.67 * quantity_sold_after_promo
            when promo_type = '25% OFF' then base_price * 0.75 * quantity_sold_after_promo end) / 1000000,2),' M') as revenue_after_promo
     from
		fact_events
     join
		dim_campaigns 
			using (campaign_id)
     group by 
		campaign_name;
     









