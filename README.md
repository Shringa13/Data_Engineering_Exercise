# Data_Engineering_Exercise

This exercise is to do reverse engineer the database design and comes up the intial design for the data warehouse. The information given was:

**1)** There are two web-based applications, the Shopping web application, and the Order and Fulfillment web application. Together these
applications support Retro Boards' three business processes: shopping, ordering, and fulfillment.
  There are only two tables in the database: **Products and Tracking**
  
**2)** The Order and Fulfillment web application:
The following tables are available:**order, online_line_item, customer, customer_address, order_fulfillment and employee table**

## Business flow:
**1)** When a new customer lands on the website either through a web search or through advertisments on Google and Bing, a tracking id is generated and associated with the user.  
**2)** When a customer submits an order, she is required to either create an account or login to her existing account.
While a customer is completing an order (e.g. reviewing the items, providing payment information, etc.) the status is
IN_PROGRESS.  
**3)** After a customer submits an order, the order is set to SUBMITTED status.  
**4)** The order is routed to a warehouse employee's queue for packing and shipping.  
**5)** A warehouse employee picks up the items in the warehouse, packages the items, then ships the package to the
customer's destination (ship_to_address) address.  
**6)** When there is an issue with the order (e.g. wrong items in the package), the customer contacts the support team and
marks the order to either **CANCELLED, DISPUTED, or REFUNDED.**  

## LOG FILES  
System maintains 2 log files separately as a raw text files which are produced by the web applications.  

**1) Shopping log file:**  
      **-> Fields:** Timestamp in GMT, product_id, product_version, product short_name, shopping_event.  
        -> The shopping event is generally set to "viewed item", "added item to cart", "removed item from cart", "new anonymous shopper".  
       ->  Sample line from the log file:  
            **i)** 2018-02-10 15:00:01 product_id=12412312, product_version=2, product_short_name=Monopoly,
            shopping_event=added item to cart, customer_id=, generated_tracking_id=a20868ed-80f0-4b1d-8e85-
            e50f2cffe5f3  
            **ii)** 2018-02-10 15:02:01 product_id=5123123, product_version_id=1, product_short_name=Snakes and Ladders,
            shopping_event=remove from cart, customer_id=5123123, generated_tracking_id=210cccc0-04e0-4160-908fa734f156747e
            
**2) Order and Fullfillment log file:**  
      **-> Fields:** Timestamp in GMT, order_id, employee_id, and order_event.  
        -> The order_event is generally set to "submitted order", "no more items in inventory", "employee started packing", "employee    completed packing", "employee shipped package to customer".  
        -> Sample line from the log file:  
            2018-02-10 16:20:01 order_id=123123, employee_id=103, order_event=employee shipped package to customer  
