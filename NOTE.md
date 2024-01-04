## using libbpf

```bash
# docker run
make run

# ====== in the docker container ======

# build bpf program
cd src && make hello.bpf.o

bpftool prog list
bpftool prog load hello.bpf.o /sys/fs/bpf/hello
ls /sys/fs/bpf # => hello
bpftool prog list
bpftool prog show id <ID> --pretty

# bpftool net attach xdp id 179 dev eth0 # => error below
# root@00ac084bf9ac:/home/ubuntu/src# bpftool net attach xdp id 179 dev eth0
# libbpf: Kernel error message: veth: Peer MTU is too large to set XDP
# Error: interface xdp attach failed: Numerical result out of range
# root@00ac084bf9ac:/home/ubuntu/src# echo $?
# 222
# root@00ac084bf9ac:/home/ubuntu/src#
```

---
on raspberrypi

```bash
apt install -y clang libelf-dev pkg-config make
apt install -y libbpf-dev
ln -s /usr/include/arm-linux-gnueabihf /usr/include/armv7l-linux-gnu

apt install -y binutils-dev llvm-dev gcc libcap-dev

cd src && make hello.bpf.o

git submodule update --init --recursive

cd bpftool/src && make install

bpftool prog list
bpftool prog load hello.bpf.o /sys/fs/bpf/hello
ls /sys/fs/bpf # => hello
bpftool prog list
bpftool prog show id 444 --pretty
# =>
# {
#     "id": 444,
#     "type": "xdp",
#     "name": "hello",
#     "tag": "4ae0216d65106432",
#     "gpl_compatible": true,
#     "loaded_at": 1704385803,
#     "uid": 0,
#     "bytes_xlated": 168,
#     "jited": false,
#     "bytes_memlock": 4096,
#     "map_ids": [7,8
#     ],
#     "btf_id": 6
# }

bpftool net attach xdp id 444 dev eth0
cat /sys/kernel/debug/tracing/trace_pipe
# =>
# <idle>-0       [000] d.s.1 29715821.884512: bpf_trace_printk: Hello World 4644
# <idle>-0       [000] d.s.1 29715821.885787: bpf_trace_printk: Hello World 4645
# ...

```
