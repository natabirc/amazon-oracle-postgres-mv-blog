/* ---------------------------------------------------------------------------------------------------------------------------------
Routine Name: debugEdgeCase.sql
Author:       Mike Revitt
Date:         07/05/2021
------------------------------------------------------------------------------------------------------------------------------------
Revision History    Push Down List
------------------------------------------------------------------------------------------------------------------------------------
Date        | Name          | Description
------------+---------------+-------------------------------------------------------------------------------------------------------
            |               |
07/05/2020  | M Revitt      | Initial version
------------+---------------+-------------------------------------------------------------------------------------------------------

************************************************************************************************************************************
Copyright 2020 Amazon.com, Inc. or its affiliates. All Rights Reserved.
Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files
(the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify,
merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is
furnished to do so.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
***********************************************************************************************************************************/

-- sqlplus $ORCLUSER/$ORCLPASSWD@//$ORCLHOST:$ORCLPORT/$ORCLNAME @debugEdgeCase.sql
SET   client_min_messages TO ERROR;

--\o /dev/null

DROP  TRIGGER     edge_case_debug_pk_insert   ON  snap_test.edge_case_pk_view;
DROP  TRIGGER     edge_case_debug_pk_update   ON  snap_test.edge_case_pk_view;
DROP  TRIGGER     edge_case_debug_pk_delete   ON  snap_test.edge_case_pk_view;
DROP  TRIGGER     edge_case_debug_all_insert  ON  snap_test.edge_case_all_cols_view;
DROP  TRIGGER     edge_case_debug_all_update  ON  snap_test.edge_case_all_cols_view;
DROP  TRIGGER     edge_case_debug_all_delete  ON  snap_test.edge_case_all_cols_view;

DROP  FUNCTION    snap_test.edge_case_debug_func;
DROP  TABLE       snap_test.edge_case_debug;

\set  ON_ERROR_STOP 1

CREATE TABLE snap_test.edge_case_debug(
  id              SERIAL    NOT NULL  PRIMARY KEY,
  snap_id         INTEGER   NOT NULL,
  dml_type        TEXT      NOT NULL,
  created         TIMESTAMP NOT NULL  DEFAULT clock_timestamp()
);

CREATE  OR  REPLACE
FUNCTION    snap_test.edge_case_debug_func()
    RETURNS TRIGGER
AS
$TRIG$
DECLARE
  l_id  INTEGER;
BEGIN
  IF TG_OP = 'DELETE'
  THEN
    l_id := OLD.t10_id;
  ELSE
    l_id := NEW.t10_id;
  END IF;

  INSERT
  INTO    snap_test.edge_case_debug( snap_id, dml_type )
  VALUES( l_id, TG_OP );

  RETURN  NULL;

  EXCEPTION
  WHEN OTHERS
  THEN
    RAISE INFO      'Exception in function snap_test.edge_case_debug_func';
    RAISE INFO      'Error %:- %:',     SQLSTATE, SQLERRM;
    RAISE EXCEPTION '%',                SQLSTATE;

END;
$TRIG$
LANGUAGE  plpgsql;

CREATE  TRIGGER edge_case_debug_pk_insert
    AFTER   INSERT  ON  snap_test.edge_case_pk_view
    FOR     EACH    ROW
    EXECUTE PROCEDURE   snap_test.edge_case_debug_func();

CREATE  TRIGGER edge_case_debug_pk_update
    AFTER   UPDATE  ON  snap_test.edge_case_pk_view
    FOR     EACH    ROW
    EXECUTE PROCEDURE   snap_test.edge_case_debug_func();

CREATE  TRIGGER edge_case_debug_pk_delete
    AFTER   DELETE  ON  snap_test.edge_case_pk_view
    FOR     EACH    ROW
    EXECUTE PROCEDURE   snap_test.edge_case_debug_func();

CREATE  TRIGGER edge_case_debug_all_insert
    AFTER   INSERT  ON  snap_test.edge_case_all_cols_view
    FOR     EACH    ROW
    EXECUTE PROCEDURE   snap_test.edge_case_debug_func();

CREATE  TRIGGER edge_case_debug_all_update
    AFTER   UPDATE  ON  snap_test.edge_case_all_cols_view
    FOR     EACH    ROW
    EXECUTE PROCEDURE   snap_test.edge_case_debug_func();

CREATE  TRIGGER edge_case_debug_all_delete
    AFTER   DELETE  ON  snap_test.edge_case_all_cols_view
    FOR     EACH    ROW
    EXECUTE PROCEDURE   snap_test.edge_case_debug_func();

SELECT snap_id, dml_type, created FROM snap_test.edge_case_debug WHERE snap_id=7 ORDER BY id;

\q
