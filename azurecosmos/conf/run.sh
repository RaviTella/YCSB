#!/bin/bash

if [ -z "$workload_type" ]; then
    workload=workloada
else
    workload=$workload_type
fi

if [ -z "$ycsb_operation" ]; then
    operation=load
else
    operation=$ycsb_operation
fi

if [ -z "$load_or_run" ]; then
    workload=workloada
else
    workload=$workload_type
fi

# REQUIRED URI & KEY
if [ ! -z "$uri" ]; then
   sed -i "s|^[#]*\s*azurecosmos.uri\ =.*|azurecosmos.uri\ =\ $uri|" azurecosmos.properties
fi

if [ ! -z "$primaryKey" ]; then
   sed -i "s/^[#]*\s*azurecosmos.primaryKey\ =.*/azurecosmos.primaryKey\ =\ $primaryKey/" azurecosmos.properties
fi

if [ ! -z "$databaseName" ]; then
   sed -i "s/^[#]*\s*azurecosmos.$databaseName\ =.*/azurecosmos.databaseName\ =\ $databaseName/" azurecosmos.properties
fi

if [ ! -z "$useUpsert" ]; then
   sed -i "s/^[#]*\s*azurecosmos.useUpsert\ =.*/azurecosmos.useUpsert\ =\ $useUpsert/" azurecosmos.properties
fi

if [ ! -z "$includeExceptionStackInLog" ]; then
   sed -i "s/^[#]*\s*azurecosmos.includeExceptionStackInLog\ =.*/azurecosmos.includeExceptionStackInLog\ =\ $includeExceptionStackInLog/" azurecosmos.properties
fi

if [ ! -z "$userAgent" ]; then
   sed -i "s/^[#]*\s*azurecosmos.userAgent\ =.*/azurecosmos.userAgent\ =\ $userAgent/" azurecosmos.properties
fi

# CONNECTION OPTIONS
if [ ! -z "$useGateway" ]; then
   sed -i "s/^[#]*\s*azurecosmos.useGateway\ =.*/azurecosmos.userAgent\ =\ $useGateway/" azurecosmos.properties
fi

if [ ! -z "$consistencyLevel" ]; then
   sed -i "s/^[#]*\s*azurecosmos.consistencyLevel\ =.*/azurecosmos.userAgent\ =\ $consistencyLevel/" azurecosmos.properties
fi

if [ ! -z "$maxRetryAttemptsOnThrottledRequests" ]; then
   sed -i "s/^[#]*\s*azurecosmos.maxRetryAttemptsOnThrottledRequests\ =.*/azurecosmos.maxRetryAttemptsOnThrottledRequests\ =\ $maxRetryAttemptsOnThrottledRequests/" azurecosmos.properties
fi

if [ ! -z "$maxRetryWaitTimeInSeconds" ]; then
   sed -i "s/^[#]*\s*azurecosmos.maxRetryWaitTimeInSeconds\ =.*/azurecosmos.maxRetryWaitTimeInSeconds\ =\ $maxRetryWaitTimeInSeconds/" azurecosmos.properties
fi

if [ ! -z "$gatewayMaxConnectionPoolSize" ]; then
   sed -i "s/^[#]*\s*azurecosmos.gatewayMaxConnectionPoolSize\ =.*/azurecosmos.gatewayMaxConnectionPoolSize\ =\ $gatewayMaxConnectionPoolSize/" azurecosmos.properties
fi

if [ ! -z "$directMaxConnectionsPerEndpoint" ]; then
   sed -i "s/^[#]*\s*azurecosmos.directMaxConnectionsPerEndpoint\ =.*/azurecosmos.directMaxConnectionsPerEndpoint\ =\ $directMaxConnectionsPerEndpoint/" azurecosmos.properties
fi

if [ ! -z "$gatewayIdleConnectionTimeoutInSeconds" ]; then
   sed -i "s/^[#]*\s*azurecosmos.gatewayIdleConnectionTimeoutInSecondst\ =.*/azurecosmos.gatewayIdleConnectionTimeoutInSeconds\ =\ $gatewayIdleConnectionTimeoutInSeconds/" azurecosmos.properties
fi

if [ ! -z "$directIdleConnectionTimeoutInSeconds" ]; then
   sed -i "s/^[#]*\s*azurecosmos.directIdleConnectionTimeoutInSeconds\ =.*/azurecosmos.directIdleConnectionTimeoutInSeconds\ =\ $directIdleConnectionTimeoutInSeconds/" azurecosmos.properties
fi

# QUERY OPTIONS
if [ ! -z "$maxDegreeOfParallelism" ]; then
   sed -i "s/^[#]*\s*azurecosmos.maxDegreeOfParallelism\ =.*/azurecosmos.maxDegreeOfParallelism\ =\ $maxDegreeOfParallelism/" azurecosmos.properties
fi

if [ ! -z "$maxBufferedItemCount" ]; then
   sed -i "s/^[#]*\s*azurecosmos.maxBufferedItemCount\ =.*/azurecosmos.maxBufferedItemCount\ =\ $maxBufferedItemCount/" azurecosmos.properties
fi

if [ ! -z "$preferredPageSize" ]; then
   sed -i "s/^[#]*\s*azurecosmos.preferredPageSize\ =.*/azurecosmos.preferredPageSize\ =\ $preferredPageSize/" azurecosmos.properties
fi

if [ ! -z "$exportfile" ]; then
   sed -i "s|^[#]*\s*exportfile\ =.*|exportfile\ =\ $exportfile|" azurecosmos.properties
fi

log_filename="/tmp/ycsb.log"

if [ ! -z "$threads" ] && [ ! -z "$target" ]
then
  ./bin/ycsb.sh $operation azurecosmos -P workloads/$workload -P azurecosmos.properties -s -threads $threads -target $target 2>&1 | tee -a "$log_filename"
elif [ ! -z "$threads" ]
then
  ./bin/ycsb.sh $operation azurecosmos -P workloads/$workload -P azurecosmos.properties -s -threads $threads 2>&1 | tee -a "$log_filename"
elif [ ! -z "$target" ]
then
  ./bin/ycsb.sh $operation azurecosmos -P workloads/$workload -P azurecosmos.properties -s -target $target 2>&1 | tee -a "$log_filename"
else
  ./bin/ycsb.sh $operation azurecosmos -P workloads/$workload -P azurecosmos.properties -s 2>&1 | tee -a logs.txt
fi