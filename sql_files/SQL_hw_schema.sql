-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/NCmdom
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

-- Modify this code to update the DB schema diagram.
-- To reset the sample schema, replace everything with
-- two dots ('..' - without quotes).

CREATE TABLE "card_holder" (
    "id" SMALLINT   NOT NULL,
    "name" VARCHAR(255)   NOT NULL,
    CONSTRAINT "pk_card_holder" PRIMARY KEY (
        "id"
     )
);

CREATE TABLE "credit_card" (
    "card" NUMERIC   NOT NULL,
    "card_holder" SMALLINT   NOT NULL
);

CREATE TABLE "merchant_catagory" (
    "id" SMALLINT   NOT NULL,
    "name" VARCHAR(255)   NOT NULL,
    CONSTRAINT "pk_merchant_catagory" PRIMARY KEY (
        "id"
     )
);

-- Table documentation comment 1 (try the PDF/RTF export)
-- Table documentation comment 2
CREATE TABLE "merchant" (
    "id" SMALLINT   NOT NULL,
    "name" VARCHAR(255)   NOT NULL,
    "id_merchant_catagory" SMALLINT   NOT NULL,
    CONSTRAINT "pk_merchant" PRIMARY KEY (
        "id"
     )
);

CREATE TABLE "transactions" (
    "id" SMALLINT   NOT NULL,
    "date" TIMESTAMP   NOT NULL,
    "amount" NUMERIC   NOT NULL,
    "card" VARCHAR(255)   NOT NULL,
    "merchant_id" SMALLINT   NOT NULL,
    CONSTRAINT "pk_transactions" PRIMARY KEY (
        "id"
     )
);

ALTER TABLE "credit_card" ADD CONSTRAINT "fk_credit_card_card_holder" FOREIGN KEY("card_holder")
REFERENCES "card_holder" ("id");

ALTER TABLE "merchant" ADD CONSTRAINT "fk_merchant_id_merchant_catagory" FOREIGN KEY("id_merchant_catagory")
REFERENCES "merchant_catagory" ("id");

ALTER TABLE "transactions" ADD CONSTRAINT "fk_transactions_merchant_id" FOREIGN KEY("merchant_id")
REFERENCES "merchant" ("id");

