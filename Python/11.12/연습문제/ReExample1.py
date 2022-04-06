data = """
park 800905-1049118
kim  700905-1059119
"""
'''
result = []
for line in data.split("\n"):
    word_result = []
    for word in line.split(" "):
        if len(word) == 14 and word[:6].isdigit() and word[7:].isdigit():
            word = word[:6] + "-" + "*******"
        word_result.append(word)
    result.append(" ".join(word_result))
print("\n".join(result))
'''


import re 

pattern = re.compile("r(\d{6}[-]\d{7})")
m = pattern.match('123123-1234123')
print(m)