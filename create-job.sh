#!/bin/bash

set -e

# Create and activate virtualenv to install Jenkins Job Builder
virtualenv -p python2.7 jjb_venv
source jjb_venv/bin/activate

pip install jenkins-job-builder

echo "============================================"
echo "Creating 'vunit-vhdl-code-check' Job in Jenkins"
jenkins-jobs --conf /home/machin/Projects/credentials/jenkins_jobs.ini update vunit-vhdl-code-check.yaml

rm -rf jjb_venv
echo "...Completed..."
