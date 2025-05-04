// Clean database
// MATCH (n) DETACH DELETE n;

// Constraints
CREATE CONSTRAINT book_asin_unique IF NOT EXISTS FOR (b:Book) REQUIRE b.asin IS UNIQUE;
CREATE CONSTRAINT order_id_unique IF NOT EXISTS FOR (o:Order) REQUIRE o.id IS UNIQUE;
CREATE CONSTRAINT customer_email_unique IF NOT EXISTS FOR (c:Customer) REQUIRE c.email IS UNIQUE;

SHOW CONSTRAINTS;

CREATE
// Authors
(author1:Author {first_name: "John", last_name: "Doe", biography: "Bestselling fiction writer"}),
(author2:Author {first_name: "Jane", last_name: "Smith", biography: "Renowned historian"}),
(author3:Author {first_name: "Alice", last_name: "Brown", biography: "Award-winning fantasy author"}),
(author4:Author {first_name: "Bob", last_name: "Johnson", biography: "Sci-fi master"}),
(author5:Author {first_name: "Clara", last_name: "Williams", biography: "Mystery novelist"}),
(author6:Author {first_name: "David", last_name: "Miller", biography: "Horror expert"}),
(author7:Author {first_name: "Emma", last_name: "Davis", biography: "Romance storyteller"}),
(author8:Author {first_name: "Frank", last_name: "Wilson", biography: "Self-help guru"}),
(author9:Author {first_name: "Grace", last_name: "Moore", biography: "Biography specialist"}),
(author10:Author {first_name: "Harry", last_name: "Anderson", biography: "Philosophy thinker"}),

// Books
(book1:Book {asin: "B001", title: "The Great Adventure", description: "An exciting journey", language: "English", publish_date: "2022-01-15", publisher: "Penguin", page_count: 350, no_of_copies: 10, price: 19.99}),
(book2:Book {asin: "B002", title: "The Mystery Case", description: "A thrilling detective story", language: "English", publish_date: "2021-05-20", publisher: "HarperCollins", page_count: 280, no_of_copies: 15, price: 14.99}),
(book3:Book {asin: "B003", title: "Galactic Wars", description: "Space battles and aliens", language: "English", publish_date: "2020-07-10", publisher: "Orbit", page_count: 450, no_of_copies: 12, price: 24.99}),
(book4:Book {asin: "B004", title: "Magical Realms", description: "A fantasy epic", language: "English", publish_date: "2019-11-30", publisher: "Tor Books", page_count: 500, no_of_copies: 8, price: 29.99}),
(book5:Book {asin: "B005", title: "Love in Paris", description: "A romantic tale", language: "French", publish_date: "2018-06-18", publisher: "Hachette", page_count: 320, no_of_copies: 20, price: 12.99}),
(book6:Book {asin: "B006", title: "The Haunted House", description: "A chilling horror story", language: "English", publish_date: "2017-09-14", publisher: "Bloomsbury", page_count: 290, no_of_copies: 18, price: 16.99}),
(book7:Book {asin: "B007", title: "Historical Legends", description: "Stories from history", language: "English", publish_date: "2016-03-22", publisher: "Oxford Press", page_count: 400, no_of_copies: 9, price: 22.99}),
(book8:Book {asin: "B008", title: "The Business Mind", description: "Success strategies", language: "English", publish_date: "2015-12-05", publisher: "Harvard Press", page_count: 275, no_of_copies: 14, price: 17.99}),
(book9:Book {asin: "B009", title: "The Philosopher’s Thought", description: "Deep reflections", language: "English", publish_date: "2014-08-29", publisher: "Cambridge", page_count: 360, no_of_copies: 11, price: 21.99}),
(book10:Book {asin: "B010", title: "War and Peace", description: "A historical masterpiece", language: "Russian", publish_date: "1869-01-01", publisher: "Vintage", page_count: 1200, no_of_copies: 5, price: 39.99}),

