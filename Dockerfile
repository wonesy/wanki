FROM ubuntu:latest

RUN apt-get update && apt-get -y install curl

RUN mkdir -m 777 /usr/share/desktop-directories

RUN curl -L https://github.com/ankitects/anki/releases/download/2.1.37/anki-2.1.37-linux.tar.bz2 > anki.tar.bz2

RUN tar xjf anki.tar.bz2

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
    tzdata \
    locales \
    xdg-utils \
    ca-certificates \
    build-essential \
    mpv \
    lame \
    libnss3 \
    python3-pyqt5 \
    libxcb1 \
    libxcb1-dev \
    xcb \
    python3-xcbgen \
    qt5dxcb-plugin \
    xserver-xorg-video-dummy \
    mplayer locales materia-gtk-theme papirus-icon-theme dmz-cursor-theme

ENV LANG=en_US.UTF-8
ENV DISPLAY=:0.0
ENV ANKICONNECT_BIND_ADDRESS=0.0.0.0
ENV ANKICONNECT_CORS_ORIGIN="*"

RUN echo "Europe/Helsinki" > /etc/timezone && \
    echo "LANG=en_US.UTF-8" >> /etc/environment && \
    echo "LC_ALL=en_US.UTF-8" >> /etc/environment && \
    echo "LANGUAGE=en_US.UTF-8" >> /etc/environment && \
    dpkg-reconfigure -f noninteractive tzdata && \
    sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    echo 'LANG="en_US.UTF-8"'>/etc/default/locale && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG="en_US.UTF-8"

RUN locale-gen en_US.UTF-8

COPY xorg.conf /etc/X11

RUN cd anki-2.1.37-linux && sh install.sh 

COPY . .

RUN bash tardown.bash

RUN cp ./anki-connect-config.json /root/.local/share/Anki2/addons21/2055492159/config.json

ENTRYPOINT ["./run.bash"]
