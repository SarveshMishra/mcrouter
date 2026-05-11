FROM ubuntu:24.04 AS builder

ENV MCROUTER_DIR=/usr/local/mcrouter
ENV DEBIAN_FRONTEND=noninteractive
ENV PKG_DIR=$MCROUTER_DIR/pkgs
ENV INSTALL_DIR=$MCROUTER_DIR/install

# Install build dependencies
COPY mcrouter/scripts/docker/ubuntu/scripts/deps.sh /tmp/scripts/deps.sh
RUN /tmp/scripts/deps.sh

# Copy the entire local repository so that local fork modifications are built
COPY . /src

# Run the build script
COPY mcrouter/scripts/docker/ubuntu/scripts/build.sh /tmp/scripts/build.sh
RUN /tmp/scripts/build.sh

# Final stage
FROM ubuntu:24.04

ENV MCROUTER_DIR=/usr/local/mcrouter
ENV DEBIAN_FRONTEND=noninteractive

# Install runtime dependencies only
RUN apt-get update && apt-get install -y \
    libbz2-1.0 \
    libdouble-conversion3 \
    libevent-2.1-7t64 \
    libgflags2.2 \
    libgoogle-glog0v6 \
    libjemalloc2 \
    liblz4-1 \
    liblzma5 \
    libsnappy1v5 \
    libsodium23 \
    libssl3t64 \
    libunwind8 \
    libxxhash0 \
    libzstd1 \
    libboost-context1.83.0 \
    libboost-filesystem1.83.0 \
    libboost-program-options1.83.0 \
    libboost-regex1.83.0 \
    libboost-system1.83.0 \
    libboost-thread1.83.0 \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY --from=builder /usr/local/mcrouter/install /usr/local/mcrouter/install

RUN ln -s /usr/local/mcrouter/install/bin/mcrouter /usr/local/bin/mcrouter

ENV DEBIAN_FRONTEND=newt
ENTRYPOINT ["mcrouter"]
