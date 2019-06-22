#!/usr/bin/env bash

echo "Install and Run Redis"

docker run -d --name redis --restart always -p 6379:6379 redis