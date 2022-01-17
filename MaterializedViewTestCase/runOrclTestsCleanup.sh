#! /bin/bash +ex
#-----------------------------------------------------------------------------------------------------------------------------------
# Routine Name: runDbLinkTests.sh
# Author:       Mike Revitt
# Date:         18/11/2010
#-----------------------------------------------------------------------------------------------------------------------------------
# Revision History    Push Down List
# ----------------------------------------------------------------------------------------------------------------------------------
# Date        | Name        | Description
# ------------+-------------+-------------------------------------------------------------------------------------------------------
#             |             |
# 18/11/2020  | M Revitt    | Initial version
#-------------+-------------+-------------------------------------------------------------------------------------------------------
# Copyright 2020 Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files
# (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify,
# merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is
# furnished to do so.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
# OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
# CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#-----------------------------------------------------------------------------------------------------------------------------------

OPTIONS="h:p:s:u:w:d:H:P:S:U:W:R:F:"

AWS_PROFILE="default"
AWS_REGION="eu-west-1"
DMSTASKID='postgres-mv-load-and-sync'
PGDEST="postgres-mv-12-5-destination"
PGHOST='mvblogpg.c06yrdvam2nb.eu-west-1.rds.amazonaws.com'
PGNAME='postgres'
PGPASSWORD='aws-oracle'
PGPORT='5432'
PGUSER='mike'
PROGRAM_NAME="`basename $0`"
ORCLHOST='mvblog.crlotjrmovmg.us-east-2.rds.amazonaws.com'
ORCLNAME='XEPDB1'
ORCLPASSWD='aws-oracle'
ORCLPORT='1522'
ORCLSOURCE="oracle-mv-12c-r1-source"
ORCLUSER='mike'

getDmsEndPointArn()
{
  ENDPOINT_ARN=`aws dms describe-endpoints       \
      --filters     "Name=endpoint-id,Values=$1" \
      --query       "Endpoints[0].EndpointArn"   \
      --output       text                        \
      --region      "$AWS_REGION"                \
      --profile     "$AWS_PROFILE" 2>>/dev/null`
}
deleteDmsEndPoint()
{
  DMS_ENDPOINT=`aws dms delete-endpoint \
      --endpoint-arn "$1"               \
      --region       "$AWS_REGION"      \
      --profile      "$AWS_PROFILE" 2>>/dev/null`
}
getDmsReplicationTaskArn()
{
  REPLICATION_TASK_ARN=`aws dms describe-replication-tasks      \
      --filters   "Name=replication-task-id,Values=$DMSTASKID"  \
      --query     "ReplicationTasks[0].ReplicationTaskArn"      \
      --output     text                                         \
      --region    "$AWS_REGION"                                 \
      --profile   "$AWS_PROFILE" 2>>/dev/null`
}
deleteDmsReplicationTask()
{
  REPLICATION_TASK=`aws dms delete-replication-task \
      --replication-task-arn    "$1"                \
      --region                  "$AWS_REGION"       \
      --profile                 "$AWS_PROFILE" 2>>/dev/null`
}
stopDmsReplicationTask()
{
  REPLICATION_TASK=`aws dms stop-replication-task   \
      --replication-task-arn    "$1"                \
      --region                  "$AWS_REGION"       \
      --profile                 "$AWS_PROFILE" 2>>/dev/null`
}
usage()
{
    echo -e "\nUsage: $PROGRAM_NAME -h [ORCLHOST]   -p [ORCLPORT]   -s [ORCLNAME] -u [ORCLUSER] -w [ORCLPASSWD]  -d [DMSTASK]"
    echo -e "\t\t\t      -H [PGHOST]     -P [PGPORT]     -s [PGNAME]   -U [PGUSER]   -W [PGPASSWORD]"
    echo -e "\t\t\t      -R [Region]     -F [Profile]\n"
    echo -e "\t-h [ORCLHOST]\t[$ORCLHOST]\t\t\tOracle database server host"
    echo -e "\t-p [ORCLPORT]\t[$ORCLPORT]\t\t\t\tOracle database server port"
    echo -e "\t-s [ORCLNAME]\t[$ORCLNAME]\tOracle database service name"
    echo -e "\t-u [ORCLUSER]\t[$ORCLUSER]\t\t\t\tOracle database user name"
    echo -e "\t-w [ORCLPASSWD]\t[$ORCLPASSWD]\t\t\tOracle database password"
    echo -e "\t-d [DMSTASK]\t[$DMSTASKID]\tThe Task ID for the DMS Replication Task"
    echo -e "\t-H [PGHOST]\t[$PGHOST]\t\t\tPostgreSQL database server host"
    echo -e "\t-P [PGPORT]\t[$PGPORT]\t\t\t\tPostgreSQL database server port"
    echo -e "\t-S [PGNAME]\t[$PGNAME]\t\t\tPostgreSQL database name"
    echo -e "\t-U [PGUSER]\t[$PGUSER]\t\t\t\tPostgreSQL database user name"
    echo -e "\t-W [PGPASSWORD]\t[$PGPASSWORD]\t\t\tPostgreSQL database password"
    echo -e "\t-R [Region]\t[$AWS_REGION]\t\t\tThe region in which to create the lab"
    echo -e "\t-F [Profile]\t[$AWS_PROFILE]\t\t\t\tThe profile to use for creating the RDS Instance"
    echo -e "\n"
    exit
}

