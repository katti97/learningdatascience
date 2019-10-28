tests = int(input('Enter no. of test cases: '))
for test in range(tests):
    a = list(map(int,input('Enter array elements: ').split()))
    max_here =0
    max_so_far=0
    for i in range(len(a)):
        if a[i]<a[i+1]: 
            max_here = max_here+a[i]
            if max_here>max_so_far:
                max_so_far = max_here
        print(max_so_far)
