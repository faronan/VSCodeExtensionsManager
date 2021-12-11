import itertools
import json

import requests
from bs4 import BeautifulSoup
from pytablewriter import MarkdownTableWriter


def flatten(iter):
    return list(itertools.chain.from_iterable(iter))


def create_soup(url):
    res = requests.get(url)
    res.raise_for_status()
    return BeautifulSoup(res.text, "html.parser")


def get_desc(soup):
    shortdesc = soup.select(
        "#section-banner > div > table > tbody > tr > td.item-header > div > ",
        "div.ux-item-shortdesc",
    )[0].get_text()
    return shortdesc


def get_install_count(soup):
    install_count = soup.select(
        "#section-banner > div > table > tbody > tr > td.item-header > div >",
        "div.ux-item-second-row-wrapper > div.ux-item-rating > span",
    )[0].get_text()
    return install_count


def get_img(soup):
    src = soup.select("#vss_2 > img")[0].get("src")
    markdown_img = "![Alternate text]({})".format(src)
    return markdown_img


def create_extension_table_element(extension):
    url = "https://marketplace.visualstudio.com/items?itemName={}".format(extension)
    soup = create_soup(url)
    desc = get_desc(soup)
    install_count = get_install_count(soup)
    img = get_img(soup)
    return [desc, install_count, img]


def main():
    with open("extensions.json", "r") as j_r:
        json_load = json.load(j_r)
    extension_list = flatten(json_load.values())

    content = [
        flatten([[extension], create_extension_table_element(extension)])
        for extension in extension_list
    ]

    writer = MarkdownTableWriter(
        headers=["name", "desc", "installs", "image"],
        value_matrix=content,
    )
    with open("extensions.md", "w") as m_f:
        writer.stream = m_f
        writer.write_table()


if __name__ == "__main__":
    main()
