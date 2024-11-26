#!/bin/bash
docker stop mawari
docker rm mawari 
docker rmi public.ecr.aws/h5f9d0n0/embettertech/mawari:latest