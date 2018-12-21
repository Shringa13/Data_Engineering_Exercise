--1. All orders during the Month Of December 2017


      Select * from order
      where DATEPART(MONTH,date_created) = 12
      and DATEPART (YEAR,date_created) = 2017
    

--2. All orders that were shipped to customers this week.
    
    
      Select * from order
      where date_shipped between DATEADD(day,1- DATEPART(dw,getdate()),cast(getdate() as date)) and DATEADD(day, 7- DATEPART(dw,getdate()),cast(getdate() as date));
    

--3. All customers that have atleast submitted one order last year, but have not submitted any order this year.

      -- I used CTE to store temporary result set of finding out the list of customers who submitted  atleast 1 order last year and but none in the current year and store result in a temporary 
      --result set in a CTE (prev_cust). Here, I am not sure about the data size thats why used CTE orelse if huge dataset is present and if have to find somethign like this  then we use temp table
      --with indexing.
      
      with prev_cust (cust_id,cnt_order)  -- Pulling 2 fields customer ID and number of orders
      AS
      (
        select 
          distinct o.customer_id as cust_id,
          count(o.order_id) as cnt_order
        FROM order as o
        where DATEPART(YEAR,o.date_submitted) != DATEPART(YEAR,getdate()) and DATEPART(YEAR,o.date_submitted) = DATEPART(YEAR,DATEADD(YEAR,-1,getdate()))
        and o.order_status ='SUBMITTED'
        group by o.customer_id
        having count(o.order_id) >=1
      )
      
      -- By using temporary result set (prev_cust), customer and order table we can pull the correct customer details as asked in question.
      select  distinct
	      c.customer_id,
	      c.first_name,
	      c.last_name,
	      pc.cnt_order
      from prev_cust pc inner join customer c on (pc.cust_id = c.customer_id) -- Joining with customer table
      INNER JOIN order so on (pc.cust_id = so.customer_id)                    -- Joining with order table
      order by c.customer_id;                                                 -- sort by Customer ID




--4. All employees that have had at least 5 disputed orders in the last 6 months

   --Again creating CTE named as disp_emp which pulls all the employee IDs having atleast 5 orders in disputed status within last 6 months

      with disp_emp (emp_id,cnt_disp)  -- Pulling 2 fields employee ID and number of disputes
      AS
      (
      select
         orf.employee_id as emp_id,
         count(orf.employee_id) as cnt_disp
      From ship_order as so INNER JOIN order_fulfillment as orf ON (orf.order_id = so.order_id)
      Where so.date_last_updated between cast(DATEADD(MONTH,-6,cast(getdate() as date))as date) and cast(getdate() as date)
      and so.order_status = 'DISPUTED'
      group by (orf.employee_id)
      having count(orf.employee_id)>=5
      )
      
      -- By using above temporary result we will now fetch all the employees data
      select 
          e.*,
          de.cnt_disp as num_disputed_order
      FROM disp_emp de INNER JOIN employee as e ON (e.employee_id =  de.emp_id); -- joining with employee table
