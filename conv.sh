#!/bin/bash

set -eux

trap 'rm -rf .texlive' EXIT

for md in [a-z][a-z].md; do
    pdf=${md/.md/.pdf}
    pandoc \
        --standalone \
        --from=markdown --to=pdf \
        --pdf-engine=xelatex \
        --variable='colorlinks=true' \
        --variable='geometry:margin=1cm' \
        --variable='linkcolor=blue' \
        --variable='mainfont:DejaVuSerif' \
        --variable='pagestyle=empty' \
        --variable='papersize:a4' \
        --variable='toccolor=gray' \
        --variable='urlcolor=red' \
        --output="$pdf" "$md"
    cp --attributes-only --preserve=mode,ownership \
        "$md" "$pdf"
done
