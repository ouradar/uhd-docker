FROM ubuntu:24.04

# Prevent interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

COPY sh-root-bashrc /root/.bashrc
COPY sh-home-profile .profile
COPY run.sh /root/run.sh

# Install build-essential and clean up cache to keep the image small
# RUN apt-get update && apt-get install -y \
#     build-essential \
#     autoconf automake build-essential ccache cmake cpufrequtils \
#     doxygen ethtool fort77 g++ gir1.2-gtk-3.0 git \
#     gobject-introspection gpsd gpsd-clients inetutils-tools \
#     libasound2-dev libboost-all-dev libcomedi-dev libcppunit-dev \
#     libfftw3-bin libfftw3-dev libfftw3-doc libfontconfig1-dev \
#     libgmp-dev libgps-dev libgsl-dev liblog4cpp5-dev libncurses6 \
#     libncurses-dev libpulse-dev libqt5opengl5-dev libqwt-qt5-dev \
#     libsdl1.2-dev libtool libudev-dev libusb-1.0-0 libusb-1.0-0-dev \
#     libusb-dev libxi-dev libxrender-dev libzmq3-dev libzmq5 \
#     ncurses-bin python3-cheetah python3-click python3-click-plugins \
#     python3-click-threading python3-dev python3-docutils python3-gi \
#     python3-gi-cairo python3-gps python3-lxml python3-mako python3-numpy \
#     python3-opengl python3-pyqt5 python3-requests python3-scipy \
#     python3-setuptools python3-six python3-sphinx python3-yaml \
#     python3-zmq python3-ruamel.yaml swig wget python3-pygccxml \
#     libjs-mathjax python3-pyqtgraph \
#     && rm -rf /var/lib/apt/lists/*

RUN apt-get update && \
    # build essential and UHD dependencies
    apt-get install -y build-essential git \
    libuhd-dev uhd-host libboost-program-options-dev \
    libfftw3-dev libnetcdf-dev libssl-dev libarchive-dev && \
    rm -rf /var/lib/apt/lists/* ; \
    # misc setup
    chmod +x /root/run.sh && \
    mkdir /root/Developer

CMD ["/root/run.sh"]
