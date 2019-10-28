print('Enter number of test cases:')
tests = int(input())
for test in range(tests):
    print('Enter size and target:')
    size, target = map(int,input().split(" "))
    print('Enter the array values:')
    arr = map(int,input().split(" "))
    ip,sum,flag = 0,0,-1
    for i in range(size):
        if flag==0:
            break
        sum= sum + arr[i]
        if sum == target:
            print(ip+1,i+1)
            flag=0
        if sum>target:
            while sum>target:
                sum=sum-arr[ip]
                ip+=1
                if sum == target:
                    print(ip+1,i+1)
                    flag=0
    if flag == -1: print(-1)
