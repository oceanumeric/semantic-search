# Goodreads Book Graph Datasets

The data is downloaded from [Goodreads Book Graph Datasets](https://mengtingwan.github.io/data/goodreads.html). The author also provides the [code](https://github.com/MengtingWan/goodreads?tab=readme-ov-file) to download the data.

Here, we will write some script to download the data we need:

- books:  detailed meta-data about 2.36M books
- reviews: Complete 15.7m reviews (~5g) and 15M records with detailed review text

## Instructions

- `data_files.csv` gives the name of the files 
- `download.sh` is the script to download the data from the website and save to `data` folder
- `gcloud.sh` is the script to download the data and upload to Google Cloud Storage

To use `gcloud.sh`, you need to have `gsutil` installed and have a Google Cloud Storage account. You need to change the `BUCKET_NAME` to your own bucket name after `gcloud init`.

> Tips: it is better to download the data to your local machine from google cloud storage. It is faster than downloading from the website.

## Comments

There are many tools for doing data ETL. Unless you are doing some business that has a strong __pattern__ in the data, you should not spend too much time on data ETL.

All the model tools of doing ETL are designed for firms that have the consistent data flow pattern. For data projects having different data sources, it is better to use a general purpose language to do the ETL. For example, Python, R, and bash are all good choices.

- https://matt.might.net/articles/intro-to-make/
- https://merely-useful.tech/py-rse/automate.html