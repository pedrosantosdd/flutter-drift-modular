#!/bin/bash

## Generate coverage report
PROJECT_ROOT_PATH=$1
genhtml -o $PROJECT_ROOT_PATH/ci/reports/coverage_report/ $PROJECT_ROOT_PATH/ci/reports/coverage_report/cleaned_combined_lcov.info