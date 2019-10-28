def checkpan(s):
    list1 = []
    for i in range(26):
        list1.append(False)

    for c in s.lower():
        if not c == " ":
            list1[ord(c)-ord('a')]=True

    for ch in list1:
        if ch == False:
            return False
    return True;

sentence = 'The quick brown fox jumps over the little lazy dog'

if checkpan(sentence):
    print('sentence is a panagram')
else:
    print('sentence is not a panagram')
