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


dbGetQuery(con,
  "SELECT species,
          AVG(bill_length_mm) AS avg_bill_length,
          AVG(bill_depth_mm) AS avg_bill_depth
   FROM PARQUET_SCAN('https://francoismichonneau.net/assets/data/penguins.parquet')
   GROUP BY species;")


# it only works well for small datasets