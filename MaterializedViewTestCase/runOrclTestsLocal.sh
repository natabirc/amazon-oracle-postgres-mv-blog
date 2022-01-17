#! /bin/bash +ex
#-----------------------------------------------------------------------------------------------------------------------------------
# Routine Name: runOrcltestsLocal.sh
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

OPTIONS="h:p:s:u:w:d:H:P:S:U:W:D:e:t:E:T:R:F:"

AWS_PROFILE="default"
AWS_REGION="eu-west-1"
DEBUG='N'
DMSTASKID='postgres-mv-load-and-sync'
EPORCLHOST='mvblog.crlotjrmovmg.us-east-2.rds.amazonaws.com'
EPORCLPORT='1521'
EPPGHOST='mvblogpg.c06yrdvam2nb.eu-west-1.rds.amazonaws.com'
EPPGPORT='5432'
PGDEST="postgres-mv-destination"
PGHOST='mvblogpg.c06yrdvam2nb.eu-west-1.rds.amazonaws.com'
PGNAME='postgres'
PGPASSWORD='aws-oracle'
PGPORT='5432'
PGUSER='mike'
PROGRAM_NAME="`basename $0`"
ORCLHOST='mvblog.crlotjrmovmg.us-east-2.rds.amazonaws.com'
ORCLNAME='XEPDB1'
ORCLPASSWD='aws-oracle'
ORCLPORT='1521'
ORCLSOURCE="oracle-mv-source"
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
getDmsReplicationTaskArn()
{
  REPLICATION_TASK_ARN=`aws dms describe-replication-tasks      \
      --filters   "Name=replication-task-id,Values=$DMSTASKID"  \
      --query     "ReplicationTasks[0].ReplicationTaskArn"      \
      --output     text                                         \
      --region    "$AWS_REGION"                                 \
      --profile   "$AWS_PROFILE" 2>>/dev/null`
}
getDmsReplicationTaskStatus()
{
  REPLICATION_TASK_STATUS=`aws dms describe-replication-tasks           \
      --filters     "Name=replication-task-arn,Values=$REPLICATION_ARN" \
      --query       "ReplicationTasks[0].Status"                        \
      --output       text                                               \
      --region      "$AWS_REGION"                                       \
      --profile     "$AWS_PROFILE" 2>>/dev/null`
}
getDmsReplicationInstanceArn()
{
  REPLICATION_ARN=`aws dms describe-replication-instances             \
      --query       "ReplicationInstances[0].ReplicationInstanceArn"  \
      --output       text                                             \
      --region      "$AWS_REGION"                                     \
      --profile     "$AWS_PROFILE" 2>>/dev/null`
}
usage()
{
    echo -e "\nUsage: $PROGRAM_NAME -h [ORCLHOST]   -p [ORCLPORT]   -s [ORCLNAME] -u [ORCLUSER] -w [ORCLPASSWD]  -d [DMSTASK]"
    echo -e "\t\t\t    -H [PGHOST]     -P [PGPORT]     -s [PGNAME]   -U [PGUSER]   -W [PGPASSWORD]  -D [DEBUG]"
    echo -e "\t\t\t    -e [EPORCLHOST] -t [EPORCLPORT] -E [EPPGHOST] -T [EPPGPORT]"
    echo -e "\t\t\t    -R [Region]     -F [Profile]\n"
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
    echo -e "\t-D [DEBUG]\t[$DEBUG]\t\t\t\tTurn on Debug"
    echo -e "\t-e [EPORCLHOST]\t[$EPORCLHOST]\t\t\tThe Oracle DB DMS Endpoint address"
    echo -e "\t-t [EPORCLPORT]\t[$EPORCLPORT]\t\t\t\tThe Oracle DB DMS Endpoint port"
    echo -e "\t-E [EPPGHOST]\t[$EPPGHOST]\tThe PostgreSQL DB DMS Endpoint address"
    echo -e "\t-T [EPPGPORT]\t[$EPPGPORT]\t\t\t\tThe PostgreSQL DB DMS Endpoint port"
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
    D)  DEBUG=${OPTARG}
        ;;
    e)  EPORCLHOST=${OPTARG}
        ;;
    t)  EPORCLPORT=${OPTARG}
        ;;
    E)  EPPGHOST=${OPTARG}
        ;;
    T)  EPPGPORT=${OPTARG}
        ;;
    R)  AWS_REGION=${OPTARG}
        ;;
    F)  AWS_PROFILE=${OPTARG}
        ;;
    ?)  usage
        ;;
    esac
