import json 

dict_data = {'name':'zara', 'age':7, 'class':'first'}

with open('saved.json','w') as f:
    json.dump(dict_data, f)