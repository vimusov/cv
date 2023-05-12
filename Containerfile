FROM archlinux:latest

RUN \
    set -eux \
    && pacman -Sy --noconfirm \
    && pacman -S --noconfirm \
        just \
        pandoc-cli \
        texlive-bin \
        texlive-core \
        ttf-dejavu \
    && luaotfload-tool -uvvvv

WORKDIR /build
VOLUME  /build

ENTRYPOINT ["just"]
CMD ["convert"]
