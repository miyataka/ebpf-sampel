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
