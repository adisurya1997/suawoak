#!/bin/bash
set -eu

readonly integration_dir=$(cd "$(dirname "$0")"; pwd)

"${integration_dir}/divider.sh" "Start running Ozone commands"

"${integration_dir}/run.sh" bash -c "ozone sh volume create sapujagad2"
"${integration_dir}/run.sh" bash -c "ozone sh bucket create sapujagad2/test"
"${integration_dir}/run.sh" bash -c "ozone sh key put sapujagad2/test/hosts /etc/hosts"
"${integration_dir}/run.sh" bash -c "ozone sh key cat sapujagad2/test/hosts"

"${integration_dir}/run.sh" bash -c "ozone sh bucket create s3v/test"
"${integration_dir}/run.sh" bash -c "aws s3 --endpoint http://ozone-s3g:9878 cp /etc/hosts s3://test/hosts"
"${integration_dir}/run.sh" bash -c "aws s3 --endpoint http://ozone-s3g:9878 cp s3://test/hosts /tmp/hosts"
"${integration_dir}/run.sh" bash -c "diff /etc/hosts /tmp/hosts"

"${integration_dir}/divider.sh" "Finished running Ozone commands"

echo "The test commands succeeded."
echo
