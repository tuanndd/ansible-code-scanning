#!/bin/bash

cd "$(dirname "$0")"

. scan-common.sh

run_bandit() {
    echo "run bandit"
     bandit $SOURCE_DIR -r -f csv -o $REPORT_DIR/bandit.csv
}

# main()
make_report_dir

run_gitleaks
run_dependency_check
run_semgrep
run_codeql python
run_bandit
