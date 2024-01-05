import sys

while True:
	l = sys.stdin.buffer.read(4)
	if not l:
		break
	print("%d\t%d\t%d\t%d" % (l[0], l[1], l[2], l[3]))
