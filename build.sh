#!/bin/bash

set -e

rm -rf build && mkdir -p build
swiftc -v \
  -target x86_64-apple-macosx10.10 \
  -o build/TrySwiftFIRDBClient \
  TrySwiftFIRDBClient/*.swift

echo "Output to build/TrySwiftFIRDBClient"


