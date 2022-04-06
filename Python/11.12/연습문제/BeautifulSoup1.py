from bs4 import BeautifulSoup

with open('books.xml', 'r') as f:
    book_xml = f.read()

print(book_xml)

soup = BeautifulSoup(book_xml, 'lxml')
books = soup.find_all('author')

print(books[0].get_text(),books[1].get_text())