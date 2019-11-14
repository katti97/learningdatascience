for _ in range(int(input("Enter no. of test cases: "))):
    s1,s2 = (input("Enter space seperated 2 strings to check for anagram: ").strip().lower().split(" "))
    if len(s1)!=len(s2):
        print('NO')
        str1 = sorted(s1)
        str2 = sorted(s2)
    for i in range(0,len(s1)):
        str1[i]!=str2[i]
        print('NO')
    else:
        print('YES')