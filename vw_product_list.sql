create or replace view vw_product_details AS
select 
part_number, 
Product, 
segment,
cost_line_item_details.cost_line_item
from product_list
left join cost_line_item_details
	on concat(product,'-',segment) = cost_line_item_details.product_id;
    
select * from vw_product_details;