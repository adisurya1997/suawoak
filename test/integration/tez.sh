#!/bin/bash
set -eu

readonly integration_dir=$(cd "$(dirname "$0")"; pwd)

"${integration_dir}/divider.sh" "Start running a Tez job"

"${integration_dir}/run.sh" gohdfs rm -rf /user/sapujagad2/tez-wordcount-input
"${integration_dir}/run.sh" gohdfs rm -rf /user/sapujagad2/tez-wordcount-output
"${integration_dir}/run.sh" gohdfs put /etc/hosts /user/sapujagad2/tez-wordcount-input
"${integration_dir}/run.sh" bash -c "
  hadoop \
  jar \
  /opt/tez/tez-examples-*.jar \
  orderedwordcount \
  /user/sapujagad2/tez-wordcount-input \
  /user/sapujagad2/tez-wordcount-output
"
"${integration_dir}/run.sh" gohdfs cat /user/sapujagad2/tez-wordcount-output/part-v002-o000-r-00000

"${integration_dir}/divider.sh" "Finished running a Tez job"
echo "The test job succeeded."
echo

"${integration_dir}/tez_log.sh"
