#!/bin/bash

## Generate coverage report
PROJECT_ROOT_PATH=$1
PACKAGE_PATH=$2
PACKAGE_NAME=$3
REPORT_ROOT_PATH=$PROJECT_ROOT_PATH/ci/reports

PACKAGE_LCOV_INFO_PATH=$REPORT_ROOT_PATH/coverage/lcov_$PACKAGE_NAME.info
PACKAGE_TEST_REPORT_PATH=$REPORT_ROOT_PATH/test_reports/$PACKAGE_NAME.json

mkdir -p $REPORT_ROOT_PATH/coverage/ $REPORT_ROOT_PATH/coverage_report/ $REPORT_ROOT_PATH/test_reports/
flutter test \
  --no-pub \
  --file-reporter json:$PACKAGE_TEST_REPORT_PATH \
  --coverage \
  --coverage-path $PACKAGE_LCOV_INFO_PATH

escapedPath="$(echo $PACKAGE_PATH | sed 's/\//\\\//g')"

# Requires gsed on MacOS machines because otherwise sed is not the same...
if [[ "$OSTYPE" =~ ^darwin ]]; then
  gsed -i "s/^SF:lib/SF:$escapedPath\/lib/g" $PACKAGE_LCOV_INFO_PATH
else
  sed -i "s/^SF:lib/SF:$escapedPath\/lib/g" $PACKAGE_LCOV_INFO_PATH
fi