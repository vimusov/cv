set dotenv-load

doas := env_var_or_default('DOAS', '')

default: run

build:
    {{doas}} podman build --no-cache --rm --force-rm -t cv-builder .

run:
    {{doas}} podman run -it --rm --volume {{invocation_directory()}}:/build cv-builder

convert:
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
