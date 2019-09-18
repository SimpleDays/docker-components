#!/bin/bash

echo ':::::::: build kafka-manager :::::::'

docker build -t kafka-manager:2.0.0.2 .

