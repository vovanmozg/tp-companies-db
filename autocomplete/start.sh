#!/bin/bash
npm install
cd ./frontend
npm install
node_modules/webpack-cli/bin/cli.js
cd ..
npm start