done

getDmsReplicationInstanceArn
if [ -z "$REPLICATION_ARN" ]
then
  echo -e "\nYou must have an exising DMS Replication Instance running prior to running this process"
  usage
  exit 2
fi

echo -e "\nCreating DMS Replication Task `date`\n"
getDmsEndPointArn "$ORCLSOURCE"
ORACLE_ARN="$ENDPOINT_ARN"

getDmsEndPointArn "$PGDEST"
POSTGRES_ARN="$ENDPOINT_ARN"

if [ -z "$ORACLE_ARN" ]
then
  ORACLE_ARN=`aws dms create-endpoint         \
      --endpoint-identifier "$ORCLSOURCE"     \
      --endpoint-type         source          \
      --engine-name           oracle          \
      --server-name         "$EPORCLHOST"     \
      --port                "$EPORCLPORT"     \
      --database-name       "$ORCLNAME"       \
      --username            "$ORCLUSER"       \
      --password            "$ORCLPASSWD"     \
      --region              "$AWS_REGION"     \
      --profile             "$AWS_PROFILE"`
fi

if [ -z "$POSTGRES_ARN" ]
then
  POSTGRES_ARN=`aws dms create-endpoint       \
      --endpoint-identifier "$PGDEST"         \
      --endpoint-type         target          \
      --engine-name           postgres        \
      --server-name         "$EPPGHOST"       \
      --port                "$EPPGPORT"       \
      --database-name       "$PGNAME"         \
      --username            "$PGUSER"         \
      --password            "$PGPASSWORD"     \
      --region              "$AWS_REGION"     \
      --profile             "$AWS_PROFILE"`
fi

getDmsEndPointArn "$ORCLSOURCE"
ORACLE_ARN="$ENDPOINT_ARN"

getDmsEndPointArn "$PGDEST"
POSTGRES_ARN="$ENDPOINT_ARN"

getDmsReplicationTaskArn
if [ -n "$REPLICATION_TASK_ARN" ]
then
  REPLICATION_TASK=`aws dms stop-replication-task       \
      --replication-task-arn    "$REPLICATION_TASK_ARN" \
      --region                  "$AWS_REGION"           \
      --profile                 "$AWS_PROFILE" 2>>/dev/null`

  aws dms wait replication-task-stopped --filters "Name=replication-task-arn,Values=$REPLICATION_TASK_ARN" --region $AWS_REGION --profile $AWS_PROFILE 2>>/dev/null

  REPLICATION_TASK=`aws dms delete-replication-task     \
      --replication-task-arn    "$REPLICATION_TASK_ARN" \
      --region                  "$AWS_REGION"           \
      --profile                 "$AWS_PROFILE"`

  aws dms wait replication-task-deleted --filters "Name=replication-task-arn,Values=$REPLICATION_TASK_ARN" --region $AWS_REGION --profile $AWS_PROFILE 2>>/dev/null
fi

REPLICATION_TASK=`aws dms create-replication-task                                 \
    --replication-task-identifier   "$DMSTASKID"                                  \
    --source-endpoint-arn           "$ORACLE_ARN"                                 \
    --target-endpoint-arn           "$POSTGRES_ARN"                               \
    --replication-instance-arn      "$REPLICATION_ARN"                            \
    --migration-type                  full-load-and-cdc                           \
    --table-mappings                  file://DMS/createDmsTaskTableMappings.json  \
    --replication-task-settings       file://DMS/createDmsTaskSettings.json       \
    --region                        "$AWS_REGION"                                 \
    --profile                       "$AWS_PROFILE"`

getDmsReplicationTaskArn
aws dms wait replication-task-ready --filters "Name=replication-task-arn,Values=$REPLICATION_TASK_ARN" --region $AWS_REGION --profile $AWS_PROFILE 2>>/dev/null

