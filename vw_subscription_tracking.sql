CREATE OR REPLACE VIEW vw_subscription_tracking AS
    SELECT 
        subscription_tracking.project_id,
        subscription_tracking.contract_id,
        subscription_tracking.order_number,
        STR_TO_DATE(payment_date, '%m/%d/%Y') AS payment_date,
        customer_list.customer_name,
        customer_list.customer_number,
        customer_list.customer_segment,
        order_details.product,
        part_catalog.part_number,
        subscription_tracking.cost_line_item,
        subscription_tracking.monthly_cost,
        subscription_tracking.revenue AS monthly_revenue
    FROM
        subscription_tracking
            LEFT JOIN
        part_catalog ON subscription_tracking.cost_line_item = part_catalog.part_description
            LEFT JOIN
        contract_master ON subscription_tracking.contract_id = contract_master.contract_id
            LEFT JOIN
        customer_list ON contract_master.customer_number = customer_list.customer_number
            LEFT JOIN
        order_details ON CONCAT(subscription_tracking.project_id,
                subscription_tracking.product_id) = CONCAT(order_details.project_id,
                order_details.product_id)
    ORDER BY project_id;

SELECT 
    *
FROM
    vw_subscription_tracking