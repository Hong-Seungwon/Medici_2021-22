import re 
import urllib.request

url = "http://goo.gl/U7mSQl"
html = urllib.request.urlopen(url)
html_contents =str(html.read())
#print(html_contents)
result = re.findall('([a-z0-9]+\*\*\*)', html_contents)
#print(result)
for r in result :
    print(r)