echo -e "DMS Replication task is ready. The ARN of the task is $REPLICATION_TASK_ARN which was created on `date`\n" 

echo -e "Building Test Environment in Oracle `date`\n"
sqlplus -s $ORCLUSER/$ORCLPASSWD@//$ORCLHOST:$ORCLPORT/$ORCLNAME @Oracle/createUsersORCL.sql "$ORCLPASSWD"  >>/dev/null
sqlplus -s $ORCLUSER/$ORCLPASSWD@//$ORCLHOST:$ORCLPORT/$ORCLNAME @Oracle/generateEdgeCase.sql               >>/dev/null

echo -e "Building Test Environment in Postgres `date`\n"
psql -h $PGHOST -p $PGPORT -U $PGUSER -d $PGNAME -q -f  Postgres/createTablesPostgreSQL.sql                 >>/dev/null
psql -h $PGHOST -p $PGPORT -U $PGUSER -d $PGNAME -q -c "TRUNCATE TABLE mike.awsdms_apply_exceptions;"       >>/dev/null

echo -e "\nSet Supplemental Logging in Oracle `date`\n"

sqlplus -s $ORCLUSER/$ORCLPASSWD@//$ORCLHOST:$ORCLPORT/$ORCLNAME @Oracle/prepareSnapshot4RDS.sql

echo -e "\nStarting DMS Replication `date`\n"

aws dms start-replication-task --replication-task-arn $REPLICATION_TASK_ARN --start-replication-task-type start-replication --region $AWS_REGION --profile $AWS_PROFILE >> /dev/null
aws dms wait replication-task-running --filters "Name=replication-task-arn,Values=$REPLICATION_TASK_ARN" --region $AWS_REGION --profile $AWS_PROFILE
sleep 5

echo -e "View Test Data in Oracle `date`\n"

sqlplus -s $ORCLUSER/$ORCLPASSWD@//$ORCLHOST:$ORCLPORT/$ORCLNAME <<< "SET LINESIZE 125
SET PAGESIZE 64
COLUMN T3_NAME FORMAT A15
COLUMN T7_NAME FORMAT A15
PROMPT Oracle Simple Materialized View with Primary Key snap_test.edge_case_view
SELECT t1_key, t2_key, t3_key, t4_key, t5_key, t6_key, t7_key, t8_key, t9_key, TO_CHAR(t10_order_date,'YYYY-MM-DD HH24:MI:SS') t10_order_date FROM snap_test.edge_case_view WHERE t10_key=7;
PROMPT Oracle Complex Materialized View with Unique Key snap_test.edge_case_all_cols_view
SELECT t1_id, t1_updated, t3_name, t7_name, t10_id, TO_CHAR(t10_order_date,'YYYY-MM-DD HH24:MI:SS') t10_order_date FROM snap_test.edge_case_all_cols_view WHERE t10_id=7;
PROMPT Oracle Complex Materialized View with Primary Key snap_test.edge_case_pk_view
SELECT t1_id, t1_updated, t3_name, t7_name, t10_id, TO_CHAR(t10_order_date,'YYYY-MM-DD HH24:MI:SS') t10_order_date FROM snap_test.edge_case_pk_view WHERE t10_id=7;"

echo -e "View Test Data in PostgreSQL\n"
echo -e "PostgreSQL Simple Materialized View with Primary Key"
psql -h $PGHOST -p $PGPORT -U $PGUSER -d $PGNAME -q -c "SELECT t1_key, t2_key, t3_key, t4_key, t5_key, t6_key, t7_key, t8_key, t9_key, t10_order_date FROM snap_test.edge_case_view WHERE t10_key=7;"
echo -e "PostgreSQL Complex Materialized View with Index Only"
psql -h $PGHOST -p $PGPORT -U $PGUSER -d $PGNAME -q -c "SELECT t1_id, t1_updated, t3_name, t7_name, t10_id, t10_order_date FROM snap_test.edge_case_all_cols_view  WHERE t10_id=7;"
echo -e "PostgreSQL Complex Materialized View with Primary Key"
psql -h $PGHOST -p $PGPORT -U $PGUSER -d $PGNAME -q -c "SELECT t1_id, t1_updated, t3_name, t7_name, t10_id, t10_order_date FROM snap_test.edge_case_pk_view        WHERE t10_id=7;"

