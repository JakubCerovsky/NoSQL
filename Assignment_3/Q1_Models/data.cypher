// Clean database
MATCH (n) DETACH DELETE n;

// Constraints
CREATE CONSTRAINT book_asin_unique IF NOT EXISTS FOR (b:Book) REQUIRE b.asin IS UNIQUE;
CREATE CONSTRAINT order_id_unique IF NOT EXISTS FOR (o:Order) REQUIRE o.id IS UNIQUE;
CREATE CONSTRAINT customer_email_unique IF NOT EXISTS FOR (c:Customer) REQUIRE c.email IS UNIQUE;
CREATE CONSTRAINT genre_name_unique IF NOT EXISTS FOR (g:Genre) REQUIRE g.name IS UNIQUE;

// Entry 1 – The Mystery Case
MERGE (catFiction:Category {title: "Fiction"})
  ON CREATE SET catFiction.description = "General fiction";

MERGE (genre1:Genre {name: "Mystery"})
MERGE (char1:Character {name: "Hannibal Lecter"})
MERGE (cat1:Category {title: "Detective Fiction", description: "Mystery and detective stories"})
MERGE (cat1)-[:PARENTS]->(catFiction)

CREATE (auth1:Author {first_name: "Jane", last_name: "Smith", biography: "Renowned historian"})
CREATE (book1:Book {
  asin: "B002", title: "The Mystery Case", description: "A thrilling detective story",
  language: "English", publish_date: date("2021-05-20"), publisher: "HarperCollins",
  page_count: 280, no_of_copies: 15, price: 14.99
})
CREATE (auth1)-[:WRITES]->(book1)
CREATE (book1)-[:BELONGS_TO]->(genre1)
CREATE (char1)<-[:CONTAINS]-(book1)
CREATE (book1)-[:BELONGS_TO]->(cat1)

CREATE (cust1:Customer {
  email: "jane.smith@example.com", first_name: "Jane", last_name: "Smith",
  country: "Canada", city: "Toronto", street: "Queen St", house_no: "202", post_no: "M5H 2N2"
})
CREATE (order1:Order {id: "ORD002", date: date("2023-02-10"), total_price: 14.99})
CREATE (cust1)-[:MAKES]->(order1)
CREATE (order1)-[:CONTAINS {quantity: 1, price: 14.99}]->(book1);

// Entry 2 – Galactic Wars
MERGE (genre2:Genre {name: "Science Fiction"})
MERGE (char2:Character {name: "Winston Smith"})
MERGE (cat2:Category {title: "Space Opera", description: "Epic space adventures"})
MERGE (cat2)-[:PARENTS]->(catFiction)

CREATE (auth2:Author {first_name: "Alice", last_name: "Brown", biography: "Award-winning fantasy author"})
CREATE (book2:Book {
  asin: "B003", title: "Galactic Wars", description: "Space battles and aliens",
  language: "English", publish_date: date("2020-07-10"), publisher: "Orbit",
  page_count: 450, no_of_copies: 12, price: 24.99
})
CREATE (auth2)-[:WRITES]->(book2)
CREATE (book2)-[:BELONGS_TO]->(genre2)
CREATE (char2)<-[:CONTAINS]-(book2)
CREATE (book2)-[:BELONGS_TO]->(cat2)

CREATE (cust2:Customer {
  email: "alice.brown@example.com", first_name: "Alice", last_name: "Brown",
  country: "UK", city: "London", street: "Baker St", house_no: "303", post_no: "NW1 6XE"
})
CREATE (order2:Order {id: "ORD003", date: date("2023-03-05"), total_price: 24.99})
CREATE (cust2)-[:MAKES]->(order2)
CREATE (order2)-[:CONTAINS {quantity: 1, price: 24.99}]->(book2);

// Entry 3 – Magical Realms
MERGE (genre3:Genre {name: "Fantasy"})
MERGE (char3:Character {name: "Dragons"})
MERGE (cat3:Category {title: "Fantasy", description: "Fantasy books"})
MERGE (cat3)-[:PARENTS]->(catFiction)

