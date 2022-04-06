import pymysql

con = pymysql.connect(host="127.0.0.1", 
        user='root', passwd='12315973', db='testdb')
try:
    with con.cursor() as cur:
        cur.execute('select * from cities')
        rows = cur.fetchall()
        #print(rows)
        for row in rows:
            print(f'{row[0]} {row[1]:15} {row[2]:10}')
finally:
    con.close()