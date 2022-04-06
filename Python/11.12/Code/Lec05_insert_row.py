import pymysql

con = pymysql.connect(host="127.0.0.1", 
        user='root', passwd='12315973', db='testdb')
city = ('mycity', 20000)
try:
    with con.cursor() as cur:
        cur.execute('insert into cities values (null, %s, %s)',
                     (city[0],city[1]))
        con.commit()
        print('new city inserted')
finally:
    con.close()