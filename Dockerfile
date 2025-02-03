FROM debian:latest

ENV GO_VERSION="1.22.1"

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -y -q update \
    && apt-get -y -q install nano git wget build-essential librust-gobject-sys-dev libnss3 libnss3-dev

RUN wget https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz -O /tmp/go.tar.gz \
    && rm -rf /usr/local/go \
    && tar -C /usr/local -xzf /tmp/go.tar.gz \
    && echo 'export PATH=$PATH:/usr/local/go/bin' >> /root/.bashrc \
    && echo 'export PATH=$PATH:/root/go/bin' >> /root/.bashrc

RUN echo "go clean; go build -v" >> /root/.bash_history

RUN echo '#!/bin/bash' > /entrypoint.sh \
    && echo 'mkdir -p /workspace/bin/' >> /entrypoint.sh \
    && echo 'cd /workspace/src/' >> /entrypoint.sh \
    && echo '' >> /entrypoint.sh \
    && echo 'if [ $# -ge 2 ]; then' >> /entrypoint.sh \
    && echo '  OS=$1' >> /entrypoint.sh \
    && echo '  ARCH=$2' >> /entrypoint.sh \
    && echo 'else' >> /entrypoint.sh \
    && echo '  OS=$(uname -s | tr "[:upper:]" "[:lower:]")' >> /entrypoint.sh \
    && echo '  ARCH=$(uname -m)' >> /entrypoint.sh \
    && echo 'fi' >> /entrypoint.sh \
    && echo '' >> /entrypoint.sh \
    && echo 'case ${ARCH} in' >> /entrypoint.sh \
    && echo '  x86_64) GOARCH="amd64" ;;' >> /entrypoint.sh \
    && echo '  i386|i686) GOARCH="386" ;;' >> /entrypoint.sh \
    && echo '  aarch64) GOARCH="arm64" ;;' >> /entrypoint.sh \
    && echo '  armv7*) GOARCH="arm" ;;' >> /entrypoint.sh \
    && echo '  *) GOARCH=$ARCH ;;' >> /entrypoint.sh \
    && echo 'esac' >> /entrypoint.sh \
    && echo '' >> /entrypoint.sh \
    && echo '/usr/local/go/bin/go clean' >> /entrypoint.sh \
    && echo 'echo "[>] Building for GOOS=$OS GOARCH=$GOARCH"' >> /entrypoint.sh \
    && echo 'mkdir -p "/workspace/bin/$OS/$GOARCH/"' >> /entrypoint.sh \
    && echo 'echo "[>] Writing binaries in ./bin/$OS/$GOARCH/"' >> /entrypoint.sh \
    && echo 'echo "[>] Building: GOOS=$OS GOARCH=$GOARCH /usr/local/go/bin/go build -o "/workspace/bin/$OS/$GOARCH/" -buildvcs=false"' >> /entrypoint.sh \
    && echo 'GOOS=$OS GOARCH=$GOARCH /usr/local/go/bin/go build -o "/workspace/bin/$OS/$GOARCH/" -buildvcs=false' >> /entrypoint.sh \
    && echo 'echo "[>] Done"' >> /entrypoint.sh \
    && chmod +x /entrypoint.sh

# Prepare workspace volume
RUN mkdir -p /workspace/
VOLUME /workspace/
WORKDIR /workspace/

ENTRYPOINT ["/entrypoint.sh"]
