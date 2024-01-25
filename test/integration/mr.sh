#!/bin/bash
set -eu

readonly integration_dir=$(cd "$(dirname "$0")"; pwd)

"${integration_dir}/divider.sh" "Start running a MR job"

"${integration_dir}/run.sh" gohdfs rm -rf /user/sapujagad2/mr-wordcount-input
"${integration_dir}/run.sh" gohdfs rm -rf /user/sapujagad2/mr-wordcount-output
"${integration_dir}/run.sh" gohdfs put /etc/hosts /user/sapujagad2/mr-wordcount-input

"${integration_dir}/run.sh" bash -c "
  hadoop \
  jar \
  /opt/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-*.jar \
  wordcount \
  /user/sapujagad2/mr-wordcount-input \
  /user/sapujagad2/mr-wordcount-output
"
"${integration_dir}/run.sh" gohdfs cat /user/sapujagad2/mr-wordcount-output/part-r-00000

"${integration_dir}/divider.sh" "Finished running a MR job"
echo "The test job succeeded."
echo

"${integration_dir}/mr_log.sh"
