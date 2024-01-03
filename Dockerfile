FROM ubuntu:latest

RUN apt update
RUN apt install -y clang libelf-dev vim pkg-config
RUN apt install -y make git sudo net-tools iputils-ping # debug

COPY . /home/ubuntu
WORKDIR /home/ubuntu
# build libbpf
RUN cd libbpf/src && make clean && make && make install

# build bpftool
RUN apt install -y binutils-dev llvm-dev gcc libcap-dev
RUN cd bpftool/src && make install
