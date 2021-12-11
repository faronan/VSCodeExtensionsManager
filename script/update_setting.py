import itertools
import json
import os

import requests
from dotenv import load_dotenv


def flatten(iter):
    return list(itertools.chain.from_iterable(iter))


def create_extensions_array(key, value, rm_set, add_set):
    return [i for i in value + list(add_set) if i not in rm_set]


def main():
    load_dotenv()

    url = os.environ["GIST_URL"]
    res = requests.get(url)
    gist_extension_set = set([j["metadata"]["publisherId"] for j in res.json()])

    with open("extensions.json", "r") as j_r:
        json_file_load = json.load(j_r)
    file_extension_set = set(flatten(json_file_load.values()))

    rm_extensions = file_extension_set - gist_extension_set
    add_extensions = gist_extension_set - file_extension_set

    content = {
        key: create_extensions_array(
            key, value, rm_extensions, (add_extensions if key == "unknown" else ())
        )
        for key, value in json_file_load.items()
    }

    with open("extensions.json", "w") as j_w:
        json.dump(content, j_w, indent=2)
        # 手元でファイルを更新する時との差分が生じないように、末尾改行を入れる。
        j_w.write("\n")


if __name__ == "__main__":
    main()