echo -e "Update Oracle rows, refresh Materialized Views, then view data in Oracle and PostgreSQL `date`\n"

sqlplus -s $ORCLUSER/$ORCLPASSWD@//$ORCLHOST:$ORCLPORT/$ORCLNAME <<< "SET LINESIZE 125
SET PAGESIZE 64
COLUMN T3_NAME FORMAT A15
COLUMN T7_NAME FORMAT A15
UPDATE  snap_test.edge_case_key10 SET order_date = '01-Jan-21' WHERE id=7;
COMMIT;
EXECUTE DBMS_MVIEW.REFRESH('snap_test.edge_case_view',          'F');
EXECUTE DBMS_MVIEW.REFRESH('snap_test.edge_case_pk_view',       'F');
EXECUTE DBMS_MVIEW.REFRESH('snap_test.edge_case_all_cols_view', 'F');
EXECUTE DBMS_LOCK.SLEEP(5);
PROMPT Oracle Simple Materialized View with Primary Key
SELECT t1_key, t2_key, t3_key, t4_key, t5_key, t6_key, t7_key, t8_key, t9_key, TO_CHAR(t10_order_date,'YYYY-MM-DD HH24:MI:SS') t10_order_date FROM snap_test.edge_case_view WHERE t10_key=7;
PROMPT Oracle Complex Materialized View with Unique Key
SELECT t1_id, t1_updated, t3_name, t7_name, t10_id, TO_CHAR(t10_order_date,'YYYY-MM-DD HH24:MI:SS') t10_order_date FROM snap_test.edge_case_all_cols_view WHERE t10_id=7;
PROMPT Oracle Complex Materialized View with Primary Key
SELECT t1_id, t1_updated, t3_name, t7_name, t10_id, TO_CHAR(t10_order_date,'YYYY-MM-DD HH24:MI:SS') t10_order_date FROM snap_test.edge_case_pk_view WHERE t10_id=7;
EXECUTE DBMS_LOCK.SLEEP(10);"

echo -e "View Test Data in PostgreSQL `date`\n"
echo -e "PostgreSQL Simple Materialized View with Primary Key"
psql -h $PGHOST -p $PGPORT -U $PGUSER -d $PGNAME -q -c "SELECT t1_key, t2_key, t3_key, t4_key, t5_key, t6_key, t7_key, t8_key, t9_key, t10_order_date FROM snap_test.edge_case_view WHERE t10_key=7;"
echo -e "PostgreSQL Complex Materialized View with Index Only"
psql -h $PGHOST -p $PGPORT -U $PGUSER -d $PGNAME -q -c "SELECT t1_id, t1_updated, t3_name, t7_name, t10_id, t10_order_date FROM snap_test.edge_case_all_cols_view  WHERE t10_id=7;"
echo -e "PostgreSQL Complex Materialized View with Primary Key"
psql -h $PGHOST -p $PGPORT -U $PGUSER -d $PGNAME -q -c "SELECT t1_id, t1_updated, t3_name, t7_name, t10_id, t10_order_date FROM snap_test.edge_case_pk_view        WHERE t10_id=7;"
echo -e "PostgreSQL Check Refresh Errors"
psql -h $PGHOST -p $PGPORT -U $PGUSER -d $PGNAME -q -c 'SELECT LEFT("ERROR", 130) FROM mike.awsdms_apply_exceptions;'
psql -h $PGHOST -p $PGPORT -U $PGUSER -d $PGNAME -q -c "TRUNCATE TABLE mike.awsdms_apply_exceptions;"

echo -e "Replace PostgreSQL PK with an index and then try again `date`\n"

psql -h $PGHOST -p $PGPORT -U $PGUSER -d $PGNAME -c "ALTER TABLE snap_test.edge_case_pk_view DROP CONSTRAINT edge_case_pk_view_pkey;"
psql -h $PGHOST -p $PGPORT -U $PGUSER -d $PGNAME -c "CREATE INDEX edge_case_pk_view_ind1 ON snap_test.edge_case_pk_view(t1_id);"

