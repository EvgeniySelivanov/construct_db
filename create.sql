DROP TABLE IF EXISTS "delivery_to_orders";
DROP TABLE IF EXISTS "delivery";
DROP TABLE IF EXISTS "orders";
DROP TABLE IF EXISTS "product";
DROP TABLE IF EXISTS "contracts";
DROP TABLE IF EXISTS "customers";


CREATE TABLE "customers"(
  "id" serial PRIMARY KEY,
  "firstName" VARCHAR(64) NOT NULL CHECK ("firstName" != ''),
  "lastName" VARCHAR(64) NOT NULL CHECK ("lastName" != ''),
  "address" jsonb  NOT NULL,
  "createdAt" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "products"(
  "id" serial PRIMARY KEY,
  "name" VARCHAR(64) NOT NULL CHECK ("name" != ''),
  "price" DECIMAL(10,2) NOT NULL CHECK ("price">0 ),
  "quantity" INT NOT NULL CHECK ("quantity" >=0 ) DEFAULT 0,
  "createdAt" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "contracts"(
  "id" serial PRIMARY KEY,
  "customerId" INT REFERENCES "customers"("id"),
  "createdAt" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
)

CREATE TABLE "orders"(
  "id" serial PRIMARY KEY,
  "contractId" INT REFERENCES "contracts"("id"),
  "productId" INT REFERENCES "products"("id"),
  "createdAt" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "quantity" INT NOT NULL CHECK ("quantity" >0 ) DEFAULT 1 
);

CREATE TABLE "delivery"(
  "id" serial PRIMARY KEY,
  "customerId" INT REFERENCES "customers"("id"),
  "createdAt" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "delivery_to_orders"(
  "orderId" INT REFERENCES "orders"("id"),
  "deliveryId" INT REFERENCES "delivery"("id"),
   "quantity" INT NOT NULL CHECK ("quantity" >0 ) DEFAULT 1,
  "createdAt" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 PRIMARY KEY("orderId","deliveryId")
);

