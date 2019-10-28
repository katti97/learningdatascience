def kadane(a):
    max_here = 0
    max_so_far = 0
    for i in range(0,len(a)):
        max_here = max_here + a[i]
        if(max_here<0):
            max_here = 0
        elif(max_here > max_so_far):
           max_so_far = max_here
    return max_so_far

a = [-1,4,-3,1,5,7,-2,-8]
print("maximum contagious subarray sum is, ",kadane(a))
