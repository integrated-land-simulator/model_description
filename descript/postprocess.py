import sys

md_old = "{}.md".format(sys.argv[1].strip())
md_new = "{}_conv.md".format(sys.argv[1].strip())

for line in open(md_old,'r').readlines():
  line = line.rstrip()
  line = line.replace('\\_', '_')
  line = line.replace('\\*', '*')
  line = line.replace('\\+', '+')
  line = line.replace('\\-', '-')
  line = line.replace('\\left\\\\{', '\\left\\{')
  print(line)