sqlplus -s $ORCLUSER/$ORCLPASSWD@//$ORCLHOST:$ORCLPORT/$ORCLNAME <<< "SET LINESIZE 125
EXECUTE DBMS_MVIEW.REFRESH('snap_test.edge_case_pk_view', 'C');
EXECUTE DBMS_LOCK.SLEEP(10);
EXIT"

if [ $DEBUG == "Y" ]
then
  psql -h $PGHOST -p $PGPORT -U $PGUSER -d $PGNAME -f Postgres/debugEdgeCase.sql  1>>/dev/null 2>>/dev/null
fi

sqlplus -s $ORCLUSER/$ORCLPASSWD@//$ORCLHOST:$ORCLPORT/$ORCLNAME <<< "SET LINESIZE 125
SET PAGESIZE 64
COLUMN T3_NAME FORMAT A15
COLUMN T7_NAME FORMAT A15
UPDATE  snap_test.edge_case_key10 SET order_date = '02-Jan-21' WHERE id=7;
COMMIT;
EXECUTE DBMS_MVIEW.REFRESH('snap_test.edge_case_view',          'F');
EXECUTE DBMS_MVIEW.REFRESH('snap_test.edge_case_pk_view',       'F');
EXECUTE DBMS_MVIEW.REFRESH('snap_test.edge_case_all_cols_view', 'F');
EXECUTE DBMS_LOCK.SLEEP(5);
PROMPT Oracle Simple Materialized View with Primary Key
SELECT t1_key, t2_key, t3_key, t4_key, t5_key, t6_key, t7_key, t8_key, t9_key, TO_CHAR(t10_order_date,'YYYY-MM-DD HH24:MI:SS') t10_order_date FROM snap_test.edge_case_view WHERE t10_key=7;
PROMPT Oracle Complex Materialized View with Unique Key
SELECT t1_id, t1_updated, t3_name, t7_name, t10_id, TO_CHAR(t10_order_date,'YYYY-MM-DD HH24:MI:SS') t10_order_date FROM snap_test.edge_case_all_cols_view WHERE t10_id=7;
PROMPT Oracle Complex Materialized View with Primary Key
SELECT t1_id, t1_updated, t3_name, t7_name, t10_id, TO_CHAR(t10_order_date,'YYYY-MM-DD HH24:MI:SS') t10_order_date FROM snap_test.edge_case_pk_view WHERE t10_id=7;
EXECUTE DBMS_LOCK.SLEEP(10);"

echo -e "View Test Data in PostgreSQL\n"
echo -e "PostgreSQL Simple Materialized View with Primary Key edge_case_view"
psql -h $PGHOST -p $PGPORT -U $PGUSER -d $PGNAME -q -c "SELECT t1_key, t2_key, t3_key, t4_key, t5_key, t6_key, t7_key, t8_key, t9_key, t10_order_date FROM snap_test.edge_case_view WHERE t10_key=7;"
echo -e "PostgreSQL Complex Materialized View with Index Only edge_case_all_cols_view"
psql -h $PGHOST -p $PGPORT -U $PGUSER -d $PGNAME -q -c "SELECT t1_id, t1_updated, t3_name, t7_name, t10_id, t10_order_date FROM snap_test.edge_case_all_cols_view  WHERE t10_id=7;"
echo -e "PostgreSQL Complex Materialized View with Primary Key edge_case_pk_view"
psql -h $PGHOST -p $PGPORT -U $PGUSER -d $PGNAME -q -c "SELECT t1_id, t1_updated, t3_name, t7_name, t10_id, t10_order_date FROM snap_test.edge_case_pk_view        WHERE t10_id=7;"
echo -e "PostgreSQL Check Refresh Errors"
psql -h $PGHOST -p $PGPORT -U $PGUSER -d $PGNAME -q -c 'SELECT LEFT("ERROR", 130) FROM mike.awsdms_apply_exceptions;'

exit

select * from mike.awsdms_apply_exceptions;
select * from mike.awsdms_history;
select * from mike.awsdms_status;
select * from mike.awsdms_suspended_tables;
