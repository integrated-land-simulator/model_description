import sys

md = "{}.md".format(sys.argv[1].strip())

for line in open(md,'r').readlines():
  line = line.rstrip()
  line = line.replace('\\_', '_')
  line = line.replace('\\*', '*')
  line = line.replace('\\+', '+')
  line = line.replace('\\-', '-')
  line = line.replace('\\left\\\\{', '\\left\\{')
  print(line)
