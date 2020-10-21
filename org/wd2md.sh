#!/bin/bash -e
pandoc -s MATSIRO-description\ J-E\ nakamura071031_nh.docx --wrap=none --reference-links --extract-media=media -t gfm -o  MATSIRO071031_nh.md

