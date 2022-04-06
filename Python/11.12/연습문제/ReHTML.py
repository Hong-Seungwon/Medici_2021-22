import urllib.request
import re
url = 'https://finance.naver.com/item/main.nhn?code=229200'
html = urllib.request.urlopen(url)
html_contents = str(html.read().decode('cp949'))

#print(html_contents)
stock_result = re.findall("(\<dl class=\"blind\"\>)([\s\S]+?)(\<\/dl\>)",html_contents)
print(stock_result[0][1])
result = re.findall("(\<dd\>)([\s\S]+?)(\<\/dd\>)",stock_result[0][1])
for r in result:
    print(r[1])