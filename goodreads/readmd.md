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