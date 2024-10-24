#!/bin/bash
docker stop rd-postgres
docker rm rd-posgtres
docker rmi postgres:16.3