#!/bin/bash -e
filelist=$(ls *.md | rev | cut -c 4-| rev)
echo ${filelist}
for name in ${filelist}
do
pandoc -f markdown ${name}.md  -t html --template=template.html -o html_en/${name}.html --metadata title="MIROC-DOC ${name}" -c github-markdown.css
done

rm tmp*
