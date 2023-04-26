# lec 2 - design

- for SQLite, `.schema tableName` will give you the schema for that specific table.

## Normalizing Data

- **Normalizing** means to reduce redundencies, having each entity being its own table, eg author names being their own table.
- Do this by giving each entity their own table, eg riders are their own. stations are their own.

## figuring out associations

- one rider could get ON at one station, and OFF at another.
- one station has many riders
  - you can argue this is a m2m.

<img src="rid1.png" />

## creating tables

- `sqlite mbta.db`
  - prompts you if you want to create a db called mbta.db
- make table for riders, and stations

```sql
CREATE TABLE "riders" (
  "id",
  "name"
);
```

```sql
CREATE TABLE "riders" (
  "id",
  "name",
  "line"
);
```

- typing `.schema` will now reveal the tables

## relating the tables via a junction/join table

- for the m2m relation between riders and stations:

```sql
CREATE TABLE "visits" (
  "rider_id",
  "station_id"
);
```

## data types VS storage classes

### SQLite storage classes:

- NULL
- INTEGER
- REAL
- TEXT
- BLOB (binary large object, usually images or videos)

Each Storage Class has various data types.
For example, integers have...

- 0-byte integer
- 1-byte integer
- 2-byte integer
- 3-byte integer
- 4-byte integer
- 6-byte integer
- 8-byte integer

SQLite will decide by itself which is appropriate to use.

What to do about the `line` field on station? -> TEXT
What about a map.jpg? -> BLOB

What about fares? Here, we have a choice.

- 10 as an integer? Hard to read
- $0.10 as text? But now we can't add/do math with a number...
- 0.10 as a REAL? But there will still be issues with how these numbers are stored with decimals.

## Type Affinities

- in SQLite: associated with individual columns
  - TEXT
  - NUMERIC
  - INTEGER
  - REAL
  - BLOB

if you have `25` and insert it into a column with a text affinity, it inserts it as `"25"`

- conversely, `"10"` inserted into a column with a INT affinity, inserts as `10`
