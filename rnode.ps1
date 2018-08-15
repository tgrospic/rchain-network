# Powershell helper script

# remote node config (rnode1)
$rnodeVer = 'master';
$grpcHost = 'rnode1';
$grpcPort = 50511;

# execute rnode command
docker run -it --rm --network rchain-network_rchain-net -v $PWD/contracts:/contracts rchain/rnode:$rnodeVer --grpc-host $grpcHost -g $grpcPort $args;
