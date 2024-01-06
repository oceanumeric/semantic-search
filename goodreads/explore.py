import os
import time
import duckdb
import pandas as pd
from dotenv import load_dotenv
from memory_profiler import profile


load_dotenv()


google_storage_key = os.getenv("GOOGLE_STORAGE_KEY")
google_storage_secret = os.getenv("GOOGLE_STORAGE_SECRET")


@profile
def read_json():
    start = time.time()
    duckdb.read_json("./data/goodreads_books.json.gz").show()
    end = time.time()
    print(end - start)  # 6 seconds 



@profile
def read_cloud_file():
    db = duckdb.connect()
    start = time.time()
    # install httpfs
    db.sql(f"""
           INSTALL httpfs;
           LOAD httpfs;
           SET s3_endpoint = 'storage.googleapis.com';
           SET s3_access_key_id = '{google_storage_key}';
           SET s3_secret_access_key = '{google_storage_secret}';
           """)
    db.sql("""
           select * from read_json_auto('s3://data_collection_bucket/goodreads/goodreads_books.json.gz');
           """).show()
    end = time.time()
    print(end - start)  # 50 seconds



# analyze the data
def read_and_transform():
    db = duckdb.connect()
    # read json and describe
    db.sql("""
           describe
           select * from read_json_auto('./data/goodreads_books.json.gz');
           """).show()

    


if __name__ == '__main__':
    # start = time.time() 
    # df = pd.read_json("./data/goodreads_books.json.gz", lines=True)
    # end = time.time()
    # print(end - start)  # computer crashed
    # Execute a query
    duckdb.sql('SELECT 42').show()
    # read json file
    # read_json()
    # read cloud file
    # read_cloud_file()
    # read and transform
    read_and_transform()

