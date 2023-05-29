#!/bin/bash

export DISBATCH_KVSSTCP_HOST={kvsserver:s} PYTHONPATH={DisBatchRoot:s}:${{PYTHONPATH}}

if [[ $1 == '--mon' ]]
then
    exec {DisBatchPython} {DisBatchRoot:s}/disbatchc/dbMon.py {uniqueId:s}
elif [[ $1 == '--engine' ]]
then
    exec {DisBatchPython} -c 'from disbatchc import disBatch ; disBatch.main()' "$@"
else
    exec {DisBatchPython} -c 'from disbatchc import disBatch ; disBatch.main()' --context {DbUtilPath:} "$@" < /dev/null 1> {uniqueId:s}_${{BASHPID-$$}}_context_launch.log
fi
