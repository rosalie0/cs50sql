[Hall of Prophecy](https://cs50.harvard.edu/x/2023/problems/7/prophecy/#hall-of-prophecy)
=========================================================================================

[Learning Goals](https://cs50.harvard.edu/x/2023/problems/7/prophecy/#learning-goals)
-------------------------------------------------------------------------------------

-   "Refactor" a `SQL` database to eliminate redundancies
-   Use `SELECT`, `CREATE`, and `INSERT` statements to reorganize data
-   Write Python to load new `SQL` tables

![Hall of Prophecy](https://cs50.harvard.edu/x/2023/problems/7/prophecy/prophecy.jpg)

[Background](https://cs50.harvard.edu/x/2023/problems/7/prophecy/#background)
-----------------------------------------------------------------------------

The keeper of the Hall of Prophecy, whose job entailed labelling records and keeping them up to date, decided to create a SQL database of Hogwarts students. Unfortunately the database was poorly designed! The database, `roster.db`, contains only one table, `students`, with the name and head of each of the four Hogwarts Houses.

Stumbling upon this database, you decide it could be better designed. Take a look at `roster.db` and notice how the name and head of each house repeats over and over. A better design would contain a students table (for *only* students), a houses table (for *only* houses), and a table that codifies the relationship between students and houses. This process of changing the "schema" of a database is known as [refactoring](https://en.wikipedia.org/wiki/Database_refactoring).

-   Hint

[Getting Started](https://cs50.harvard.edu/x/2023/problems/7/prophecy/#getting-started)
---------------------------------------------------------------------------------------

1.  Log into [code.cs50.io](https://code.cs50.io/) using your GitHub account.
2.  Click inside the terminal window and execute `cd`.
3.  Execute `wget https://cdn.cs50.net/2022/fall/labs/7/prophecy.zip` followed by Enter in order to download a zip called `prophecy.zip` in your codespace. Take care not to overlook the space between `wget` and the following URL, or any other character for that matter!
4.  Now execute `unzip prophecy.zip` to create a folder called `prophecy`.
5.  You no longer need the ZIP file, so you can execute `rm prophecy.zip` and respond with "y" followed by Enter at the prompt.

[Implementation Details](https://cs50.harvard.edu/x/2023/problems/7/prophecy/#implementation-details)
-----------------------------------------------------------------------------------------------------

You will use the existing data in `roster.db` to create a new database, one with a table for students, a table for houses, and a table for house assignments. You can do this with individual `SQL` queries, though we recommend ultimately writing your own Python program to automate the process! Notice we've given you the data from the `students` table of `roster.db` in CSV format, `students.csv`, for your convenience.

### [Developing a Schema](https://cs50.harvard.edu/x/2023/problems/7/prophecy/#developing-a-schema)

First, let's develop a new schema for the database. In `schema.sql`, document the three `CREATE TABLE` commands you'll need to create your three new tables.

Keep in mind you'll want each table to represent a single entity: that is, your students table should represent *only* students, your houses table should represent only *houses*, and your house assignments table should represent *only* house assignments. You might find it helpful to first consider the pieces of information you'll need in each table, and then about which SQLite data type best represents that information. For example, this was the `CREATE TABLE` command for `students`:

```
CREATE TABLE students (
    id INTEGER,
    student_name TEXT,
    house TEXT,
    head TEXT,
    PRIMARY KEY(id)
);

```

Keep in mind that every table should have a primary key: a column that uniquely identifies every row in the table. Some tables may be best designed with foreign keys: columns that reference the primary keys of another table.

When you're ready to configure your database with your new schema, run your three new `CREATE TABLE` queries. Type `.schema` to see your results.

### [Inserting Data](https://cs50.harvard.edu/x/2023/problems/7/prophecy/#inserting-data)

After you've configured your database with your new schema, you can begin inserting data into your new database (using your new schema!). It's best to write a Python program here, which can save you the trouble of writing many `INSERT` queries. Keep in mind that you have `students.csv`, which contains the data from the previous database's `students` table.

[Thought Question](https://cs50.harvard.edu/x/2023/problems/7/prophecy/#thought-question)
-----------------------------------------------------------------------------------------

-   Why do you think it's considered better design not to repeat information like houses and heads for each student?

[How to Test Your Code](https://cs50.harvard.edu/x/2023/problems/7/prophecy/#how-to-test-your-code)
---------------------------------------------------------------------------------------------------

You'll likely find the following commands helpful for testing your code:

-   `.schema` to check the schema of your database
-   `SELECT * FROM table;` where `table` is the name of the table you'd like to see data from

No `check50` for this one!

[How to Submit](https://cs50.harvard.edu/x/2023/problems/7/prophecy/#how-to-submit)
-----------------------------------------------------------------------------------

No need to submit. This is a practice problem!