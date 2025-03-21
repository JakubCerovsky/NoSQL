/* global use, db */
// MongoDB Playground
// Use Ctrl+Space inside a snippet or a string literal to trigger completions.

const database = "amazon_bookstore_mongov2";

// The current database to use.
use(database);

db.createCollection("books", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: [
        "asin",
        "title",
        "authors",
        "categories",
        "genres",
        "characters",
      ],
      properties: {
        asin: {
          bsonType: "string",
          description: "The unique identifier for the book (ASIN)",
        },
        title: {
          bsonType: "string",
          description: "The title of the book",
        },
        description: {
          bsonType: "string",
          description: "Description of the book",
        },
        language: {
          bsonType: "string",
          description: "The language the book is written in",
        },
        publish_date: {
          bsonType: "date",
          description: "The date the book was published",
        },
        publisher: {
          bsonType: "string",
          description: "The publisher of the book",
        },
        page_count: {
          bsonType: "int",
          description: "The number of pages in the book",
        },
        no_of_copies: {
          bsonType: "int",
          description: "The number of copies available",
        },
        price: {
          bsonType: "decimal",
          description: "The price of the book",
        },
        authors: {
          bsonType: "array",
          minItems: 1,
          items: {
            bsonType: "object",
            required: ["first_name", "last_name"],
            properties: {
              first_name: {
                bsonType: "string",
                description: "The author's first name",
              },
              last_name: {
                bsonType: "string",
                description: "The author's last name",
              },
              biography: {
                bsonType: "string",
                description: "A short biography of the author",
              },
            },
          },
        },
        categories: {
          bsonType: "array",
          minItems: 1,
          items: {
            bsonType: "object",
            required: ["category_id", "title"],
            properties: {
              category_id: {
                bsonType: "objectId",
                description: "Reference to the category document",
              },
              title: {
                bsonType: "string",
                description: "The title of the category",
              },
            },
          },
        },
        genres: {
          bsonType: "array",
          items: {
            bsonType: "string",
            description: "Genres related to the book",
          },
        },
        characters: {
          bsonType: "array",
          items: {
            bsonType: "string",
            description: "List of character names appearing in the book",
          },
        },
      },
    },
  },
});
db.createCollection("customers", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["customer_id", "name", "email", "address", "orders"],
      properties: {
        customer_id: {
          bsonType: "objectId",
          description: "Unique identifier for the customer",
        },
        name: {
          bsonType: "string",
          description: "Full name of the customer",
        },
        email: {
          bsonType: "string",
          description: "Email address of the customer",
        },
        address: {
          bsonType: "object",
          required: ["street", "city", "zip"],
          properties: {
            street: {
              bsonType: "string",
              description: "Street address",
            },
            city: {
              bsonType: "string",
              description: "City of the customer",
            },
            zip: {
              bsonType: "int",
              description: "Postal code of the customer",
            },
          },
        },
        orders: {
          bsonType: "array",
          items: {
            bsonType: "objectId",
            description: "Reference to order documents",
          },
        },
      },
    },
  },
});
db.createCollection("orders", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: [
        "order_id",
        "customer_id",
        "order_date",
        "total_amount",
        "order_details",
      ],
      properties: {
        order_id: {
          bsonType: "objectId",
          description: "Unique identifier for the order",
        },
        customer_id: {
          bsonType: "objectId",
          description: "Reference to the customer who placed the order",
        },
        order_date: {
          bsonType: "date",
          description: "Date when the order was placed",
        },
        total_amount: {
          bsonType: "decimal",
          description: "Total cost of the order",
        },
        order_details: {
          bsonType: "array",
          items: {
            bsonType: "object",
            required: ["book_id", "quantity", "price"],
            properties: {
              book_id: {
                bsonType: "objectId",
                description: "Reference to the book being ordered",
              },
              quantity: {
                bsonType: "int",
                description: "Number of copies of the book",
              },
              price: {
                bsonType: "decimal",
                description: "Price of the book",
              },
            },
          },
        },
      },
    },
  },
});
db.createCollection("categories", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["category_id", "title"],
      properties: {
        category_id: {
          bsonType: "objectId",
          description: "Unique identifier for the category",
        },
        title: {
          bsonType: "string",
          description: "Name of the category",
        },
      },
    },
  },
});
