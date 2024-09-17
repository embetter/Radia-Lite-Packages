#!/bin/bash
docker stop gateway-rs
docker rm gateway-rs
docker rmi quay.io/team-helium/miner:gateway-latest
