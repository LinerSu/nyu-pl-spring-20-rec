def f(x, h):
	def g(y):
		return h(x) + y
	if (x == 0): f(2, h)
	else: g

x = 3
def h(a):
	return a + x

def z(b):
	return  b + x // 3

print(f(0, z)(4))