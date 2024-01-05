import pandas as pd


def construct_urls():
    file_names = pd.read_csv("data_files.csv")

    file_name_type_mapping = dict(zip(file_names['name'].values, file_names['type'].values))

    data_info = pd.DataFrame()

    for fname in file_name_type_mapping:
        file_name_url_mapping = {}
        ftype = file_name_type_mapping[fname]
        if ftype == "complete":
            file_name_url_mapping['ftype'] = "complete"
            url = 'https://datarepo.eng.ucsd.edu/mcauley_group/gdrive/goodreads/'+fname
            file_name_url_mapping['fname'] = fname
            file_name_url_mapping['url'] = url
        elif ftype == "byGenre":
            file_name_url_mapping['ftype'] = "byGenre"
            url = 'https://datarepo.eng.ucsd.edu/mcauley_group/gdrive/goodreads/byGenre/'+fname
            file_name_url_mapping['fname'] = fname
            file_name_url_mapping['url'] = url
    
        # convert to dataframe
        temp_df = pd.DataFrame(file_name_url_mapping, index=[0])

        # concat to data_info
        data_info = pd.concat([data_info, temp_df], axis=0, ignore_index=True)

    
    # save to csv
    data_info.to_csv("data_info.csv", index=False)


def create_bash_file():
    data_info = pd.read_csv("data_info.csv")

    google_bucket_name = "data_collection_bucket/goodreads"

    commands = []

    for idx, row in data_info.iterrows():
        fname = row['fname']
        url = row['url']
        command = f'curl {url} | gsutil cp - gs://{google_bucket_name}/{fname}'
        commands.append(command)

    with open("download_data.sh", "w") as f:
        f.write("#!/bin/bash\n")
        f.write("# download data online and upload to google bucket directly\n")
        for command in commands:
            f.write(command)
            f.write("\n")


if __name__ == "__main__":
    # run construct_urls() first
    # construct_urls()
    create_bash_file()