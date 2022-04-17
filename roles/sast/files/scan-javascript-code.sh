#!/bin/bash

cd "$(dirname "$0")"
. scan-common.sh

run_njsscan() {
    echo "run njsscan"
    docker run -v $SOURCE_DIR:/src -v $REPORT_DIR:/report opensecurity/njsscan /src --sarif -o /report/njsscan.sarif
}

# main()
make_report_dir

run_gitleaks
run_dependency_check
run_semgrep
run_codeql javascript
run_njsscan