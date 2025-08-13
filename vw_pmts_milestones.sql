CREATE OR REPLACE VIEW vw_pmts_milestones AS
    SELECT 
        pmts_milestones.order_number,
        pmts_milestones.customer_number,
        pmts_milestones.date_invoiced,
        pmts_milestones.pmt_terms,
        pmts_milestones.pmt_received,
        pmts_milestones. project_id,
        customer_list.customer_segment,
        pmts_milestones.project_product_id,
        pmts_milestones.pmt_due_milestones,
        pmts_milestones.Invoice_number
	from pmts_milestones
Left Join customer_list
	ON pmts_milestones.customer_number = customer_list.customer_number
where
customer_list.customer_segment IS NOT null;
    
select * from vw_pmts_milestones;