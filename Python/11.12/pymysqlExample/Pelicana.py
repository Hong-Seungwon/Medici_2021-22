
import urllib.request
from bs4 import BeautifulSoup
import pandas as pd 
from itertools import count 
from PelicanaDB import MyDB
db = MyDB()
import urllib.request
from bs4 import BeautifulSoup
from itertools import count
import pandas as pd 
import ssl 
import datetime

def get_request_url(url, enc='utf-8'):
    context = ssl._create_unverified_context()
    req = urllib.request.Request(url)
    try:
        response = urllib.request.urlopen(req, context=context)
        if response.getcode() == 200:
            print("[%s] Url Request Success " % datetime.datetime.now())
            try:
                rcv =response.read()
                ret = rcv.decode(enc)
            except UnicodeDecodeError:
                ret = rcv.decode(enc, 'replace')
            return ret
    except Exception as e:
        print(e)
        print("[%s] Error for URL " % datetime.datetime.now())
result = []
#for pageNum in count():
for pageNum in range(112) :
    url = 'https://pelicana.co.kr/store/stroe_search.html?page=%s' % str(pageNum+1)
    #response = urllib.request.urlopen(url)
    #soupData = BeautifulSoup(response, 'html.parser')
    rcv_data = get_request_url(url)
    soupData = BeautifulSoup(rcv_data, 'html.parser')
    table = soupData.find('table', {'class':"table mt20"})
    tbody = table.find('tbody')
    #print(tbody)
    #print(list(tbody.find_all('tr')[0].strings))
    #store  = list(tbody.find_all('tr')[0].strings)
    beEnd = True 
    for store in tbody.find_all('tr'):
        beEnd = False
        tr_tag = list(store.strings)
        
        store_name = tr_tag[1]
        if tr_tag[3] == ' ' :
            continue
        store_addr = tr_tag[3]
        store_phone = tr_tag[5].strip()
        store_sido_gu = tr_tag[3].split()[:2]
        result.append([store_name]+store_sido_gu+[store_addr]+[store_phone])
    if beEnd : 
        break
    print("페리카나 [%s] 페이지 크롤링중" % (str(pageNum+1)))
# for pageNum in range(1:)
#print(result)
print(len(result))
for store in result:
        print("%s " % store)
        db.pelicana_crawlingInsert(store[0], store[1],store[2],store[3],store[4])
print("페리카나 지점을 데이터베이스 저장완료 !!!!")
print("="*60)
print("크롤링완료 !!!!")

db.db_free()

#pelicana_table = pd.DataFrame(result, columns=['store', 'sido','gungu','address', 'phone'])
#pelicana_table.to_csv('pelicana.csv', encoding='cp949', index=True)
