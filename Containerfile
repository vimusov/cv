FROM archlinux:latest

RUN \
    set -eux \
    && pacman -Sy --noconfirm \
    && pacman -S --noconfirm \
        pandoc-cli \
        texlive-bin \
        texlive-core \
        ttf-dejavu \
    && luaotfload-tool -uvvvv

WORKDIR /build
VOLUME  /build

COPY conv.sh /conv.sh
ENTRYPOINT   /conv.sh
