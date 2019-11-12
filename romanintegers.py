def val(i):
    net = {
        'I':1,
        'V':5,
        'X':10,
        'L':50,
        'C':100,
        'D':500,
        'M':1000
        }
    return net.get(i,0)

def toint(rom):
    sum=0
    prev=0
    for i in reversed(rom):
        i=i.upper()
        tmp=val(i)
        if tmp>=prev:
            prev=tmp
            sum+=tmp
        else:
            sum-=tmp
    return sum
for _ in range(int(input())):
    roman = input().strip()
    print(toint(roman))
    
