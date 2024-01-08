library(pacman)
p_load(stringr, data.table, magrittr, ggplot2,
        knitr, stringdist, r2d3, RColorBrewer,
        patchwork, DBI, duckdb, rjson)

gray_scale <- c('#F3F4F8','#D2D4DA', '#B3B5BD', 
                '#9496A1', '#7d7f89', '#777986', 
                '#656673', '#5B5D6B', '#4d505e',
                '#404352', '#2b2d3b', '#282A3A',
                '#1b1c2a', '#191a2b',
                '#141626', '#101223')

ft_palette <- c('#990F3D', '#0D7680', '#0F5499', '#262A33', '#FFF1E5')

ft_contrast <- c('#F83', '#00A0DD', '#C00', '#006F9B', '#F2DFCE', '#FF7FAA',
                 '#00994D', '#593380')

peep_head <- function(dt, n = 5) {
    dt %>%
        head(n) %>%
        kable()
}

peep_sample <- function(dt, n = 5) {
    dt %>%
        .[sample(.N, n)] %>%
        kable()
}

peep_tail <- function(dt, n = 5) {
    dt %>%
        tail(n) %>%
        kable()
}


# Introduction -----------------------------------------------------------------

# @ai
# date: 2024-01-08
# since sometimes we need to visualize the data, it is better to
# use duckdb in R environment instead of python

# connect to the database
con <- dbConnect(duckdb(), dbdir = "goodreads.db")

# install json 
dbExecute(con, "INSTALL json;")
dbExecute(con, "LOAD json;")


dbGetQuery(con, "SHOW TABLES;")

# @ai
# there are three tables: authors, books3, reviews


# describe all tables
dbGetQuery(con, "SHOW TABLES;") %>%
    .$name %>%
    lapply(
        function(x) dbGetQuery(con, paste0("DESCRIBE ", x))
        ) %>%
    kable()

