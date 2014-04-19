#! /usr/bin/python

import sys

filename = sys.argv[1]

lines=[]

matchline='DllImport("leveldb"'

for line in file(filename):
	if matchline in line:
		lines.append('#if UNITY_IOS\n')
		lines.append(line.replace('"leveldb"', '"__Internal"'))
		lines.append('#else\n')
		lines.append(line)
		lines.append('#endif\n')
	else:
		lines.append(line)

print >> file(filename, 'w'), ''.join(lines)