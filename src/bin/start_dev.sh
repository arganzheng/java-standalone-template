#!/bin/bash

# determine base directory; preserve where you're running from
#echo "Path to $(basename $0) is $(readlink -f $0)"
realpath=$(readlink -f "$0")
filepath=$(dirname "$realpath")
basedir=${filepath%/*}

LOG_DIR=${basedir}/logs
mkdir -p ${LOG_DIR}
GC_LOG_DIR=${basedir}/logs/gc
mkdir -p ${GC_LOG_DIR}
GC_FILE_PATH="${GC_LOG_DIR}/gc-$(date +%s).log"

LIBCLASSPATH=`echo ${basedir}/lib/*.jar | tr ' ' ':'`
export CLASSPATH=$LIBCLASSPATH:${basedir}/conf
echo $CLASSPATH
echo $basedir

JAVA_OPTS="-server -Xms256m -Xmx256m -XX:+DisableExplicitGC -Xloggc:${GC_FILE_PATH} -XX:+PrintGCDetails -XX:+HeapDumpOnOutOfMemoryError -Dlog4j.configuration=file:$basedir/conf/log4j.properties -DLOG_DIR=${LOG_DIR}"
echo $JAVA_OPTS

java $JAVA_OPTS life.arganzheng.study.standalone.Main
