#!/usr/bin/env bash

docker compose down && 
    docker image rm wordpress-jetpack-broken-access-control-vulnerable-application-wordpress &&
    docker volume rm wordpress-jetpack-broken-access-control-vulnerable-application_wordpress_jetpack_db
