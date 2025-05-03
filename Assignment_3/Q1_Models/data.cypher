// Clean database
// MATCH (n) DETACH DELETE n;

// Constraints
CREATE CONSTRAINT book_asin_unique IF NOT EXISTS FOR (b:Book) REQUIRE b.asin IS UNIQUE;
CREATE CONSTRAINT order_id_unique IF NOT EXISTS FOR (o:Order) REQUIRE o.id IS UNIQUE;
CREATE CONSTRAINT customer_email_unique IF NOT EXISTS FOR (c:Customer) REQUIRE c.email IS UNIQUE;

// Author
CREATE
(author:Author {
  first_name: "Isaac",
  last_name: "Asimov",
  biography: "Isaac Asimov was a prolific science fiction writer and biochemist."
}),

// Books
(book1:Book {
  title: "Foundation",
  `description `: "A visionary novel about the decline and fall of a galactic empire.",
  language: "English",
  publish_date: "1951-06-01",
  publisher: "Gnome Press",
  page_count: "255",
  no_of_copies: "10",
  price: "15.99",
  asin: "B000FC0RZK"
}),
(book2:Book {
  title: "I, Robot",
  `description `: "A collection of short stories about robotics and AI.",
  language: "English",
  publish_date: "1950-12-02",
  publisher: "Gnome Press",
  page_count: "224",
  no_of_copies: "8",
  price: "12.50",
  asin: "B000OIZU8K"
}),

// Author writes books
(author)-[:writes]->(book1),
(author)-[:writes]->(book2),

// Genres
(genre1:Genre {name: "Science Fiction"}),
(genre2:Genre {name: "Artificial Intelligence"}),

(book1)-[:belongs_to]->(genre1),
(book2)-[:belongs_to]->(genre2),

// Characters
(character1:Character {name: "Hari Seldon"}),
(character2:Character {name: "Robbie"}),

(character1)<-[:contains]-(book1),
(character2)<-[:contains]-(book2),

// Categories and parent relationship
(cat1:Category {title: "Fiction", description: "Fictional books"}),
(cat2:Category {title: "Sci-Fi", description: "Science fiction genre"})-[:parents]->(cat1),

(book1)-[:belongs_to]->(cat2),
(book2)-[:belongs_to]->(cat2),

// Customer
(customer:Customer {
  email: "jane.doe@example.com",
  first_name: "Jane",
  last_name: "Doe",
  country: "USA",
  city: "New York",
  street: "5th Avenue",
  house_no: "101",
  post_no: "10001"
}),

// Order
(order:Order {
  id: "ORD001",
  date: "2025-05-03",
  total_price: "28.49"
}),

(customer)-[:makes]->(order),

(order)-[:contains {quantity: "1", price: "15.99"}]->(book1),
(order)-[:contains {quantity: "1", price: "12.50"}]->(book2);
