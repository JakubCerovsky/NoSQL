// Query Data

// 1.	All books by an author
MATCH (:Author {first_name: "Alice", last_name: "Brown"})-[:writes]->(b:Book)
RETURN b.title, b.asin;

// 2.	Total price of an order
MATCH (o:Order {id: "ORD1"})
RETURN o.id, o.total_price;

// 3.	Total sales (in £) to a customer
MATCH (c:Customer {email: "john.doe@example.com"})-[:makes]->(o:Order)
RETURN c.email, SUM(o.total_price) AS total_spent;

// 4.	Books that are categorized as neither science fiction nor fantasy
MATCH (b:Book)
WHERE NOT (b)-[:belongs_to]->(:Category)-[:parents*0..]->(:Category {title: "Science Fiction"})
  AND NOT (b)-[:belongs_to]->(:Category)-[:parents*0..]->(:Category {title: "Fantasy"})
RETURN b.title, b.asin;

// 5.	Average page count by genre
MATCH (b:Book)-[:belongs_to]->(g:Genre)
RETURN g.name AS genre, AVG(b.page_count) AS avg_page_count, count(b) AS total_books;

// 6.	Categories that have no sub-categories
MATCH (c:Category)
WHERE NOT ()-[:parents]->(c)
RETURN c.title;

// 7.	ISBN numbers of books with more than one author
MATCH (b:Book)<-[:writes]-(a:Author)
WITH b, COUNT(a) AS author_count
WHERE author_count > 1
RETURN b.asin;

// 8.	ISBN numbers of books that sold at least 3 copies
MATCH (:Order)-[r:contains]->(b:Book)
WITH b, SUM(r.quantity) AS total_sold
WHERE total_sold >= 3
RETURN b.asin, total_sold;

// 9.	Number of copies of each book sold – unsold books should show as 0 sold copies.
MATCH (b:Book)
OPTIONAL MATCH (:Order)-[r:contains]->(b)
RETURN b.asin, b.title, COALESCE(SUM(r.quantity), 0) AS total_sold;

// 10.	Best-selling books: The top 10 selling books ordered in descending order by number of sales.
MATCH (:Order)-[r:contains]->(b:Book)
WITH b, SUM(r.quantity) AS total_sold
RETURN b.title, b.asin, total_sold
ORDER BY total_sold DESC
LIMIT 10;

// 11.	Best-selling genres: The top 3 selling genres ordered in descending order by number of sales.
MATCH (o:Order)-[r:contains]->(b:Book)-[:belongs_to]->(g:Genre)
WITH g.name AS genre, SUM(r.quantity) AS total_sold
RETURN genre, total_sold
ORDER BY total_sold DESC
LIMIT 3;

// 12.	All science fiction books. Note: Books in science fiction subcategories like cyberpunk also count as science fiction. 
MATCH (b:Book)-[:belongs_to]->(:Category)-[:parents*0..]->(:Category {title: "Science Fiction"})
RETURN DISTINCT b.asin, b.title;

// 13.	Characters used in science fiction books. Note from (12) applies here as well.
MATCH (b:Book)-[:belongs_to]->(:Category)-[:parents*0..]->(:Category {title: "Science Fiction"}),
      (b)-[:contains]->(c:Character)
RETURN DISTINCT c.name;

// 14.	Number of books in each category including books in subcategories.
MATCH (c:Category)
OPTIONAL MATCH (b:Book)-[:belongs_to]->(:Category)-[:parents*0..]->(c)
RETURN c.title, COUNT(DISTINCT b) AS total_books;