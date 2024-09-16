#!/bin/bash
docker stop helium-pkt-frwdr
docker rm helium-pkt-frwdr
docker rmi public.ecr.aws/h5f9d0n0/embettertech/helium-pkt-frwdr:latest
