def kth(a,k):
	a.sort()
	return a[k-1]

arr = list(map(input("Enter space seperated array elements").split(" ")))
k = int(input("Enter the kth smallest element you want to find in the array: "))
print(kth(arr,k))