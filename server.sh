#!/bin/sh

set -e

: ${HOST:=0.0.0.0}
: ${PORT:=4567}

exec bundle exec rackup --host "$HOST" --port "$PORT"
