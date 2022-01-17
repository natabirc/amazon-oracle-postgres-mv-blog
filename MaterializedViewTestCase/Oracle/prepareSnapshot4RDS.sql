/* ---------------------------------------------------------------------------------------------------------------------------------
Routine Name: prepareMikeSnapshot.sql
Author:       Mike Revitt
Date:         10/05/2021
------------------------------------------------------------------------------------------------------------------------------------
Revision History    Push Down List
------------------------------------------------------------------------------------------------------------------------------------
Date        | Name          | Description
------------+---------------+-------------------------------------------------------------------------------------------------------
            |               |
10/12/2021  | M Revitt      | Initial version
------------+---------------+-------------------------------------------------------------------------------------------------------

************************************************************************************************************************************
Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files
(the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify,
merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is
furnished to do so.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
***********************************************************************************************************************************/

-- sqlplus $ORCLUSER/$ORCLPASSWD@//$ORCLHOST:$ORCLPORT/$ORCLNAME AS SYSDBA @prepareMikeSnapshot.sql

SET     TERMOUT   OFF;

exec rdsadmin.rdsadmin_util.alter_supplemental_logging('DROP','ALL');
exec rdsadmin.rdsadmin_util.alter_supplemental_logging('DROP','PRIMARY KEY');
exec rdsadmin.rdsadmin_util.alter_supplemental_logging('DROP','UNIQUE');

ALTER TABLE snap_test.edge_case_view          DROP  SUPPLEMENTAL LOG DATA (PRIMARY KEY) COLUMNS;
ALTER TABLE snap_test.edge_case_pk_view       DROP  SUPPLEMENTAL LOG DATA (PRIMARY KEY) COLUMNS;
ALTER TABLE snap_test.edge_case_all_cols_view DROP  SUPPLEMENTAL LOG DATA (ALL)         COLUMNS;
ALTER TABLE snap_test.edge_case_pk_view       DROP  SUPPLEMENTAL LOG DATA (ALL)         COLUMNS;

exec rdsadmin.rdsadmin_util.alter_supplemental_logging(p_action => 'ADD');
/*exec rdsadmin.rdsadmin_util.alter_supplemental_logging('ADD','PRIMARY KEY');*/
/*exec rdsadmin.rdsadmin_util.alter_supplemental_logging('ADD','ALL');*/
/*exec rdsadmin.rdsadmin_util.alter_supplemental_logging('ADD','UNIQUE');*/

ALTER TABLE snap_test.edge_case_view          ADD   SUPPLEMENTAL LOG DATA (PRIMARY KEY) COLUMNS;
/*ALTER TABLE snap_test.edge_case_pk_view       ADD   SUPPLEMENTAL LOG DATA (PRIMARY KEY) COLUMNS;*/
ALTER TABLE snap_test.edge_case_all_cols_view ADD   SUPPLEMENTAL LOG DATA (ALL) COLUMNS;
ALTER TABLE snap_test.edge_case_pk_view       ADD   SUPPLEMENTAL LOG DATA (ALL) COLUMNS;

exec rdsadmin.rdsadmin_util.set_configuration('archivelog retention hours',24);

SET     LINESIZE        132
COLUMN  log_group_name  HEADING 'Log Group'                         FORMAT A20
COLUMN  table_name      HEADING 'Table'                             FORMAT A25
COLUMN  always          HEADING 'Conditional or|Unconditional'      FORMAT A14
COLUMN  log_group_type  HEADING 'Type of Log Group'                 FORMAT A20
COLUMN  log_min         HEADING 'Minimum|Supplemental|Logging?'     FORMAT A12
COLUMN  log_pk          HEADING 'Primary Key|Supplemental|Logging?' FORMAT A12
COLUMN  log_fk          HEADING 'Foreign Key|Supplemental|Logging?' FORMAT A12
COLUMN  log_ui          HEADING 'Unique|Supplemental|Logging?'      FORMAT A12
COLUMN  log_all         HEADING 'All Columns|Supplemental|Logging?' FORMAT A12

SELECT
        log_group_name,
        table_name,
        DECODE(ALWAYS,'ALWAYS', 'Unconditional','CONDITIONAL', 'Conditional') always,
        log_group_type
FROM
        dba_log_groups;

SELECT
        supplemental_log_data_min log_min,
        supplemental_log_data_pk log_pk,
        supplemental_log_data_fk log_fk,
        supplemental_log_data_ui log_ui,
        supplemental_log_data_all log_all
FROM
        v$database;

EXIT;
