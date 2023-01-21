# Used for building deps that require deps not available in Pop!_OS 22.04 (Jammy)

From ubuntu:lunar
WORKDIR /usr
ARG SEQUENCE

# Setup Container
RUN sed -i 's/# deb-src/deb-src/g' /etc/apt/sources.list
RUN apt-get update
RUN apt-get dist-upgrade -y
RUN apt-get install -y \
      software-properties-common \
      curl \
      rustc \
      libllvmspirvlib-15-dev \
      python3-ply \
      bindgen \
      libclc-15
Run apt-get build-dep mesa -y

# Copy git Repository into Docker Continer to build
RUN mkdir /usr/mesa
COPy ./ /usr/mesa/
WORKDIR /usr/mesa

# TODO move back into setup contaienr
# Build repository
RUN dh $SEQUENCE --builddirectory=build/ --buildsystem=meson

