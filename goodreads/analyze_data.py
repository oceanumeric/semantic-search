#%%
import os
import time
import math
import duckdb
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from dotenv import load_dotenv
# %%
%load_ext sql
conn = duckdb.connect()
%sql conn --alias duckdb
# %%
# to receive feedback from SQL queries
%config SqlMagic.feedback = False
%config SqlMagic.displaylimit = None  # None means unlimited
%config SqlMagic.style = "SINGLE_BORDER"
# %%
%%sql 
select 42 as my_answer
# %%
%%sql
DESCRIBE
SELECT * FROM read_json_auto('data/goodreads_books.json.gz')

# %%
%%sql
DESCRIBE
SELECT * FROM read_json_auto('data/goodreads_reviews_dedup.json.gz')
# %%
%%sql
CREATE TABLE books AS
SELECT book_id, title, description, authors, language_code, num_pages,
country_code, publication_year, average_rating, ratings_count, text_reviews_count,
publisher, url FROM read_json_auto('data/goodreads_books.json.gz')
# %%
%%sql
DESCRIBE
SELECT * FROM books
#%%
%%sql
SELECT COUNT(*) AS count
FROM books
WHERE book_id IS NULL
GROUP BY book_id
# %%
%%sql
SELECT language_code, COUNT(*) AS count
FROM books
GROUP BY language_code
ORDER BY count DESC
# %%
%%sql
SELECT *
FROM (SELECT book_id, language_code, title, description
FROM books
WHERE language_code = '')
USING SAMPLE 10
# %%
# sample 10 books with language_code = ''
num_eng_books = [
    9, 9, 10, 10, 9, 10, 9, 9, 10, 10
]

def hypergeometric_probability(N = 1060153, n = 10, k = 9, p=0.8):
    """
    p is the share of English books in the population
    """
    english_books = N * p
    english_books = int(english_books)
    non_english_books = N - english_books

    prob = math.comb(english_books, k) * math.comb(non_english_books, n - k) / math.comb(N, n)

    return prob

print(hypergeometric_probability())
print(hypergeometric_probability(p=0.3))

potential_p = np.linspace(0, 1, 100)
hypergeometric_p = [hypergeometric_probability(p=p) for p in potential_p]

# plot
%config InlineBackend.figure_format='retina'
fig, ax = plt.subplots(figsize=(7, 4))
ax.plot(potential_p, hypergeometric_p, 'k-')
ax.set_xlabel('p')
ax.set_ylabel('probability')
ax.set_title('Hypergeometric distribution with different p (N = 1060153, n = 10, k = 9)')
# add vertical line
ax.axvline(x=0.8, color='g', linestyle='--')
# add horizontal line
ax.axhline(y=0.25, color='g', linestyle='--')
# %%
%%sql
CREATE TABLE books2 AS
SELECT * FROM books
WHERE language_code = 'eng' OR language_code = 'en-US' OR language_code = 'en-GB'
# %%
%%sql
DESCRIBE
SELECT * FROM books2
# %%
%%sql
-- check authors data
DESCRIBE
SELECT * FROM read_json_auto('./data/goodreads_book_authors.json.gz')
# %%
%%sql
-- sample 5 from authors
SELECT *
FROM read_json_auto('./data/goodreads_book_authors.json.gz')
USING SAMPLE 5
# %%
%%sql
-- create table authors
CREATE TABLE authors AS
SELECT * FROM read_json_auto('./data/goodreads_book_authors.json.gz')

# %%
%%sql
-- have a look at books2
DESCRIBE
SELECT *
FROM books2
USING SAMPLE 5

# %%
%%sql
-- join books2 and authors
-- book2.authors is a nested array
-- with this format '[{'author_id': 99727, 'role': ''}]'
-- therefore we need to unnest it first
SELECT unnest([{'author_id': 99727, 'role': ''}], recursive := true)

# %%
%%sql
SELECT unnest([{'author_id': 1654, 'role': ''}, {'author_id': 8134289, 'role': ''}], recursive := true)
# %%
%%sql
SELECT book_id, title, authors, unnest(authors) AS author_info
FROM books2
USING SAMPLE 10
# %%