CREATE (auth3:Author {first_name: "Bob", last_name: "Johnson", biography: "Sci-fi master"})
CREATE (book3:Book {
  asin: "B004", title: "Magical Realms", description: "A fantasy epic",
  language: "English", publish_date: date("2019-11-30"), publisher: "Tor Books",
  page_count: 500, no_of_copies: 8, price: 29.99
})
CREATE (auth3)-[:WRITES]->(book3)
CREATE (book3)-[:BELONGS_TO]->(genre3)
CREATE (char3)<-[:CONTAINS]-(book3)
CREATE (book3)-[:BELONGS_TO]->(cat3)

CREATE (cust3:Customer {
  email: "bob.johnson@example.com", first_name: "Bob", last_name: "Johnson",
  country: "Australia", city: "Sydney", street: "George St", house_no: "404", post_no: "2000"
})
CREATE (order3:Order {id: "ORD004", date: date("2023-04-12"), total_price: 29.99})
CREATE (cust3)-[:MAKES]->(order3)
CREATE (order3)-[:CONTAINS {quantity: 1, price: 29.99}]->(book3);

// Entry 4 – Love in Paris
MERGE (genre4:Genre {name: "Drama"})
MERGE (char4:Character {name: "Jay Gatsby"})
MERGE (cat4:Category {title: "Romance", description: "Romantic stories"})
MERGE (cat4)-[:PARENTS]->(catFiction)

CREATE (auth4:Author {first_name: "Clara", last_name: "Williams", biography: "Mystery novelist"})
CREATE (book4:Book {
  asin: "B005", title: "Love in Paris", description: "A romantic tale",
  language: "French", publish_date: date("2018-06-18"), publisher: "Hachette",
  page_count: 320, no_of_copies: 20, price: 12.99
})
CREATE (auth4)-[:WRITES]->(book4)
CREATE (book4)-[:BELONGS_TO]->(genre4)
CREATE (char4)<-[:CONTAINS]-(book4)
CREATE (book4)-[:BELONGS_TO]->(cat4)

CREATE (cust4:Customer {
  email: "clara.williams@example.com", first_name: "Clara", last_name: "Williams",
  country: "Germany", city: "Berlin", street: "Unter den Linden", house_no: "505", post_no: "10117"
})
CREATE (order4:Order {id: "ORD005", date: date("2023-05-20"), total_price: 12.99})
CREATE (cust4)-[:MAKES]->(order4)
CREATE (order4)-[:CONTAINS {quantity: 1, price: 12.99}]->(book4);

// Entry 5 – Hearts in Winter (Jakub with 2 orders)
MERGE (genre5:Genre {name: "Romance"})
MERGE (char5:Character {name: "Ella Winters"})
MERGE (cat5:Category {title: "Contemporary Romance", description: "Modern love stories"})
MERGE (cat5)-[:PARENTS]->(catFiction)

CREATE (auth5:Author {first_name: "Emma", last_name: "Davis", biography: "Romance storyteller"})
CREATE (book5:Book {
  asin: "B011", title: "Hearts in Winter", description: "A touching winter romance",
  language: "English", publish_date: date("2024-02-14"), publisher: "Snowbound Press",
  page_count: 310, no_of_copies: 20, price: 13.99
})
CREATE (auth5)-[:WRITES]->(book5)
CREATE (book5)-[:BELONGS_TO]->(genre5)
CREATE (char5)<-[:CONTAINS]-(book5)
CREATE (book5)-[:BELONGS_TO]->(cat5)

CREATE (cust5:Customer {
  email: "jakub@gmail.com", first_name: "Jakub", last_name: "Sliwa",
  country: "Denmark", city: "Aarhus", street: "5th Avenue", house_no: "101", post_no: "8800"
})
CREATE (order5a:Order {id: "ORD006", date: date("2025-05-03"), total_price: 13.99})
CREATE (cust5)-[:MAKES]->(order5a)
CREATE (order5a)-[:CONTAINS {quantity: 1, price: 13.99}]->(book5)

// Jakub's second order (for "The Mystery Case")
MATCH (cust:Customer {email: "jakub@gmail.com"}), (book:Book {asin: "B002"})
CREATE (o:Order {id: "ORD007", date: date("2025-05-10"), total_price: 14.99})
CREATE (cust)-[:MAKES]->(o)
CREATE (o)-[:CONTAINS {quantity: 1, price: 14.99}]->(book)
