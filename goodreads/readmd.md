# Goodreads Book Graph Datasets

The data is downloaded from [Goodreads Book Graph Datasets](https://mengtingwan.github.io/data/goodreads.html). The author also provides the [code](https://github.com/MengtingWan/goodreads?tab=readme-ov-file) to download the data.

Here, we will write some script to download the data we need:

- books:  detailed meta-data about 2.36M books
- reviews: Complete 15.7m reviews (~5g) and 15M records with detailed review text

## Instructions

- `data_files.csv` gives the name of the files 
- `download.sh` is the script to download the data if you want to download the data locally


## Download the data to Google Cloud Storage directly

```
curl http://some.url.com/some/file.tar | gsutil cp - gs://YOUR_BUCKET_NAME/file.tar
```
