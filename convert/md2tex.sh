#!/bin/bash -e
filelist=$(ls *.md | rev | cut -c 4-| rev)
echo ${filelist}

for name in ${filelist}
do
	pandoc ${name}.md -o ${name}.tex
done

