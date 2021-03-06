#!/bin/bash -e
#
# Test environment
## pandoc
# pandoc 2.11.3.2
# Compiled with pandoc-types 1.22, texmath 0.12.1, skylighting 0.10.2,
# citeproc 0.3.0.3, ipynb 0.1.0.1
# Copyright (C) 2006-2020 John MacFarlane. Web:  https://pandoc.org

# Specify the directory markdown file existed
dir=./descript

# Get markdown file names to be compiled
filelist=($(ls ${dir}/*.md | rev | cut -c 4-| rev))
echo ${filelist[@]}

# Conversion from markdown to LaTeX
for name in ${filelist[@]}
do
	sed -e s/'\\('/'$'/g ${name}.md | \
	sed -e s/'\\)'/'$'/g | \
  sed -e '/code_chunk_output/,/code_chunk_output/d' | \
	sed -e s/'<div style="text-align: right;"><!\\begin{flushright}>'/'\\begin{flushright}'/g | \
	sed -e s/'<\/div> <!\\end{flushright}>'/'\\end{flushright}'/g | \
	sed -e s/'<!--beginlandscape-->'/'\n beginlandscape \n'/g | \
	sed -e s/'<!--endlandscape-->'/'\n endlandscape \n'/g | \
	sed -e s/'\[\(.*\)\](\(#.*\))'/'\[\]\(\2\)'/g >tmp.md


	pandoc -t latex --columns=200 --natbib --bibliography descript/reference.bib tmp.md | \
        sed -e '/# References/d' | \
	sed -e s/'\\\['/'\\begin\{eqnarray\}'/g | \
	sed -e s/'\\\]'/'\\end\{eqnarray\}'/g | \
  sed -e s/'\\tag'/'\\label'/g | \
	sed -e s/'beginlandscape'/'\\begin{landscape}'/g | \
	sed -e s/'endlandscape'/'\\end{landscape}'/g | \
	sed -e s/'\\protect\\hyperlink'/'\\ref'/g | \
  sed -e 's/https.*descript/descript/' | \
	sed -e 's/\(\\ref{.*}\)\({}\)/\1/g' \
	> ${name}.tex

done

rm tmp.md