// Author-Book relationships
(author1)-[:writes]->(book1),
(author2)-[:writes]->(book1),
(author2)-[:writes]->(book2),
(author3)-[:writes]->(book3),
(author4)-[:writes]->(book4),
(author5)-[:writes]->(book5),
(author6)-[:writes]->(book6),
(author7)-[:writes]->(book7),
(author8)-[:writes]->(book8),
(author9)-[:writes]->(book9),
(author10)-[:writes]->(book10),

// Categories
(cat1:Category {title: "Science Fiction & Fantasy", description: "Fictional books"}),
(cat2:Category {title: "Fantasy", description: "Fantasy books"}),
(cat3:Category {title: "Science Fiction", description: "Sci-fi books"}),
(cat4:Category {title: "Myths & Legends", description: "Mythical books"}),
(cat5:Category {title: "Superhero", description: "Superhero books"}),
(cat6:Category {title: "Space Opera", description: "Space opera books"}),
(cat7:Category {title: "Time Travel", description: "Time travel books"}),
(cat8:Category {title: "History", description: "Historical books"}),
(cat9:Category {title: "Biography", description: "Biographical books"}),
(cat10:Category {title: "Philosophy", description: "Philosophical books"}),

// Category hierarchy
(cat2)-[:parents]->(cat1),
(cat3)-[:parents]->(cat1),
(cat4)-[:parents]->(cat2),
(cat5)-[:parents]->(cat2),
(cat6)-[:parents]->(cat3),
(cat7)-[:parents]->(cat3),

// Book-Category relationships
(book1)-[:belongs_to]->(cat2),
(book1)-[:belongs_to]->(cat9),
(book2)-[:belongs_to]->(cat5),
(book3)-[:belongs_to]->(cat3),
(book4)-[:belongs_to]->(cat4),
(book4)-[:belongs_to]->(cat7),
(book4)-[:belongs_to]->(cat9),
(book5)-[:belongs_to]->(cat7),
(book6)-[:belongs_to]->(cat6),
(book7)-[:belongs_to]->(cat8),
(book8)-[:belongs_to]->(cat6),
(book8)-[:belongs_to]->(cat1),
(book9)-[:belongs_to]->(cat6),
(book9)-[:belongs_to]->(cat3),
(book10)-[:belongs_to]->(cat8),

// Genres
(genre1:Genre {name: "Thriller"}),
(genre2:Genre {name: "Adventure"}),
(genre3:Genre {name: "Fantasy"}),
(genre4:Genre {name: "Science Fiction"}),
(genre5:Genre {name: "Drama"}),
(genre6:Genre {name: "Mystery"}),
(genre7:Genre {name: "Historical Fiction"}),
(genre8:Genre {name: "Dystopian"}),
(genre9:Genre {name: "Comedy"}),
(genre10:Genre {name: "Philosophy"}),

// Book-Genre relationships
(book1)-[:belongs_to]->(genre1),
(book3)-[:belongs_to]->(genre2),
(book2)-[:belongs_to]->(genre3),
(book3)-[:belongs_to]->(genre4),
(book8)-[:belongs_to]->(genre4),
(book5)-[:belongs_to]->(genre6),
(book1)-[:belongs_to]->(genre7),
(book10)-[:belongs_to]->(genre8),
(book1)-[:belongs_to]->(genre8),

// Characters
(char1:Character {name: "Angels"}),
(char2:Character {name: "Wizards"}),
(char3:Character {name: "Pirates"}),
(char4:Character {name: "Dragons"}),
(char5:Character {name: "Gods"}),
(char6:Character {name: "Dracula"}),
(char7:Character {name: "Jay Gatsby"}),
(char8:Character {name: "Holden Caulfield"}),
(char9:Character {name: "Winston Smith"}),
(char10:Character {name: "Hannibal Lecter"}),

// Book-Character relationships
(book6)-[:contains]->(char1),
(book5)-[:contains]->(char2),
(book8)-[:contains]->(char4),
(book1)-[:contains]->(char6),
(book2)-[:contains]->(char7),
(book3)-[:contains]->(char8),
(book6)-[:contains]->(char9),
(book9)-[:contains]->(char10),

