import json
import urllib.request

hres = urllib.request.urlopen('http://time.jsontest.com')

data = json.loads(hres.read())

print('Unix Time: {}'.format(data["milliseconds_since_epoch"]))
print('Time: {}'.format(data["time"]))
print('Date: {}'.format(data["date"]))