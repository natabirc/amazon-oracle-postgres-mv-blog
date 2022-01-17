/* ---------------------------------------------------------------------------------------------------------------------------------
Routine Name: CreateMikeSnapshotDD.sql
Author:       Mike Revitt
Date:         12/11/2018
------------------------------------------------------------------------------------------------------------------------------------
Revision History    Push Down List
------------------------------------------------------------------------------------------------------------------------------------
Date        | Name          | Description
------------+---------------+-------------------------------------------------------------------------------------------------------
            |               |
12/11/2018  | M Revitt      | Initial version
------------+---------------+-------------------------------------------------------------------------------------------------------
Background:     PostGre does not support Materialized View Fast Refreshes, this suite of scripts is a PL/SQL coded mechanism to
                provide that functionality, the next phase of this projecdt is to fold these changes into the PostGre kernel.

Description:    This script creates the SCHEMA and USER to hold the Materialized View Fast Refresh code along with the necessary
                data dictionary views, then it calls the create function scripts in the correct order

Notes:          There are 2 data dictionary tables
                o   mike$_pgiew_logs
                o   mike$_pgiews

                Access is controlled via 3 database roles
                o   mike_execute   -   is given the privileges to run the public materialized view functions
                o   mike_usage     -   is given usage on the mike_pgiew schema
                o   mike_view      -   is given access to the DDL tables

Issues:         There is a bug in RDS for PostGres version 10.4 that prevents this code from working, this but is fixed in
                versions 10.5 and 10.3

                https://forums.aws.amazon.com/thread.jspa?messageID=860564

************************************************************************************************************************************
Copyright 2018 Amazon.com, Inc. or its affiliates. All Rights Reserved.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files
(the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify,
merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is
furnished to do so.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
***********************************************************************************************************************************/

-- sqlplus $ORACLE_USER/$PGPASSWORD@$ORACLE_TNS_NAMES @createUsersORCL.sql "$ORCLPASSWD"

SET	FEEDBACK  OFF
SET TERMOUT   OFF;
SET VERIFY    OFF

DROP  USER  snap_test CASCADE;

SET TERMOUT ON;

CREATE  USER      snap_test IDENTIFIED BY "&1" QUOTA   UNLIMITED ON users;

GRANT   CREATE  SESSION,
        CREATE  TABLE,
        CREATE  SEQUENCE,
        CREATE  VIEW,
        SELECT  ANY TABLE
TO      snap_test;

EXIT;
