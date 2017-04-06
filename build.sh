#!/bin/sh
# Builds all targets and runs tests.

DERIVED_DATA=${1:-/tmp/Nora}
echo "Derived data location: $DERIVED_DATA";

set -o pipefail &&
rm -rf $DERIVED_DATA &&
time xcodebuild clean test \
    -workspace Nora.xcworkspace \
    -scheme 'Nora' \
    -sdk iphonesimulator10.2 \
    -derivedDataPath $DERIVED_DATA \
    -destination 'platform=iOS Simulator,name=iPhone 7,OS=10.2' \
    OTHER_SWIFT_FLAGS='-Xfrontend -debug-time-function-bodies' \
    | tee build.log \
    | xcpretty &&
cat build.log | sh debug-time-function-bodies.sh
