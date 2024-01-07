# install.packages(c("duckdb", "DBI"))
# or 
# install.packages(c('duckdb', "DBI"), dependencies = TRUE, INSTALL_opts = '--no-lock')
library(pacman)
p_load(stringr, data.table, magrittr, ggplot2,
        knitr, stringdist, r2d3, RColorBrewer,
        patchwork, DBI, duckdb)

# use data.table to read in the data
# dataset if 5GB
# around 10 seconds with 32GB RAM
foo <- fread("./data/goodreads_interactions.csv")
str(foo)

con <- dbConnect(duckdb(), dbdir = ":memory:")

# install httpfs for duckdb
dbExecute(con, "INSTALL httpfs;")
dbExecute(con, "LOAD httpfs;")

# install json 
dbExecute(con, "INSTALL json;")
dbExecute(con, "LOAD json;")


dbGetQuery(con,
  "SELECT species,
          AVG(bill_length_mm) AS avg_bill_length,
          AVG(bill_depth_mm) AS avg_bill_depth
   FROM PARQUET_SCAN('https://francoismichonneau.net/assets/data/penguins.parquet')
   GROUP BY species;")


# it only works well for small datasets
dbGetQuery(con,
  "describe
  select * from read_json_auto('./data/goodreads_books.json.gz')") %>%
  kable()


dbGetQuery(con,
  "select isbn text_reviews_count, country_code, average_rating,
  language_code, url, book_id, title
  from read_json_auto('./data/goodreads_books.json.gz')
  using sample 5;") %>%
  kable()