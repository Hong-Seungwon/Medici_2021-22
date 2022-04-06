import pymysql

con = pymysql.connect(host="127.0.0.1", 
        user='root', passwd='12315973', db='testdb')
myid = 4
try:
    with con.cursor() as cur:
        cur.execute('select * from cities where id=%s', myid)
        cityid, name, population = cur.fetchone()
        print(cityid, name, population)
finally:
    con.close()