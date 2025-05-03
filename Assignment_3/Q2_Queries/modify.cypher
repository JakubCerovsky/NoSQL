// Modifying data

// 1.	Sell a book to a customer.
MATCH (c:Customer {email: "john.doe@example.com"}), (b:Book {asin: "B001"})
CREATE (o:Order {id: "ORD11", date: date("2025-05-03"), total_price: b.price}),
       (c)-[:makes]->(o),
       (o)-[:contains {quantity: 1, price: b.price}]->(b)
SET b.no_of_copies = b.no_of_copies - 1;

// 2.	Change the address of a customer.
MATCH (c:Customer {email: "jane.smith@example.com"})
SET c.city = "Vancouver",
    c.street = "Broadway",
    c.house_no = "505",
    c.post_no = "V5K 0A1";

// 3.	 Add an existing author to a book.
MATCH (a:Author {first_name: "Alice", last_name: "Brown"}), (b:Book {asin: "B002"})
MERGE (a)-[:writes]->(b);

// 4.	Retire the "Space Opera" category and assign all books from that category to the parent category. Don't assume you know the id of the parent category.
MATCH (oldCat:Category {title: "Space Opera"})-[:parents]->(parent:Category)
MATCH (b:Book)-[r:belongs_to]->(oldCat)
MERGE (b)-[:belongs_to]->(parent)
DELETE r;

// 5.	Sell 3 copies of one book and 2 of another in a single order
MATCH (c:Customer {email: "alice.brown@example.com"}), 
      (b1:Book {asin: "B004"}), 
      (b2:Book {asin: "B005"})
CREATE (o:Order {id: "ORD12", date: date("2025-05-03"), total_price: 3 * b1.price + 2 * b2.price}),
       (c)-[:makes]->(o),
       (o)-[:contains {quantity: 3, price: b1.price}]->(b1),
       (o)-[:contains {quantity: 2, price: b2.price}]->(b2)
SET b1.no_of_copies = b1.no_of_copies - 3,
    b2.no_of_copies = b2.no_of_copies - 2;