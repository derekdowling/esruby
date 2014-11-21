#!/usr/bin/env bash

# assuming you are already at the dir you want to install kibana to
curl -o kibana.tar.gz https://download.elasticsearch.org/kibana/kibana/kibana-4.0.0-BETA2.tar.gz
mkdir kibana
tar -C kibana/ -xf kibana.tar.gz

# Open kibana/config/kibana.yml, change host from "0.0.0.0" to "localhost", Recipe
# opens port for us

./bin/kibana
