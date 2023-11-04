FROM debian:bookworm as build
WORKDIR /src
RUN apt-get update && apt-get install -y --no-install-recommends \
    automake gcc g++ make libncurses-dev nasm libsdl-net1.2-dev libsdl2-net-dev libswscale-dev libfreetype-dev libxkbfile-dev libxrandr-dev \
    wget ca-certificates unzip patch
RUN wget -O dosbox-0.74-3.tar.gz 'https://downloads.sourceforge.net/project/dosbox/dosbox/0.74-3/dosbox-0.74-3.tar.gz'
COPY libserial-0.74.3.diff .
RUN tar -zxvf dosbox-0.74-3.tar.gz && \
    cd dosbox-0.74-3 && \
    patch -p0 -i ../libserial-0.74.3.diff && \
    ./configure --prefix=/dosbox && \
    make -j && \
    make install
WORKDIR /gm300
RUN wget -O gm300v5.zip 'https://www.worldwidedx.com/attachments/gm300v5-zip.9511/'
RUN unzip gm300v5.zip && rm gm300v5.zip

FROM debian:bookworm-slim
RUN apt-get update && apt-get install -y --no-install-recommends \
    libncurses6 libsdl-net1.2 libsdl2-net-2.0-0 libswscale6 libfreetype6 libxkbfile1 libxrandr2 libgl1 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
COPY --from=build /dosbox /dosbox
COPY --from=build /gm300 /gm300
COPY GM300.CFG /gm300/GM300.CFG
WORKDIR /root/.dosbox
COPY dosbox-0.74-3.conf .
WORKDIR /root
CMD [ "/dosbox/bin/dosbox" ]
