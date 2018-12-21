# Data_Engineering_Exercise

This exercise is to do reverse engineer the database design and comes up the intial design for the data warehouse. The information given was:

**1)** There are two web-based applications, the Shopping web application, and the Order and Fulfillment web application. Together these
applications support Retro Boards' three business processes: shopping, ordering, and fulfillment.
  There are only two tables in the database: **Products and Tracking**
  
**2)** The Order and Fulfillment web application:
The following tables are available:**order, online_line_item, customer, customer_address, order_fulfillment and employee table**

## Business flow:
**1)** When a new customer lands on the website either through a web search or through advertisments on Google and Bing, a tracking id is generated and associated with the user.
When a customer submits an order, she is required to either create an account or login to her existing account.
While a customer is completing an order (e.g. reviewing the items, providing payment information, etc.) the status is
IN_PROGRESS.
After a customer submits an order, the order is set to SUBMITTED status.
The order is routed to a warehouse employee's queue for packing and shipping.
A warehouse employee picks up the items in the warehouse, packages the items, then ships the package to the
customer's destination (ship_to_address) address.
When there is an issue with the order (e.g. wrong items in the package), the customer contacts the support team and
marks the order to either CANCELLED, DISPUTED, or REFUNDED.
