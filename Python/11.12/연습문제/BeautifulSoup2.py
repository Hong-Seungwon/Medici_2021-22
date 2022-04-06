
from bs4 import BeautifulSoup

with open('US08621662-20140107.XML', 'r') as f:
    xml = f.read()

soup = BeautifulSoup(xml, 'lxml')

print(soup.find('invention-title').get_text())   