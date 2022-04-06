'''
CREATE PROCEDURE AveragePrice(out averageVal integer)
begin
	select avg(price) into  averageVal 
    from book where price is not null;
end
'''
import pymysql

con = pymysql.connect(host="127.0.0.1", 
        user='root', passwd='12315973', db='bookstore')
query = "set @averageVal = 0; \
        call AveragePrice(@averageVal); \
        select @averageVal; "
try:
    with con.cursor() as cur:
        cur.execute(query)
        result = cur.fetchone()
        print(result)
except Exception as e:
    print(e)
    raise
finally:
    con.close()