FROM ubuntu:24.04

# Prevent interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

COPY sh-root-bashrc /root/.bashrc
COPY run.sh /opt/run.sh

RUN apt update && \
    # Add the Ettus Research PPA for latest UHD
    apt install -y software-properties-common && \
    add-apt-repository -y ppa:ettusresearch/uhd && \
    # build essential and UHD dependencies
    apt install -y --no-install-recommends \
    build-essential gcc gdb git tree \
    ssh net-tools inetutils-ping libnss-mdns \
    libuhd-dev uhd-host libboost-program-options-dev \
    # dependencies for RadarKit
    libfftw3-dev libnetcdf-dev libssl-dev libarchive-dev && \
    rm -rf /var/lib/apt/lists/* ; \
    # misc setup
    chmod +x /opt/run.sh && \
    mkdir /root/Developer

# Configure NSS to use mDNS for .local resolution
RUN sed -i 's/^hosts: .*/hosts: files mdns4_minimal [NOTFOUND=return] dns/' /etc/nsswitch.conf

CMD ["/opt/run.sh"]
