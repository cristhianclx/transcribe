#!/bin/bash

flask \
  --app main \
  run \
  --host 0.0.0.0 \
  --port $PORT \
  --reload
