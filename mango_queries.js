// OP1: insertMany() — insert all 3 documents from sample_documents.json
db.products.insertMany([
  {
    "product_id": "ELEC001",
    "name": "Smartphone X",
    "category": "Electronics",
    "price": 48703.39,
    "specs": {
      "warranty_years": 2,
      "voltage": "220V",
      "battery": "4000mAh",
      "screen_size": "6.5 inch"
    },
    "features": ["Dual SIM", "5G", "128GB Storage"]
  },
  {
    "product_id": "CLOTH001",
    "name": "Denim Jacket",
    "category": "Clothing",
    "price": 30187.24,
    "sizes": ["S", "M", "L", "XL"],
    "materials": {
      "fabric": "Denim",
      "lining": "Polyester"
    },
    "care_instructions": ["Machine wash cold", "Do not bleach", "Iron at low heat"]
  },
  {
    "product_id": "GROC001",
    "name": "Milk 1L",
    "category": "Groceries",
    "price": 43374.39,
    "expiry_date": "2024-12-31",
    "nutrition": {
      "calories": 150,
      "protein_g": 8,
      "fat_g": 5,
      "carbohydrates_g": 12
    },
    "ingredients": ["Milk", "Vitamin D"],
    "storage": {
      "temperature": "2-4°C",
      "instructions": "Keep refrigerated"
    }
  }
]);

// OP2: find() — retrieve all Electronics products with price > 20000
db.products.find({ category: "Electronics", price: { $gt: 20000 } });

// OP3: find() — retrieve all Groceries expiring before 2025-01-01
db.products.find({ category: "Groceries", expiry_date: { $lt: "2025-01-01" } });

// OP4: updateOne() — add a "discount_percent" field to a specific product
db.products.updateOne(
  { product_id: "ELEC001" },
  { $set: { discount_percent: 10 } }
);

// OP5: createIndex() — create an index on category field and explain why
db.products.createIndex({ category: 1 });
/*
Reason: Queries often filter by category (e.g., Electronics vs Clothing).
Indexing improves performance by avoiding full collection scans.
*/
