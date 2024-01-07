import os
import time
import duckdb
import pandas as pd
from dotenv import load_dotenv


load_dotenv()
google_storage_key = os.getenv("GOOGLE_STORAGE_KEY")
google_storage_secret = os.getenv("GOOGLE_STORAGE_SECRET")


def read_and_transform():
    db = duckdb.connect()
    # create table
    db.sql("""
           describe
           select * from read_json_auto('./data/goodreads_books.json.gz');
           """).show(max_rows=30)
    # db.sql("""
    #        select count(*) as total_rows
    #        from read_json_auto('./data/goodreads_books.json.gz');
    #        """).show()
    # 2360655 rows
    # @ai
    # there are around 2.3 million rows in the dataset
    
    # have a look at the following columns
    db.sql("""
           select isbn text_reviews_count, country_code, average_rating,
           language_code, url, book_id, title
           from read_json_auto('./data/goodreads_books.json.gz')
           using sample 5;
           """).show()
    



# @ai
# it seems that duckdb slows down when we use create table
# morever, it also takes a lot of memory when we use create table
# huge differences for
# db.sql("""
#         describe
#         select * from read_json_auto('./data/goodreads_books.json.gz');
#         """).show()
# db.sql("""
#         select count(*) from read_json_auto('./data/goodreads_books.json.gz');
#         """).show()
# and the following:
# db.sql("""
#         create table books as goodreads_books
#         select * from read_json_auto('./data/goodreads_books.json.gz');
#         """).show()
# db.sql("""
#         select count(*) from goodreads_books;
#         """).show()
# no idea why this happens



if __name__ == '__main__':
    read_and_transform()
# %%
