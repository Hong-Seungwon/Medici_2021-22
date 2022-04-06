import json

with open('json_example.json', 'r') as f:
    content = f.read()
    json_data = json.loads(content)


print(json_data['employees'][0]['lastName'])