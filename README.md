# Run RChain network

## Run bootstrap node

```sh
docker-compose up rnode0
```

When bootstrap node `rnode0` is up, configure `.env` file with the data for connecting child node.

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

## Run `rnode` commands

Using scripts for Linux `./rnode` and Windows `./rnode.ps1`.

```sh
# deploy contract
./rnode deploy --from "0x1" --phlo-limit 0 --phlo-price 0 --nonce 0 /opt/docker/examples/tut-rcon.rho

# deploy contract from local folder
./rnode deploy --from "0x1" --phlo-limit 0 --phlo-price 0 --nonce 0 /contracts/tut-hello.rho

# propose contract
./rnode propose

# show blocks
./rnode show-blocks
```

<details><summary>Alternative way to run <code>rnode</code> commands</summary>

## Create `rnode` alias

### Linux

```sh
# rnode alias
function rnode {
  rnodeVer=dev;
  grpcHost=rnode1;
  grpcPort=50511;
  # execute rnode command
  docker run -it --rm --network rchainnetwork_rchain-net -v $PWD/contracts:/contracts rchain/rnode:$rnodeVer --grpc-host $grpcHost -g $grpcPort $*;
}
```

### Windows (Powershell)

```powershell
# rnode alias
function rnode {
  $rnodeVer = 'dev';
  $grpcHost = 'rnode1';
  $grpcPort = 50511;
  docker run -it --rm --network rchain-network_rchain-net -v $PWD/contracts:/contracts rchain/rnode:$rnodeVer --grpc-host $grpcHost -g $grpcPort $args;
}
```

Examples:

```sh
rnode propose

rnode show-blocks
```

</details>
