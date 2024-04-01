#!/usr/bin/env
# -*- coding: utf-8 -*-
echo "Starting API"
python3.12 -m gunicorn --bind 0.0.0.0:5500 --worker-class uvicorn.workers.UvicornWorker --timeout=600 app:app --reload
