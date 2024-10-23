#!/usr/bin/env bash

docker compose down && 
    docker image rm wordpress-jetpack-info-disclosure-vulnerable-application-wordpress &&
    docker volume rm wordpress-jetpack-info-disclosure-vulnerable-application_wordpress_jetpack_db
