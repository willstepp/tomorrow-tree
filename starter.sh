#!/bin/sh

if [ $(ps -e -o uid,cmd | grep $UID | grep node | grep -v grep | wc -l | tr -s "\n") -eq 0 ]
then
  export PATH=/usr/local/bin:$PATH
  export NODE_ENV=production
  pm2 start -i max -o /home/daniel/public/tree.monomyth.io/logs/access.log -e /home/daniel/public/tree.monomyth.io/logs/error.log /home/daniel/public/tree.monomyth.io/public/app.js
fi