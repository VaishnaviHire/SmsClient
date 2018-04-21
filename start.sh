#!/bin/bash

export PORT=5108

cd ~/www/smsClient
./bin/smsClient stop || true
./bin/smsClient start

