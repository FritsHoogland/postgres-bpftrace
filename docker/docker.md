// not needed: --security-opt="seccomp=unconfined" 

docker run \
-e POSTGRES_PASSWORD=postgres \
--rm \
--cap-add CAP_SYS_RESOURCE \
--cap-add CAP_BPF \
--cap-add CAP_PERFMON \
--cap-add CAP_SYS_PTRACE \
-v /sys/kernel/debug:/sys/kernel/debug:ro \
--pid host \
-p 5432:5432 \
postgres

// provided there is only one container running postgres  
docker exec -it $(docker ps --filter "ancestor=postgres" -q) bash

apt-get update && apt-get install -y bpftrace linux-libc-dev git  
git clone https://github.com/FritsHoogland/postgres-bpftrace.git  

