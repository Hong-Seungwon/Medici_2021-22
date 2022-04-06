import pandas as pd

data = pd.read_csv('villains.csv')
print(data)

data.to_csv('test.csv')

mylist = [70, 80, 90, 66]
yourlist = ['국어', '영어', '수학', '미술']
df = pd.DataFrame({'과목':yourlist, '성적':mylist})
print(df)
#df.to_csv("성적.csv")

score = pd.read_csv('성적.csv', encoding='cp949')
print(score)