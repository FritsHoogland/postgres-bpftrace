This directory contains the files to build a container for testing the wait events probes.

1. build
To build a docker container that runs postgres with the wait events probes compiled in, run: ./build

2. run
Once the docker container is built, run the container: ./run
This opens a shell as postgres in the container. 
Typically, start the database: ./start_database and create a database session: psql

3. exec
If you want to use a second session to run the bpftrace scripts: ./exec
This opens a shell as postgres too.
Now run a bpftrace script as root: sudo ./postgres-bpftrace/query-analyzer-waits-noidle.bt

