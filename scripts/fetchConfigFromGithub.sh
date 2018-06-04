#!/bin/sh

cd ${CONFIG_DIR}
git init && git pull https://${GITHUB_TOKEN}@${GITHUB_URL}
