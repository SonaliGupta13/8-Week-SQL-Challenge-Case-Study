**Case Study #1 - Danny's Diner**

![1](https://user-images.githubusercontent.com/121818812/210263441-758fcde9-39a5-44dd-9e0e-cd5f8879b310.png)

**Introduction**

Danny seriously loves Japanese food so in the beginning of 2021, he decides to embark upon a risky venture and opens up a cute little restaurant that sells his 3 favourite foods: sushi, curry and ramen.

Danny’s Diner is in need of your assistance to help the restaurant stay afloat - the restaurant has captured some very basic data from their few months of operation but have no idea how to use their data to help them run the business.

**Problem Statemen**

Danny wants to use the data to answer a few simple questions about his customers, especially about their visiting patterns, how much money they’ve spent and also which menu items are their favourite. Having this deeper connection with his customers will help him deliver a better and more personalised experience for his loyal customers.

He plans on using these insights to help him decide whether he should expand the existing customer loyalty program - additionally he needs help to generate some basic datasets so his team can easily inspect the data without needing to use SQL.

Danny has provided you with a sample of his overall customer data due to privacy issues - but he hopes that these examples are enough for you to write fully functioning SQL queries to help him answer his questions!

Danny has shared with you 3 key datasets for this case study:

sales
menu
members

**Table 1: sales**
The sales table captures all customer_id level purchases with an corresponding order_date and product_id information for when and what menu items were ordered.

**Table 2: menu**
The menu table maps the product_id to the actual product_name and price of each menu item.

**Table 3: members**
The final members table captures the join_date when a customer_id joined the beta version of the Danny’s Diner loyalty program.

**Case Study Questions**

Each of the following case study questions can be answered using a single SQL statement:

Q.1 What is the total amount each customer spent at the restaurant?

Q.2 How many days has each customer visited the restaurant?

Q.3What was the first item from the menu purchased by each customer?

Q.4 What is the most purchased item on the menu and how many times was it purchased by all customers?

Q.5 Which item was the most popular for each customer?

Q.6 Which item was purchased first by the customer after they became a member?

Q.7 Which item was purchased just before the customer became a member?

Q.8 What is the total items and amount spent for each member before they became a member?

Q.9 If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?

Q.10 Join All The Things recreate the table with: customer_id, order_date, product_name, price, member (Y/N)

**Insights Generated**

1) Customer with id 'A' spent most while customer with id 'C' spent least.

2) Customer with id 'B' visited maximum number of times.

3) Ramen was the most famous item ordered by 8 number of times.

4) Customer with id 'B' taste all items equally,it looks like he/she is foody.

5) Maximum points scored by customer with id 'B'.
