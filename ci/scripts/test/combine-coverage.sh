#!/bin/bash

PROJECT_ROOT_PATH=$1
REPORT_ROOT_PATH=$PROJECT_ROOT_PATH/ci/reports
while read FILENAME; do
  LCOV_INPUT_FILES="$LCOV_INPUT_FILES -a \"$REPORT_ROOT_PATH/coverage/$FILENAME\""
done < <( ls "$REPORT_ROOT_PATH/coverage/" )

eval lcov "${LCOV_INPUT_FILES}" -o $REPORT_ROOT_PATH/coverage_report/combined_lcov.info

lcov --ignore-errors unused --remove $REPORT_ROOT_PATH/coverage_report/combined_lcov.info \
  "lib/main_*.dart" \
  "lib/di.dart" \
  "*.gr.dart" \
  "*.g.dart" \
  "*.freezed.dart" \
  "*.drift.dart" \
  "*di.config.dart" \
  "*.i69n.dart" \
  "*/generated/*" \
  "*/errors/*" \
  "*/exceptions/*" \
  "*/response/*" \
  "*/tables/*" \
  "*/test_tools/*" \
  "*.theme_extension.dart" \
  -o $REPORT_ROOT_PATH/coverage_report/cleaned_combined_lcov.info