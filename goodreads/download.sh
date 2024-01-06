#!/bin/bash
# download data online and save to local
curl https://datarepo.eng.ucsd.edu/mcauley_group/gdrive/goodreads/goodreads_book_works.json.gz > data/goodreads_book_works.json.gz
curl https://datarepo.eng.ucsd.edu/mcauley_group/gdrive/goodreads/goodreads_book_authors.json.gz > data/goodreads_book_authors.json.gz
curl https://datarepo.eng.ucsd.edu/mcauley_group/gdrive/goodreads/goodreads_book_series.json.gz > data/goodreads_book_series.json.gz
curl https://datarepo.eng.ucsd.edu/mcauley_group/gdrive/goodreads/goodreads_books.json.gz > data/goodreads_books.json.gz
curl https://datarepo.eng.ucsd.edu/mcauley_group/gdrive/goodreads/goodreads_book_genres_initial.json.gz > data/goodreads_book_genres_initial.json.gz
curl https://datarepo.eng.ucsd.edu/mcauley_group/gdrive/goodreads/book_id_map.csv > data/book_id_map.csv
curl https://datarepo.eng.ucsd.edu/mcauley_group/gdrive/goodreads/user_id_map.csv > data/user_id_map.csv
curl https://datarepo.eng.ucsd.edu/mcauley_group/gdrive/goodreads/goodreads_interactions.csv > data/goodreads_interactions.csv
curl https://datarepo.eng.ucsd.edu/mcauley_group/gdrive/goodreads/goodreads_reviews_dedup.json.gz > data/goodreads_reviews_dedup.json.gz
curl https://datarepo.eng.ucsd.edu/mcauley_group/gdrive/goodreads/goodreads_reviews_spoiler.json.gz > data/goodreads_reviews_spoiler.json.gz
curl https://datarepo.eng.ucsd.edu/mcauley_group/gdrive/goodreads/goodreads_reviews_spoiler_raw.json.gz > data/goodreads_reviews_spoiler_raw.json.gz
