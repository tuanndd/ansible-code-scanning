#!/bin/bash

SOURCE_DIR="${1:-$HOME/src}"
REPORT_DIR="${2:-$HOME/report}"

SOURCE_NAME="$(basename $SOURCE_DIR)"

make_report_dir() {
    echo "make report dir"
    mkdir -p $REPORT_DIR
}

run_gitleaks()
{
    echo "gitleaks"

    gitleaks/gitleaks detect -s $SOURCE_DIR -r $REPORT_DIR/gitleaks.sarif
}

run_dependency_check(){
    echo "run dependency-check"

    dependency-check/bin/dependency-check.sh -s $SOURCE_DIR -o $REPORT_DIR -f SARIF --enableExperimental
}

run_semgrep()
{
    echo "run semgrep"

    docker run -v $SOURCE_DIR:/src -v $REPORT_DIR:/report returntocorp/semgrep --config auto --sarif --output /report/semgrep-auto.sarif
    docker run -v $SOURCE_DIR:/src -v $REPORT_DIR:/report returntocorp/semgrep --config "p/owasp-top-ten" --sarif --output /report/semgrep-owasp.sarif
}

run_codeql() {
    LANGUAGE=$1

    echo "run codeql"

    codeql-cli/codeql database create codeql-db/$SOURCE_NAME --source-root=$SOURCE_DIR --overwrite --language=$LANGUAGE
    codeql-cli/codeql database analyze --format=sarif-latest --output=$REPORT_DIR/codeql.sarif codeql-db/$SOURCE_NAME
}