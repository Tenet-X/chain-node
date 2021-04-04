#!/bin/bash
platonkey genkeypair | tee >(grep "PrivateKey" | awk '{print $2}' > ~/platon-node/data/nodekey) >(grep "PublicKey" | awk '{print $3}' > ~/platon-node/data/nodeid)
platonkey genblskeypair | tee >(grep "PrivateKey" | awk '{print $2}' > ~/platon-node/data/blskey) >(grep "PublicKey" | awk '{print $3}' > ~/platon-node/data/blspub)
platon --identity platon --datadir ~/platon-node/data --port 16789 --rpcport 6789 --rpcapi "db,platon,net,web3,admin,personal" --rpc --nodekey ~/platon-node/data/nodekey --cbft.blskey ~/platon-node/data/blskey --verbosity 3 --rpcaddr 127.0.0.1 --syncmode "full"
