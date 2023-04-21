# CS50SQL - Lecture 0 - Querying

## why use dbs over spread sheets to store data?
1. Scale
	- billions of users...
2. Frequency
	- in cases where it needs to be updated very frequently, like tweets being made
3. speed
	- querying

## what is a database?
"A collection of data organized for CRUD.

### database management
Q: what is a database management system?
A: Software via which you can interact with a db.

software examples:
- MySQL
- Oracle
- PostgreSQL
- SQLite
- etc...

some systems are...
- paid / free
- heavier / lighter weight

### SQL: Structured Query Language 
- SQL is a **language** via which you can create, read, update, and delete data in a db.

#### What can I do with SQL?
You can answer questions like:
- whats the most liked post on our platform?
- which songs are most like the song a user just listened to?
- is our number of daily users growing or shrinking?

## Database Example - The Booker Prize DB

- every year commitee lists 13 best books.

### tools we need to get started:
- vs code
- sqlite (often used on phones)

## getting started with sqlite
in terminal: `sqlite3 filename`

eg) `sqlite3 longlist.db`

`CMD+L` to clear some terminal space.

## sql keywords

### SELECT
first keyword to know is: `SELECT` which lets you get back some rows.

```sql
SELECT * from "longlist";
SELECT  "title" FROM "longlist";
SELECT "title", "author", FROM "longlist";
```
* note: good practice to use double quotes around column names, tables, and other sql "identifiers". 
* note: MUST use double quotes, not single quotes! Strings use single quotes. so in sql, " vs ' are VERY different / not interchangable.

### LIMIT

- if you dont want to see everything / just take a peek. 

```sql
SELECT "title" FROM "longlist" LIMIT 10;
```
- this is just top 10 in whatever order they were added.

### WHERE

- get back not all rows, but only some *where* some condition is true.
```sql
SELECT "title", "author"
FROM "longlist"
WHERE "year" = 2023;
```
- note: 2023 is NOT in quotes because its an actual number, not a string.
#### operators
- `=` equals
- `!=` not equals
- `<>` also not equals

```sql
SELECT "title", "format"
FROM "longlist"
WHERE
	"format" != 'hardcover';
```
notice the usage of single quotes around hardcover because it is just a string, it is not a column name or table name.

### NOT
- can also negate. negates a condition.
- this does the same as the above query.

```sql
SELECT "title", "format"
FROM "longlist"
WHERE NOT
	"format" = 'hardcover';
```

### combining conditionals.
#### chaining/compounding
- `AND`
- `OR`
- `()` lets whatever is inside get executed first.

Q: I want to find books from 2022 and 2023.
A:
```sql
SELECT "title", "author" FROM "longlist"
WHERE 
	"year" = 2022 OR "year" = 2023;
```

Q: I want to find hardcover books from 2022 and 2023
A:
```sql
SELECT "title", "author" FROM "longlist"
WHERE 
	("year" = 2022 OR "year" = 2023)
	AND
	"format" != 'hardcover';
```
- notice the parans around the years. this is essential in order for the OR and AND to execute in the correct order.

### NULL , finding where data is missing

- `IS NULL` for wanting where a row is empty
- `IS NOT NULL` for not empty

Q: books that dont have a translator.
A:
```sql
SELECT "title", "translator" FROM "longlist"
WHERE "translator" IS NULL
```

### LIKE
- extra powerful when combined with:
	- `%` can match any character around a string
	- `_` underscore is a SINGLE character wildcard.

Q: I want books where Love is in the title.
A:
```sql
SELECT "title" FROM "longlist"
WHERE "title" LIKE '%love%';
```

This renders: 

```
Love in the Big City
More Than I Love My Life
Love in the New Millennium
Die, My Love
```
- anything can come BEFORE and anything can come AFTER.
- not case sensitive!

Q: I want books that START with the word The.
A:
```sql
SELECT "title" FROM "longlist"
WHERE "title" LIKE 'The%';
```
- this will, however, also return book titles that start with "They" or "There" ...
	- How to fix this? Make is `WHERE "title" LIKE 'The %';`. Notice the space before the `%`.

##### example for `_`
Q: I can't remember if its Pire or Pyre but i want to find that book.
A:
```sql
SELECT "title" FROM "longlist"
WHERE "title" LIKE 'P_re';
```

- can use multiple underscores.
- books with a title that has 3 chars only after T for its entire title.
```sql
SELECT "title" FROM "longlist"
WHERE "title" LIKE 'T___';
```

