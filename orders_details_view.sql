-- Link Orders to Product Segments, Customers, and milestone revenue
create or replace view vw_orders_details AS
Select
	order_number,
	order_details.project_id, 
    contract_master.contract_id,
    customer_list.customer_name,
	contract_master.customer_number,
    customer_list.customer_segment, 
    order_details.product,
    product_list.segment,
    date_sold,
    sum(milestone_tracking.Revenue) AS 'Total Milestone Revenue',
    sum(milestone_tracking.Cost) AS 'Total Milestone Cost'
From order_details
Left Join contract_master
	On order_details.project_id = contract_master.Project_Number
Left Join product_list
	ON order_details.product = Product_list.product
Left Join customer_list
	ON contract_master.customer_number = customer_list.customer_number
Left Join milestone_tracking
	ON order_details.project_id = milestone_tracking.project_id
    AND order_details.product_id = milestone_tracking.product_id
Group By 
	order_number,
	order_details.project_id, 
    contract_id,
	contract_master.customer_number,
    customer_list.customer_name,	
    customer_list.customer_segment, 
    order_details.product,
    product_list.segment,
    date_sold;
#see table
Select * from vw_orders_details;

