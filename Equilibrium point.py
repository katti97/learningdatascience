def equi(a):
	left = 0
	right =0
	n=len(a)
	for i in range(n):
		left =0
		right=0
		for j in range(i):
			left+=j
		for j in range(i+1,n):
			right+=j
		if right==left:
			return a[i]
	return -1	

arr = list(map(int,input("Enter space seperated array elements: ").split(" "))