### range

two solutions:

#### combine these operators..

- `<`
- `<=` 
- `>` 
- `>=`

Q: i want books from 2020 - 2023
A:
```sql
SELECT "title", "year"
FROM "longlist"
WHERE
	"year" >= 2020
	AND
	"year" <= 2023
```

#### BETWEEN ... AND ...
- inclusive
```sql
SELECT "title", "year"
FROM "longlist"
WHERE
	"year" BETWEEN 2020 AND 2023
```


Q: Show me books where rating is more than 4.0
A:
```sql
SELECT "title", "rating"
FROM "longlist"
WHERE
	"rating" >= 4.0
```

- but maybe some of these didnt get a lot of votes, so it's skewed.

```sql
SELECT "title", "rating", "votes"
FROM "longlist"
WHERE
	"rating" >= 4.0
	AND "votes" > 10000;
```

Q: Get books that are less than 300 pages.
A:
```sql
SELECT "title", "pages"
FROM "longlist"
WHERE
	"pages" < 300;
```

### LIKE vs `=` for strings
- LIKE ignores casing. `=` does not.
	- `WHERE "title" LIKE 'pyre'` will get back the book Pyre.
	- `WHERE "title" = 'pyre'` returns nothing.

### ORDER BY

- arranges rows in our query

Q: find top ten books

Let's try:
```sql
SELECT "title", "rating" FROM "longlist"
ORDER BY "rating" LIMIT 10;
```

actually returns:

```
The Gospel According to the New World|3.05
The Pine Islands|3.16
Love in the New Millennium|3.17
After the Sun|3.25
I Live in the Slums|3.29
The War of the Poor|3.36
An Inventory of Losses|3.36
The Death of Murat Idrissi|3.36
The Dinner Guest|3.41
Red Dog|3.42
```
... which is the opposite of what we want. the default ordering is min->max.

#### Instead we need to do:
`ORDER BY ... ASC` (gets larger as it goes)
`ORDER BY ... DESC` (gets smaller as it goes.)

Q: find top ten books
A: 
```sql
SELECT "title", "rating" FROM "longlist"
	ORDER BY "rating" DESC
	LIMIT 10;
```
RESULT:
```
The Eighth Life|4.52
A New Name: Septology VI-VII|4.5
The Other Name: Septology I-II|4.19
The Years|4.18
Still Born|4.14
When We Cease to Understand the World|4.14
Elena Knows|4.1
The Flying Mountain|4.1
Hurricane Season|4.08
The Books of Jacob|4.06
```

- Follow up question: Ok, what if two books have the same rating, like the 4.1 and I want to order those by say, alphabetically in name?
- AKA first order by rating, then order by votes within the rating.
- A:
```sql
SELECT "title", "rating", "votes"
FROM "longlist"
	ORDER BY "rating" DESC,  
	"votes" DESC
	LIMIT 10;
``` 

- when ordering by strings:
	- 	by default / `ASC` is A-Z. 
	-  `DESC` is Z-A.

### doing math

- find average rating? find how many books in db?

#### Use sql Aggregate functions:

- `COUNT`
- `AVG`
- `MIN`
- `MAX`
- `SUM`

Q: What is the average rating for the books?
A:
```sql
SELECT AVG("rating")
FROM "longlist";
```

Q: ...Rounded to the nearest 2nd decimal?
```sql
SELECT ROUND( AVG("rating"), 2)
FROM "longlist";
```

Q: ...Where the name looks pretty/useful?
A: use the `AS` keyword
```sql
SELECT ROUND( AVG("rating"), 2)
	AS "average rating"
	FROM "longlist";
```

Q: What is the highest rated books?
A:
```sql
SELECT MAX("rating") FROM "longlist";
```

Q: What is the lowest rated books?
A:
```sql
SELECT MIN("rating") FROM "longlist";
```

Q: How many votes were placed? What is the sum of the votes column?
A:
```sql
SELECT SUM("votes") FROM "longlist";
```

Q: How many rows do we have in this db?
A: 
```sql
SELECT COUNT(*) FROM "longlist";
```

#### DISTINCT

Q: Show me book publishers
A: You will get repeats if you just do:

```sql
SELECT "publisher" FROM "longlist";
```

Need to use `DISTINCT`.

```sql
SELECT DISTINCT "publisher"
FROM "longlist";
ASC;
```

Q: how many publishers do we have?
A: need to use distinct again!
```sql
SELECT COUNT(DISTINCT "publisher")
FROM "longlist";
```