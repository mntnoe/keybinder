#!/usr/bin/env python
import sys
import os
import re

"""
Replace @PREFIX@ stuff with environment vars
"""

class Mapping (object):
	"Return '' for missing strings"
	def __init__(self, values):
		self.values = values
	def __getitem__(self, key):
		return self.values.get(key, "")

def replacepipe(write, read, mapping):
	for line in read:
		line_1 = line.replace("%", "%%")
		# Replace @PREFIX@ by %(PREFIX)s
		line_2 = re.sub(r'@(\w+)@', r'%(\1)s', line_1)
		write.write(line_2 % Mapping(mapping))

def grabvars(data):
	"Make a KEY=Value file into a dict"
	XX = data.splitlines()
	return dict([tuple(L.split("=", 1)) for L in XX if L])

if __name__ == "__main__":
	if len(sys.argv) < 2 or not os.path.exists(sys.argv[1]):
		print >>sys.stderr, "Requires file as first argument"
		raise SystemExit(1)
	mapping = grabvars(open(sys.argv[1]).read())
	replacepipe(sys.stdout, sys.stdin, mapping)
