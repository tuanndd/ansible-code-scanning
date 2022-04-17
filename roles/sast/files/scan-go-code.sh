#!/bin/bash

cd "$(dirname "$0")"
. scan-common.sh

run_gosec() {
    echo "run gosec"
    gosec/gosec -fmt sarif -out $REPORT_DIR/gosec.sarif $SOURCE_DIR/...
}

# main()
make_report_dir

run_gitleaks
run_dependency_check
run_semgrep
run_codeql go
run_gosec