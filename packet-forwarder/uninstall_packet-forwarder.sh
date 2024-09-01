#!/bin/bash
docker stop lora-pkt-frwdr
docker rm lora-pkt-frwdr
docker rmi public.ecr.aws/h5f9d0n0/embettertech/lora-pkt-frwdr:latest
