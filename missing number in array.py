a=[]
print("Enter the no of test cases: ")
tests = int(input())
for test in range(tests):
    print('Enter the array size:')
    n = int(input())
    print('Enter array elements:')
    for i in range(n-1):
        no = int(input("num:"))
        a.append(int(no))
    lisum = int(sum(a))
    sum=int(n*(n+1)/2)
    print(int(sum-lisum))
    