while getopts $OPTIONS option
do
    case "$option" in
    h)  ORCLHOST=${OPTARG}
        ;;
    p)  ORCLPORT=${OPTARG}
        ;;
    s)  ORCLNAME=${OPTARG}
        ;;
    u)  ORCLUSER=${OPTARG}
        ;;
    w)  ORCLPASSWD=${OPTARG}
        ;;
    d)  REPLICATION_ARN=${OPTARG}
        ;;
    H)  PGHOST=${OPTARG}
        ;;
    P)  PGPORT=${OPTARG}
        ;;
    S)  PGNAME=${OPTARG}
        ;;
    U)  PGUSER=${OPTARG}
        ;;
    W)  PGPASSWORD=${OPTARG}
        ;;
    R)  AWS_REGION=${OPTARG}
        ;;
    F)  AWS_PROFILE=${OPTARG}
        ;;
    ?)  usage
        ;;
    esac
done

echo -e "Removing DMS Replication Task `date`\n"
getDmsReplicationTaskArn
stopDmsReplicationTask   "$REPLICATION_TASK_ARN"
aws dms wait replication-task-stopped --filters "Name=replication-task-arn,Values=$REPLICATION_TASK_ARN" --region $AWS_REGION --profile $AWS_PROFILE 2>>/dev/null

deleteDmsReplicationTask "$REPLICATION_TASK_ARN"
aws dms wait replication-task-deleted --filters "Name=replication-task-arn,Values=$REPLICATION_TASK_ARN" --region $AWS_REGION --profile $AWS_PROFILE 2>>/dev/null

getDmsEndPointArn "$ORCLSOURCE"
deleteDmsEndPoint "$ENDPOINT_ARN"
getDmsEndPointArn "$PGDEST"
deleteDmsEndPoint "$ENDPOINT_ARN"

echo -e "Removing Database objects `date`\n"
sqlplus -s $ORCLUSER/$ORCLPASSWD@//$ORCLHOST:$ORCLPORT/$ORCLNAME <<< "DROP USER snap_test CASCADE;"    >>/dev/null
psql -h $PGHOST -p $PGPORT -U $PGUSER -d $PGNAME -q -c "DROP SCHEMA snap_test CASCADE;"               2>>/dev/null
psql -h $PGHOST -p $PGPORT -U $PGUSER -d $PGNAME -q -c "TRUNCATE TABLE mike.awsdms_apply_exceptions;" 2>>/dev/null

echo -e "Waiting for removal to complete `date`\n"
aws dms wait endpoint-deleted --filters "Name=endpoint-arn,Values=$ENDPOINT_ARN" --region $AWS_REGION --profile $AWS_PROFILE 2>>/dev/null

echo -e "Removal completed `date`\n"
