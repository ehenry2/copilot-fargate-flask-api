#!/bin/bash

cd /app && \
pipenv run gunicorn --access-logfile=- --bind "0.0.0.0:8080" -w 2 'app:app'