// Customers
(cust1:Customer {email: "john.doe@example.com", first_name: "John", last_name: "Doe", country: "USA", city: "New York", street: "5th Avenue", house_no: "101", post_no: "10001"}),
(cust2:Customer {email: "jane.smith@example.com", first_name: "Jane", last_name: "Smith", country: "Canada", city: "Toronto", street: "Queen St", house_no: "202", post_no: "M5H 2N2"}),
(cust3:Customer {email: "alice.brown@example.com", first_name: "Alice", last_name: "Brown", country: "UK", city: "London", street: "Baker St", house_no: "303", post_no: "NW1 6XE"}),
(cust4:Customer {email: "bob.johnson@example.com", first_name: "Bob", last_name: "Johnson", country: "Australia", city: "Sydney", street: "George St", house_no: "404", post_no: "2000"}),
(cust5:Customer {email: "clara.williams@example.com", first_name: "Clara", last_name: "Williams", country: "Germany", city: "Berlin", street: "Unter den Linden", house_no: "505", post_no: "10117"}),
(cust6:Customer {email: "david.miller@example.com", first_name: "David", last_name: "Miller", country: "France", city: "Paris", street: "Champs-Élysées", house_no: "606", post_no: "75008"}),
(cust7:Customer {email: "emma.davis@example.com", first_name: "Emma", last_name: "Davis", country: "Italy", city: "Rome", street: "Via del Corso", house_no: "707", post_no: "00186"}),
(cust8:Customer {email: "frank.wilson@example.com", first_name: "Frank", last_name: "Wilson", country: "Spain", city: "Madrid", street: "Gran Via", house_no: "808", post_no: "28013"}),
(cust9:Customer {email: "grace.moore@example.com", first_name: "Grace", last_name: "Moore", country: "Netherlands", city: "Amsterdam", street: "Damrak", house_no: "909", post_no: "1012"}),
(cust10:Customer {email: "harry.anderson@example.com", first_name: "Harry", last_name: "Anderson", country: "Sweden", city: "Stockholm", street: "Drottninggatan", house_no: "1010", post_no: "111 60"}),

// Orders
(order1:Order {id: "ORD1", date: "2023-01-15"}), (cust1)-[:makes]->(order1),
(order2:Order {id: "ORD2", date: "2023-02-10"}), (cust2)-[:makes]->(order2),
(order3:Order {id: "ORD3", date: "2023-03-05"}), (cust3)-[:makes]->(order3),
(order4:Order {id: "ORD4", date: "2023-04-12"}), (cust3)-[:makes]->(order4),
(order5:Order {id: "ORD5", date: "2023-05-20"}), (cust5)-[:makes]->(order5),
(order6:Order {id: "ORD6", date: "2023-06-25"}), (cust6)-[:makes]->(order6),
(order7:Order {id: "ORD7", date: "2023-07-08"}), (cust5)-[:makes]->(order7),
(order8:Order {id: "ORD8", date: "2023-08-30"}), (cust8)-[:makes]->(order8),
(order9:Order {id: "ORD9", date: "2023-09-18"}), (cust9)-[:makes]->(order9),
(order10:Order {id: "ORD10", date: "2023-10-05"}), (cust10)-[:makes]->(order10),

// Order contents
(order1)-[:contains {quantity: 2, price: book1.price}]->(book1),
(order2)-[:contains {quantity: 1, price: book2.price}]->(book2),
(order3)-[:contains {quantity: 2, price: book3.price}]->(book3),
(order4)-[:contains {quantity: 4, price: book3.price}]->(book3),
(order5)-[:contains {quantity: 1, price: book5.price}]->(book5),
(order6)-[:contains {quantity: 4, price: book6.price}]->(book6),
(order7)-[:contains {quantity: 2, price: book6.price}]->(book6),
(order8)-[:contains {quantity: 3, price: book2.price}]->(book2),
(order9)-[:contains {quantity: 1, price: book9.price}]->(book9),
(order10)-[:contains {quantity: 1, price: book10.price}]->(book10);

// After all creates
MATCH (o:Order)-[r:contains]->(b:Book)
WITH o, SUM(r.quantity * r.price) AS total
SET o.total_price = total;