# only use repr.plot.res=300/400 for high resolution
# options(repr.plot.width = 7, repr.plot.height = 4, repr.plot.res=300)
options(repr.plot.width = 7, repr.plot.height = 4)
dbGetQuery(con,
    "SELECT book_id, COUNT(*) AS count
    FROM reviews
    GROUP BY book_id
    ORDER BY count DESC") %>% 
    # plot the distribution of the number of reviews per book
    # with boxplot
    with(plot(count, ylab="Number of reviews per book",
              xlab="Index Number of the book",
              main="Distribution of the number of reviews per book",
              log='x'))

# @ai
# the distribution of the number of reviews per book is highly skewed
# it follows a power law distribution (Zipf's law)
# we have only 100 books have more than 5000 reviews


# have a look at the publication year of the books3 table
dbGetQuery(con,
    "SELECT publication_year
    FROM books3
    WHERE publication_year IS NOT NULL
    USING SAMPLE 10") %>% peep_head()


# check the distribution of the publication year
dbGetQuery(con,
    "SELECT publication_year, COUNT(*) AS count
    FROM books3
    WHERE publication_year IS NOT NULL AND publication_year != ''
    GROUP BY publication_year
    ORDER BY count DESC") %>%
    as.data.table() %>%
    # convert the publication_year to numeric
    .[, .(year = as.numeric(publication_year), count)] %>%
    # only take the books published after 1990 and before 2023
    .[year > 1990 & year < 2023] %>%
    # order by year
    .[order(year)] %>% 
    # plot it with connected dot
    with(plot(year, count, type='b', xlab='Publication year',
              ylab='Number of books',
              main='Trend of the number of books published per year'))


# @ai
# it seems that the number of books published per year is increasing
# and reached to the peak around 2014
# but this does not mean publishing industry is diminishing after 2014
# it is the data collection bias


# construct a table with: book_id, title, description, review_id, review_text
dbExecute(con,
    "CREATE VIEW books_reviews AS
    SELECT b.book_id, b.title, b.description, r.review_id, r.review_text
    FROM books3 AS b
    LEFT JOIN reviews AS r
    ON b.book_id = r.book_id")

# drop the view after use
dbExecute(con, "DROP VIEW books_reviews")

dbGetQuery(con, "SHOW TABLES;")
dbGetQuery(con, "DESCRIBE books_reviews;")

# have a look at the books_reviews table
dbGetQuery(con,
    "SELECT * FROM books_reviews
    USING SAMPLE 5;") %>%
    peep_head()



# @ai
# USING SAMPLE 5 takes longer time than LIMIT 5
# it also takes more memory as it has to load all the data into memory
# and then sample from it

dbGetQuery(con,
    "SELECT * FROM books_reviews
    LIMIT 5;") %>% peep_head()


# check num of rows in books_reviews
dbGetQuery(con,
    "SELECT COUNT(*) FROM books_reviews;")


# @ai
# we have 14819129 rows in books_reviews table, roughly 15 million rows


# now, we need to drop rows where
# (title is not null or empty) and (description is null or empty)
# and (review_text is null or empty)
dbExecute(con,
    "CREATE VIEW books_reviews AS
    SELECT *
    FROM books_reviews
    WHERE (title IS NOT NULL AND title != '')
    AND (description IS NOT NULL AND description != '')
    AND (review_text IS NOT NULL AND review_text != '')")


# check num of rows in books_reviews2
dbGetQuery(con,
    "SELECT COUNT(*) FROM books_reviews2;")


# @ai
# we got 14347521, roughly 14 million rows


# now drop the view - books_reviews
dbExecute(con, "DROP VIEW books_reviews")
# drop books_reviews2 view after use
dbExecute(con, "DROP VIEW books_reviews2")

# list all tables now
dbGetQuery(con, "SHOW TABLES;")


# release some memory by calling gc()
gc()  # it does not work very well for duckdb



# create view again with where condition
dbExecute(con,
    "CREATE VIEW books_reviews AS
    SELECT b.book_id, b.title, b.description, r.review_id, r.review_text
    FROM books3 AS b
    LEFT JOIN reviews AS r
    ON b.book_id = r.book_id
    WHERE (b.title IS NOT NULL AND b.title != '')
    AND (b.description IS NOT NULL AND b.description != '')
    AND (r.review_text IS NOT NULL AND r.review_text != '')")



# describe books_reviews
dbGetQuery(con, "DESCRIBE books_reviews;") %>%
    kable()


# check num of rows in books_reviews
dbGetQuery(con,
    "SELECT COUNT(*) FROM books_reviews;")


# take limit 5 rows and have a look at it
dbGetQuery(con,
    "SELECT * FROM books_reviews
    LIMIT 1;") %>%
    # turn it into json
    toJSON()


# get book_reviews where book_id is in some list
dbGetQuery(con,
    "SELECT *
    FROM books_reviews
    WHERE book_id IN (
        SELECT book_id
        FROM (
            SELECT book_id, COUNT(*) AS count
            FROM books_reviews
            GROUP BY book_id
            HAVING count > 1000
            ORDER BY count ASC
            LIMIT 5
            )
        );") %>%
    dim()  # 5018 rows, 5 columns



dbGetQuery(con,
    "SELECT *
    FROM books_reviews
    WHERE book_id IN (
        SELECT book_id
        FROM (
            SELECT book_id, COUNT(*) AS count
            FROM books_reviews
            GROUP BY book_id
            HAVING count > 1000
            ORDER BY count DESC
            LIMIT 5));") %>% dim()  # 128,632 rows, 5 columns



# let's see where combine sql and r together
# set the seed
dbGetQuery(con,
    "SELECT book_id, COUNT(*) AS count
    FROM books_reviews
    GROUP BY book_id
    HAVING count > 1000
    ORDER BY count DESC") %>%
    as.data.table() %>%
    # sample 5 rows
    .[sample(.N, 5)] %>%
    # map the book_id to dbGetQuery
    .[, dbGetQuery(con, "SELECT *
                        FROM books_reviews
                        WHERE book_id IN (?, ?, ?, ?, ?)",
                        book_id)] %>%
    # it return as data.frame, so we need to convert it to data.table
    as.data.table() %>% dim()  # 8042 rows, 5 columns


# if you do not want to type all the time
# you can paste the book_id together
dbGetQuery(con,
    "SELECT book_id, COUNT(*) AS count
    FROM books_reviews
    GROUP BY book_id
    HAVING count > 1000
    ORDER BY count DESC") %>%
    as.data.table() %>%
    .[sample(.N, 5)] %>%
    .[, dbGetQuery(con, paste0(
                                "SELECT *
                                FROM books_reviews
                                WHERE book_id IN (",
                                paste0("$", seq_len(.N), collapse = ", "),
                                ")"
                                ), book_id)] %>%
    as.data.table() %>%
    .[, .(book_id, title, review_id)] %>%
    peep_head()


