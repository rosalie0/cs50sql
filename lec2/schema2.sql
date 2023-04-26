-- Schema for cards, stations, and their m2m relationship "swipes".

CREATE TABLE "cards" (
  "id" INTEGER,
  PRIMARY KEY("id") -- make sure the id column has the PRIMARY KEY constraint.
);

CREATE TABLE "stations" (
  "id" INTEGER,
  "name" TEXT NOT NULL UNIQUE, --Park Street
  "line" TEXT NOT NULL, --Red line
  PRIMARY KEY("id")
);

CREATE TABLE "swipes" (
  "id" INTEGER,
  "card_id" INTEGER,
  "station_id" INTEGER,
  "type" TEXT NOT NULL CHECK("type" IN ('enter', 'exit', 'deposit')),
  "datetime" NUMERIC NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "amount" NUMERIC NOT NULL CHECK("amount" != 0),
  PRIMARY KEY("id"),
  FOREIGN KEY("card_id") REFERENCES "cards"("id"),
  FOREIGN KEY("station_id") REFERENCES "stations"("id")
);

-- .read schema.sql