# Run RChain network

## Run bootstrap node

```sh
docker-compose up rnode0
```

### Fill correct `boostrap address` and `validator key` in `.env` file

**Bootstrap address** should be taken from the log of `rnode0` node.

Running bootstrap node will generate validator keys in `./rnode0/genesis` folder. The file has a name `<public_key>.sk` and the content is **validator private key**.

```sh
# .env file

# from rnode0 log - Listening for traffic on rnode://...@rnode0:50500
RNODE_0_ADDRESS=rnode://ba6cc16d0a57ffc03588f0b01ba399186069d0a8@rnode0:50500

# from ./rnode0/genesis/<public_key>.sk file
RNODE_1_VALIDATOR_PRIVATE_KEY=8d80515e04f22c5bc394e5d1943b694c7c9df13c97f7420a5851c76276620673
```

## Run child node

```sh
docker-compose up rnode1
```

## Deploy and propose contract

```sh
# rnode alias
function rnode {
  grpcHost=rnode1;
  grpcPort=50511;
  rnodeVer=dev;
  # run rnode
  docker run -it --rm --network rchainnetwork_rchain-net -v $PWD/contracts:/contracts rchain/rnode:$rnodeVer --grpc-host $grpcHost -g $grpcPort $*
}

# deploy contract
rnode deploy --from "0x1" --phlo-limit 0 --phlo-price 0 --nonce 0 /opt/docker/examples/tut-rcon.rho

rnode deploy --from "0x1" --phlo-limit 0 --phlo-price 0 --nonce 0 /contracts/tut-hello.rho

# propose contract
rnode propose

# show blocks
rnode show-blocks
```
