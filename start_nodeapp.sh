#!/bin/bash

set -e

NODE_APP_FILE=bootcamp-node-envvars-project-1.0.0.tgz

echo "Installing nodejs and npm"
if sudo apt-get update && sudo apt-get install -y nodejs npm wget; then
    echo "Node and NPM were installed succesfully."
else
    echo "Node or NPM installation fail."
fi

echo "###################################"
echo "NPM version:"
npm --version

echo "###################################"
echo "Nodejs version:"
nodejs --version

echo "###################################"
echo "Downloading NPM app"
rm -rf $NODE_APP_FILE
rm -rf package
wget https://node-envvars-artifact.s3.eu-west-2.amazonaws.com/"$NODE_APP_FILE"

echo "###################################"
echo "Uncompressing Node app"
tar -xvzf $NODE_APP_FILE

echo "###################################"
echo "Setting environment variables"
export APP_ENV=dev
export DB_USER=myuser
export DB_PWD=mysecret

cd package

echo "###################################"
echo "Executing NPM install"
npm install
npm audit fix --force
echo "###################################"
echo "Starting node app"
node server.js
