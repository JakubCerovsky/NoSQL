/* global use, db */
// MongoDB Playground
// Use Ctrl+Space inside a snippet or a string literal to trigger completions.

const database = 'amazon_bookstore_mongov2';

// The current database to use.
use(database);

// Books Collection

db.createCollection("books", {
    validator: {
       $jsonSchema: {
          bsonType: "object",
          required: ["asin", "title", "authors", "categories", "genres", "characters"],
          properties: {
             asin: { bsonType: "string", description: "The unique identifier for the book (ASIN)" },
             title: { bsonType: "string", description: "The title of the book" },
             description: { bsonType: "string", description: "Description of the book" },
             language: { bsonType: "string", description: "The language the book is written in" },
             publish_date: { bsonType: "date", description: "The date the book was published" },
             publisher: { bsonType: "string", description: "The publisher of the book" },
             page_count: { bsonType: "int", description: "The number of pages in the book" },
             no_of_copies: { bsonType: "int", description: "The number of copies available" },
             sold_copies: { bsonType: "int", description: "The number of sold copies in total"},
             price: { bsonType: "decimal", description: "The price of the book" },
             authors: {
                bsonType: "array",
                minItems: 1,
                items: {
                   bsonType: "object",
                   required: ["first_name", "last_name"],
                   properties: {
                      first_name: { bsonType: "string", description: "The author's first name" },
                      last_name: { bsonType: "string", description: "The author's last name" },
                      biography: { bsonType: "string", description: "A short biography of the author" }
                   }
                }
             },
             categories: {
                bsonType: "array",
                minItems: 1,
                items: {
                   bsonType: "object",
                   required: ["category_id", "title"],
                   properties: {
                      category_id: { bsonType: "objectId", description: "Reference to the category document" },
                      title: { bsonType: "string", description: "The title of the category" }
                   }
                }
             },
             genres: { bsonType: "array", items: { bsonType: "string", description: "Genres related to the book" } },
             characters: { bsonType: "array", items: { bsonType: "string", description: "List of character names appearing in the book" } }
          }
       }
    }
});

// Customers Collection

db.createCollection("customers", {
    validator: {
       $jsonSchema: {
          bsonType: "object",
          required: ["email", "first_name", "last_name", "address"],
          properties: {
             email: { bsonType: "string", description: "Email address of the customer" },
             first_name: { bsonType: "string", description: "First name of the customer" },
             last_name: { bsonType: "string", description: "Last name of the customer" },
             address: {
                bsonType: "object",
                required: ["country", "city", "street", "house_no", "post_no"],
                properties: {
                   country: { bsonType: "string", description: "Country of the customer" },
                   city: { bsonType: "string", description: "City of the customer" },
                   street: { bsonType: "string", description: "Street of the customer" },
                   house_no: { bsonType: "string", description: "House number of the customer" },
                   post_no: { bsonType: "string", description: "Postal code of the customer" }
                }
             },
             orders: {
                bsonType: "array",
                items: {
                   bsonType: "object",
                   required: ["order_id", "total_price"],
                   properties: {
                      order_id: { bsonType: "objectId", description: "Reference to the order document" },
                      total_price: { bsonType: "decimal", description: "Total price of the order" }
                   }
                }
             }
          }
       }
    }
});

// Orders Collection

db.createCollection("orders", {
   validator: {
      $jsonSchema: {
         bsonType: "object",
         required: ["customer_id", "date", "total_price", "order_details"],
         properties: {
            customer_id: { bsonType: "objectId", description: "Reference to the customer document" },
            date: { bsonType: "date", description: "The date when the order was placed" },
            total_price: { bsonType: "decimal", description: "Total price of the order" },
            order_details: {
               bsonType: "array",
               minItems: 1,
               items: {
                  bsonType: "object",
                  required: ["book_id", "quantity", "price"],
                  properties: {
                     book_id: { bsonType: "objectId", description: "Reference to the book document" },
                     quantity: { bsonType: "int", description: "Number of copies of the book ordered" },
                     price: { bsonType: "decimal", description: "Price of a single book" }
                  }
               }
            }
         }
      }
   }
});

// Categories Collection

db.createCollection("categories", {
   validator: {
      $jsonSchema: {
         bsonType: "object",
         required: ["title", "parent_id"],
         properties: {
            title: { bsonType: "string", description: "Title of the category" },
            description: { bsonType: "string", description: "Description of the category" },
            parent_id: { bsonType: "objectId", description: "Reference to the parent category" },
            sub_categories: {
               bsonType: "array",
               items: {
                  bsonType: "object",
                  required: ["parent_id", "title"],
                  properties: {
                     parent_id: { bsonType: "objectId", description: "Reference to the parent category" },
                     title: { bsonType: "string", description: "Title of the subcategory" }
                  }
               }
            }
         }
      }
   }
});
