import requests
import sys
from datetime import datetime

url = 'https://kaeru2193.github.io/Phun-Resources/dict/phun-dict.json'
response = requests.get(url)

outPath = r"./phun.dict.yaml"

if response.status_code == 200:
    dict = response.json()
    result = []

    for entry in dict["data"]:
        result.append("\t".join([entry["word"], entry["pron"]]))

    newline = "\n"
    now = datetime.now()
    tsv = f"""\
# encoding: utf-8
---
name: phun
version: "{now.strftime("%Y.%m.%d")}"
sort: original
...

{newline.join(result)}"""
    
    with open(outPath, mode='w', encoding='utf-8') as f:
        f.write(tsv)
else:
    sys.exit('jsonファイルを取得できませんでした')