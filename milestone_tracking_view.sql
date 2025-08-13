create or replace view vw_milestone_tracking AS
SELECT
milestone_tracking.project_id,
milestone_tracking.contract_id,
order_details.order_number,
customer_list.customer_name,
customer_list.customer_number,
customer_list.customer_segment,
part_catalog.part_number,
order_details.product,
milestone_tracking.cost_line_item,
milestone_tracking.milestone_date,
milestone_tracking.Cost,
milestone_tracking.Revenue

From milestone_tracking
Left Join vw_product_list
	ON milestone_tracking.product_id = vw_product_list.product_id
Left Join contract_master
	ON milestone_tracking.contract_id = contract_master.contract_id
Left Join customer_list
	ON contract_master.customer_number = customer_list.customer_number
Left Join part_catalog
	ON milestone_tracking.cost_line_item = part_catalog.part_description
LEFT JOIN order_details 
	ON concat(milestone_tracking.project_id, milestone_tracking.product_id) = concat(order_details.project_id, order_details.product_id)
WHERE order_details.order_number IS NOT NULL
order by milestone_tracking.project_id;

Select * from vw_milestone_tracking
where contract_id = 'CTRX-95F3-C04E-3475';