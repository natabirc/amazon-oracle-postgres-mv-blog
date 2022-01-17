/* ---------------------------------------------------------------------------------------------------------------------------------
Routine Name: generateEdgeCase.sql
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

-- sqlplus $ORCLUSER/$ORCLPASSWD@//$ORCLHOST:$ORCLPORT/$ORCLNAME @generateTestDataOrcl.sql "$PARENT_RECORDS_TO_CREATE"

SET SERVEROUTPUT ON SIZE UNLIMITED
SET TERMOUT OFF

DROP  MATERIALIZED  VIEW          snap_test.edge_case_view;
DROP  MATERIALIZED  VIEW          snap_test.edge_case_pk_view;
DROP  MATERIALIZED  VIEW          snap_test.edge_case_all_cols_view;
DROP  MATERIALIZED  VIEW  LOG ON  snap_test.edge_case;
DROP  MATERIALIZED  VIEW  LOG ON  snap_test.edge_case_key1;
DROP  MATERIALIZED  VIEW  LOG ON  snap_test.edge_case_key2;
DROP  MATERIALIZED  VIEW  LOG ON  snap_test.edge_case_key3;
DROP  MATERIALIZED  VIEW  LOG ON  snap_test.edge_case_key4;
DROP  MATERIALIZED  VIEW  LOG ON  snap_test.edge_case_key5;
DROP  MATERIALIZED  VIEW  LOG ON  snap_test.edge_case_key6;
DROP  MATERIALIZED  VIEW  LOG ON  snap_test.edge_case_key7;
DROP  MATERIALIZED  VIEW  LOG ON  snap_test.edge_case_key8;
DROP  MATERIALIZED  VIEW  LOG ON  snap_test.edge_case_key9;
DROP  MATERIALIZED  VIEW  LOG ON  snap_test.edge_case_key10;
DROP  MATERIALIZED  VIEW  LOG ON  snap_test.edge_case_key11;
DROP  MATERIALIZED  VIEW  LOG ON  snap_test.edge_case_key12;

DROP  TRIGGER     TRIGGER snap_test.edge_case_pre;
DROP  TRIGGER     TRIGGER snap_test.edge_case_key1_pre;
DROP  TRIGGER     TRIGGER snap_test.edge_case_key2_pre;
DROP  TRIGGER     TRIGGER snap_test.edge_case_key3_pre;
DROP  TRIGGER     TRIGGER snap_test.edge_case_key4_pre;
DROP  TRIGGER     TRIGGER snap_test.edge_case_key5_pre;
DROP  TRIGGER     TRIGGER snap_test.edge_case_key6_pre;
DROP  TRIGGER     TRIGGER snap_test.edge_case_key7_pre;
DROP  TRIGGER     TRIGGER snap_test.edge_case_key8_pre;
DROP  TRIGGER     TRIGGER snap_test.edge_case_key9_pre;
DROP  TRIGGER     TRIGGER snap_test.edge_case_key10_pre;
DROP  TRIGGER     TRIGGER snap_test.edge_case_key11_pre;
DROP  TRIGGER     TRIGGER snap_test.edge_case_key12_pre;

DROP  TABLE       snap_test.edge_case;
DROP  TABLE       snap_test.edge_case_key1;
DROP  TABLE       snap_test.edge_case_key2;
DROP  TABLE       snap_test.edge_case_key3;
DROP  TABLE       snap_test.edge_case_key4;
DROP  TABLE       snap_test.edge_case_key5;
DROP  TABLE       snap_test.edge_case_key6;
DROP  TABLE       snap_test.edge_case_key7;
DROP  TABLE       snap_test.edge_case_key8;
DROP  TABLE       snap_test.edge_case_key9;
DROP  TABLE       snap_test.edge_case_key10;
DROP  TABLE       snap_test.edge_case_key11;
DROP  TABLE       snap_test.edge_case_key12;

DROP  SEQUENCE    snap_test.edge_case_seq;
DROP  SEQUENCE    snap_test.edge_key1_seq;
DROP  SEQUENCE    snap_test.edge_key2_seq;
DROP  SEQUENCE    snap_test.edge_key3_seq;
DROP  SEQUENCE    snap_test.edge_key4_seq;
DROP  SEQUENCE    snap_test.edge_key5_seq;
DROP  SEQUENCE    snap_test.edge_key6_seq;
DROP  SEQUENCE    snap_test.edge_key7_seq;
DROP  SEQUENCE    snap_test.edge_key8_seq;
DROP  SEQUENCE    snap_test.edge_key9_seq;
DROP  SEQUENCE    snap_test.edge_key10_seq;
DROP  SEQUENCE    snap_test.edge_key11_seq;
DROP  SEQUENCE    snap_test.edge_key12_seq;

CREATE  SEQUENCE  snap_test.edge_case_seq;

CREATE  SEQUENCE  snap_test.edge_key1_seq;
CREATE  SEQUENCE  snap_test.edge_key2_seq;
CREATE  SEQUENCE  snap_test.edge_key3_seq;
CREATE  SEQUENCE  snap_test.edge_key4_seq;
CREATE  SEQUENCE  snap_test.edge_key5_seq;
CREATE  SEQUENCE  snap_test.edge_key6_seq;
CREATE  SEQUENCE  snap_test.edge_key7_seq;
CREATE  SEQUENCE  snap_test.edge_key8_seq;
CREATE  SEQUENCE  snap_test.edge_key9_seq;
CREATE  SEQUENCE  snap_test.edge_key10_seq;
CREATE  SEQUENCE  snap_test.edge_key11_seq;
CREATE  SEQUENCE  snap_test.edge_key12_seq;

CREATE
TABLE   snap_test.edge_case_key1
(
  id              INTEGER                             NOT NULL  PRIMARY KEY,
  key1            INTEGER                             NOT NULL,
  key2            INTEGER                             NOT NULL,
  name            VARCHAR2(40)                        NOT NULL,
  created         DATE          DEFAULT SYSDATE       NOT NULL,
  expiry_date     DATE          DEFAULT SYSDATE + 730 NOT NULL,
  order_date      DATE                                    NULL,
  order_value     NUMBER(20,2)                            NULL,
  description     VARCHAR2(80)                            NULL,
  updated         DATE                                    NULL
);

CREATE
TABLE   snap_test.edge_case_key2
(
  id              INTEGER                             NOT NULL  PRIMARY KEY,
  key1            INTEGER                             NOT NULL,
  key2            INTEGER                             NOT NULL,
  key3            INTEGER                             NOT NULL,
  key4            INTEGER                             NOT NULL,
  name            VARCHAR2(40)                        NOT NULL,
  created         DATE          DEFAULT SYSDATE       NOT NULL,
  expiry_date     DATE          DEFAULT SYSDATE + 730 NOT NULL,
  order_date      DATE                                    NULL,
  order_value     NUMBER(20,2)                            NULL,
  description     VARCHAR2(80)                            NULL,
  updated         DATE                                    NULL
);

CREATE
TABLE   snap_test.edge_case_key3
(
  id              INTEGER                             NOT NULL  PRIMARY KEY,
  key1            INTEGER                             NOT NULL,
  key2            INTEGER                             NOT NULL,
  name            VARCHAR2(40)                        NOT NULL,
  created         DATE          DEFAULT SYSDATE       NOT NULL,
  expiry_date     DATE          DEFAULT SYSDATE + 730 NOT NULL,
  order_date      DATE                                    NULL,
  order_value     NUMBER(20,2)                            NULL,
  description     VARCHAR2(80)                            NULL,
  updated         DATE                                    NULL
);

CREATE
TABLE   snap_test.edge_case_key4
(
  id              INTEGER                             NOT NULL  PRIMARY KEY,
  name            VARCHAR2(40)                        NOT NULL,
  created         DATE          DEFAULT SYSDATE       NOT NULL,
  expiry_date     DATE          DEFAULT SYSDATE + 730 NOT NULL,
  order_date      DATE                                    NULL,
  order_value     NUMBER(20,2)                            NULL,
  description     VARCHAR2(80)                            NULL,
  updated         DATE                                    NULL
);

CREATE
TABLE   snap_test.edge_case_key5
(
  id              INTEGER                             NOT NULL  PRIMARY KEY,
  key1            INTEGER                             NOT NULL,
  key2            INTEGER                             NOT NULL,
  key3            INTEGER                             NOT NULL,
  name            VARCHAR2(40)                        NOT NULL,
  created         DATE          DEFAULT SYSDATE       NOT NULL,
  expiry_date     DATE          DEFAULT SYSDATE + 730 NOT NULL,
  order_date      DATE                                    NULL,
  order_value     NUMBER(20,2)                            NULL,
  description     VARCHAR2(80)                            NULL,
  updated         DATE                                    NULL
);

CREATE
TABLE   snap_test.edge_case_key6
(
  id              INTEGER                             NOT NULL  PRIMARY KEY,
  key1            INTEGER                             NOT NULL,
  name            VARCHAR2(40)                        NOT NULL,
  created         DATE          DEFAULT SYSDATE       NOT NULL,
  expiry_date     DATE          DEFAULT SYSDATE + 730 NOT NULL,
  order_date      DATE                                    NULL,
  order_value     NUMBER(20,2)                            NULL,
  description     VARCHAR2(80)                            NULL,
  updated         DATE                                    NULL
);

CREATE
TABLE   snap_test.edge_case_key7
(
  id              INTEGER                             NOT NULL  PRIMARY KEY,
  key1            INTEGER                             NOT NULL,
  name            VARCHAR2(40)                        NOT NULL,
  created         DATE          DEFAULT SYSDATE       NOT NULL,
  expiry_date     DATE          DEFAULT SYSDATE + 730 NOT NULL,
  order_date      DATE                                    NULL,
  order_value     NUMBER(20,2)                            NULL,
  description     VARCHAR2(80)                            NULL,
  updated         DATE                                    NULL
);

CREATE
TABLE   snap_test.edge_case_key8
(
  id              INTEGER                             NOT NULL  PRIMARY KEY,
  key1            INTEGER                             NOT NULL,
  key2            INTEGER                             NOT NULL,
  name            VARCHAR2(40)                        NOT NULL,
  created         DATE          DEFAULT SYSDATE       NOT NULL,
  expiry_date     DATE          DEFAULT SYSDATE + 730 NOT NULL,
  order_date      DATE                                    NULL,
  order_value     NUMBER(20,2)                            NULL,
  description     VARCHAR2(80)                            NULL,
  updated         DATE                                    NULL
);

CREATE
TABLE   snap_test.edge_case_key9
(
  id              INTEGER                             NOT NULL  PRIMARY KEY,
  key1            INTEGER                             NOT NULL,
  name            VARCHAR2(40)                        NOT NULL,
  created         DATE          DEFAULT SYSDATE       NOT NULL,
  expiry_date     DATE          DEFAULT SYSDATE + 730 NOT NULL,
  order_date      DATE                                    NULL,
  order_value     NUMBER(20,2)                            NULL,
  description     VARCHAR2(80)                            NULL,
  updated         DATE                                    NULL
);

CREATE
TABLE   snap_test.edge_case_key10
(
  id              INTEGER                             NOT NULL  PRIMARY KEY,
  key1            INTEGER                             NOT NULL,
  key2            INTEGER                             NOT NULL,
  name            VARCHAR2(40)                        NOT NULL,
  created         DATE          DEFAULT SYSDATE       NOT NULL,
  expiry_date     DATE          DEFAULT SYSDATE + 730 NOT NULL,
  order_date      DATE                                    NULL,
  order_value     NUMBER(20,2)                            NULL,
  description     VARCHAR2(80)                            NULL,
  updated         DATE                                    NULL
);

CREATE
TABLE   snap_test.edge_case_key11
(
  id              INTEGER                             NOT NULL  PRIMARY KEY,
  name            VARCHAR2(40)                        NOT NULL,
  created         DATE          DEFAULT SYSDATE       NOT NULL,
  expiry_date     DATE          DEFAULT SYSDATE + 730 NOT NULL,
  order_date      DATE                                    NULL,
  order_value     NUMBER(20,2)                            NULL,
  description     VARCHAR2(80)                            NULL,
  updated         DATE                                    NULL
);

CREATE
TABLE   snap_test.edge_case_key12
(
  id              INTEGER                             NOT NULL  PRIMARY KEY,
  name            VARCHAR2(40)                        NOT NULL,
  created         DATE          DEFAULT SYSDATE       NOT NULL,
  expiry_date     DATE          DEFAULT SYSDATE + 730 NOT NULL,
  order_date      DATE                                    NULL,
  order_value     NUMBER(20,2)                            NULL,
  description     VARCHAR2(80)                            NULL,
  updated         DATE                                    NULL
);

CREATE
TABLE   snap_test.edge_case
(
  code            INTEGER                             NOT NULL  PRIMARY KEY,
  name            VARCHAR2(40)                        NOT NULL,
  created         DATE          DEFAULT SYSDATE       NOT NULL,
  expiry_date     DATE          DEFAULT SYSDATE + 730 NOT NULL,
  key1            INTEGER                                 NULL  REFERENCES  snap_test.edge_case_key1(id),
  key2            INTEGER                                 NULL  REFERENCES  snap_test.edge_case_key2(id),
  key3            INTEGER                                 NULL  REFERENCES  snap_test.edge_case_key3(id),
  key4            INTEGER                                 NULL  REFERENCES  snap_test.edge_case_key4(id),
  key5            INTEGER                                 NULL  REFERENCES  snap_test.edge_case_key5(id),
  key6            INTEGER                                 NULL  REFERENCES  snap_test.edge_case_key6(id),
  key7            INTEGER                                 NULL  REFERENCES  snap_test.edge_case_key7(id),
  key8            INTEGER                                 NULL  REFERENCES  snap_test.edge_case_key8(id),
  key9            INTEGER                                 NULL  REFERENCES  snap_test.edge_case_key9(id),
  key10           INTEGER                                 NULL  REFERENCES  snap_test.edge_case_key10(id),
  order_date      DATE                                    NULL,
  order_value     NUMBER(20,2)                            NULL,
  description     VARCHAR2(80)                            NULL,
  updated         DATE                                    NULL
);

CREATE  OR  REPLACE
TRIGGER snap_test.edge_case_pre
BEFORE  INSERT
ON      snap_test.edge_case
FOR     EACH ROW
WHEN(   NEW.code IS NULL )
DECLARE
  iCodeVal INTEGER;

  CURSOR    cSeq
  IS
  SELECT    snap_test.edge_case_seq.NEXTVAL
  FROM      dual;

BEGIN

  OPEN  cSeq;
  FETCH cSeq
  INTO  iCodeVal;
  CLOSE cSeq;

 :NEW.code :=  iCodeVal;

END edge_case_pre;
/

CREATE  OR  REPLACE
TRIGGER snap_test.edge_case_key1_pre
BEFORE  INSERT
ON      snap_test.edge_case_key1
FOR     EACH ROW
WHEN(   NEW.id IS NULL )
DECLARE
  iKeyVal  INTEGER;

  CURSOR    cSeq
  IS
  SELECT    snap_test.edge_key1_seq.NEXTVAL
  FROM      dual;

BEGIN

  OPEN  cSeq;
  FETCH cSeq
  INTO  iKeyVal;
  CLOSE cSeq;

 :NEW.id :=  iKeyVal;

END edge_case_key1_pre;
/

CREATE  OR  REPLACE
TRIGGER snap_test.edge_case_key2_pre
BEFORE  INSERT
ON      snap_test.edge_case_key2
FOR     EACH ROW
WHEN(   NEW.id IS NULL )
DECLARE
  iKeyVal  INTEGER;

  CURSOR    cSeq
  IS
  SELECT    snap_test.edge_key2_seq.NEXTVAL
  FROM      dual;

BEGIN

  OPEN  cSeq;
  FETCH cSeq
  INTO  iKeyVal;
  CLOSE cSeq;

 :NEW.id :=  iKeyVal;

END edge_case_key2_pre;
/

CREATE  OR  REPLACE
TRIGGER snap_test.edge_case_key3_pre
BEFORE  INSERT
ON      snap_test.edge_case_key3
FOR     EACH ROW
WHEN(   NEW.id IS NULL )
DECLARE
  iKeyVal  INTEGER;

  CURSOR    cSeq
  IS
  SELECT    snap_test.edge_key3_seq.NEXTVAL
  FROM      dual;

BEGIN

  OPEN  cSeq;
  FETCH cSeq
  INTO  iKeyVal;
  CLOSE cSeq;

 :NEW.id :=  iKeyVal;

END edge_case_key3_pre;
/

CREATE  OR  REPLACE
TRIGGER snap_test.edge_case_key4_pre
BEFORE  INSERT
ON      snap_test.edge_case_key4
FOR     EACH ROW
WHEN(   NEW.id IS NULL )
DECLARE
  iKeyVal  INTEGER;

  CURSOR    cSeq
  IS
  SELECT    snap_test.edge_key4_seq.NEXTVAL
  FROM      dual;

BEGIN

  OPEN  cSeq;
  FETCH cSeq
  INTO  iKeyVal;
  CLOSE cSeq;

 :NEW.id :=  iKeyVal;

END edge_case_key4_pre;
/

CREATE  OR  REPLACE
TRIGGER snap_test.edge_case_key5_pre
BEFORE  INSERT
ON      snap_test.edge_case_key5
FOR     EACH ROW
WHEN(   NEW.id IS NULL )
DECLARE
  iKeyVal  INTEGER;

  CURSOR    cSeq
  IS
  SELECT    snap_test.edge_key5_seq.NEXTVAL
  FROM      dual;

BEGIN

  OPEN  cSeq;
  FETCH cSeq
  INTO  iKeyVal;
  CLOSE cSeq;

 :NEW.id :=  iKeyVal;

END edge_case_key5_pre;
/

CREATE  OR  REPLACE
TRIGGER snap_test.edge_case_key6_pre
BEFORE  INSERT
ON      snap_test.edge_case_key6
FOR     EACH ROW
WHEN(   NEW.id IS NULL )
DECLARE
  iKeyVal  INTEGER;

  CURSOR    cSeq
  IS
  SELECT    snap_test.edge_key6_seq.NEXTVAL
  FROM      dual;

BEGIN

  OPEN  cSeq;
  FETCH cSeq
  INTO  iKeyVal;
  CLOSE cSeq;

 :NEW.id :=  iKeyVal;

END edge_case_key6_pre;
/

CREATE  OR  REPLACE
TRIGGER snap_test.edge_case_key7_pre
BEFORE  INSERT
ON      snap_test.edge_case_key7
FOR     EACH ROW
WHEN(   NEW.id IS NULL )
DECLARE
  iKeyVal  INTEGER;

  CURSOR    cSeq
  IS
  SELECT    snap_test.edge_key7_seq.NEXTVAL
  FROM      dual;

BEGIN

  OPEN  cSeq;
  FETCH cSeq
  INTO  iKeyVal;
  CLOSE cSeq;

 :NEW.id :=  iKeyVal;

END edge_case_key7_pre;
/

CREATE  OR  REPLACE
TRIGGER snap_test.edge_case_key8_pre
BEFORE  INSERT
ON      snap_test.edge_case_key8
FOR     EACH ROW
WHEN(   NEW.id IS NULL )
DECLARE
  iKeyVal  INTEGER;

  CURSOR    cSeq
  IS
  SELECT    snap_test.edge_key8_seq.NEXTVAL
  FROM      dual;

BEGIN

  OPEN  cSeq;
  FETCH cSeq
  INTO  iKeyVal;
  CLOSE cSeq;

 :NEW.id :=  iKeyVal;

END edge_case_key8_pre;
/

CREATE  OR  REPLACE
TRIGGER snap_test.edge_case_key9_pre
BEFORE  INSERT
ON      snap_test.edge_case_key9
FOR     EACH ROW
WHEN(   NEW.id IS NULL )
DECLARE
  iKeyVal  INTEGER;

  CURSOR    cSeq
  IS
  SELECT    snap_test.edge_key9_seq.NEXTVAL
  FROM      dual;

BEGIN

  OPEN  cSeq;
  FETCH cSeq
  INTO  iKeyVal;
  CLOSE cSeq;

 :NEW.id :=  iKeyVal;

END edge_case_key9_pre;
/

CREATE  OR  REPLACE
TRIGGER snap_test.edge_case_key10_pre
BEFORE  INSERT
ON      snap_test.edge_case_key10
FOR     EACH ROW
WHEN(   NEW.id IS NULL )
DECLARE
  iKeyVal  INTEGER;

  CURSOR    cSeq
  IS
  SELECT    snap_test.edge_key10_seq.NEXTVAL
  FROM      dual;

BEGIN

  OPEN  cSeq;
  FETCH cSeq
  INTO  iKeyVal;
  CLOSE cSeq;

 :NEW.id :=  iKeyVal;

END edge_case_key10_pre;
/

CREATE  OR  REPLACE
TRIGGER snap_test.edge_case_key11_pre
BEFORE  INSERT
ON      snap_test.edge_case_key11
FOR     EACH ROW
WHEN(   NEW.id IS NULL )
DECLARE
  iKeyVal  INTEGER;

  CURSOR    cSeq
  IS
  SELECT    snap_test.edge_key11_seq.NEXTVAL
  FROM      dual;

BEGIN

  OPEN  cSeq;
  FETCH cSeq
  INTO  iKeyVal;
  CLOSE cSeq;

 :NEW.id :=  iKeyVal;

END edge_case_key11_pre;
/

CREATE  OR  REPLACE
TRIGGER snap_test.edge_case_key12_pre
BEFORE  INSERT
ON      snap_test.edge_case_key12
FOR     EACH ROW
WHEN(   NEW.id IS NULL )
DECLARE
  iKeyVal  INTEGER;

  CURSOR    cSeq
  IS
  SELECT    snap_test.edge_key12_seq.NEXTVAL
  FROM      dual;

BEGIN

  OPEN  cSeq;
  FETCH cSeq
  INTO  iKeyVal;
  CLOSE cSeq;

 :NEW.id :=  iKeyVal;

END edge_case_key12_pre;
/

EXECUTE DBMS_RANDOM.INITIALIZE( 070462 );

INSERT
INTO    snap_test.edge_case_key1
      ( key1, key2, name, order_date, order_value, description )
SELECT
        CEIL(ROWNUM / 2)                                              key1,
        TRUNC(DBMS_RANDOM.VALUE(1,21))                                key2,
        DBMS_RANDOM.STRING('U',FLOOR(DBMS_RANDOM.VALUE(6,15)))        name,
        SYSDATE - (10000 / (24 * 60)) + ((ROWNUM * 1000) / (24 * 60)) order_date,
        DBMS_RANDOM.VALUE(1,2400)                                     order_value,
        DBMS_RANDOM.STRING('A', 64)                                   description
FROM    all_objects
WHERE   ROWNUM < 101;

INSERT
INTO    snap_test.edge_case_key2
      ( key1, key2, key3, key4, name, order_date, order_value, description )
SELECT
        TRUNC(DBMS_RANDOM.VALUE(1,11))                                key1,
        TRUNC(DBMS_RANDOM.VALUE(1,24))                                key2,
        TRUNC(DBMS_RANDOM.VALUE(1,24))                                key3,
        TRUNC(DBMS_RANDOM.VALUE(1,24))                                key4,
        DBMS_RANDOM.STRING('U',FLOOR(DBMS_RANDOM.VALUE(6,15)))        name,
        SYSDATE - (10000 / (24 * 60)) + ((ROWNUM * 1000) / (24 * 60)) order_date,
        DBMS_RANDOM.VALUE(1,2400)                                     order_value,
        DBMS_RANDOM.STRING('A', 64)                                   description
FROM    all_objects
WHERE   ROWNUM < 51;

INSERT
INTO    snap_test.edge_case_key3
      ( key1, key2, name, order_date, order_value, description )
SELECT
        ROWNUM                                                        key1,
        TRUNC(DBMS_RANDOM.VALUE(1,24))                                key2,
        DBMS_RANDOM.STRING('U',FLOOR(DBMS_RANDOM.VALUE(6,15)))        name,
        SYSDATE - (10000 / (24 * 60)) + ((ROWNUM * 1000) / (24 * 60)) order_date,
        DBMS_RANDOM.VALUE(1,2400)                                     order_value,
        DBMS_RANDOM.STRING('A', 64)                                   description
FROM    all_objects
WHERE   ROWNUM < 11;

INSERT
INTO    snap_test.edge_case_key4
      ( name, order_date, order_value, description )
SELECT
        DBMS_RANDOM.STRING('U',FLOOR(DBMS_RANDOM.VALUE(6,15)))        name,
        SYSDATE - (10000 / (24 * 60)) + ((ROWNUM * 1000) / (24 * 60)) order_date,
        DBMS_RANDOM.VALUE(1,2400)                                     order_value,
        DBMS_RANDOM.STRING('A', 64)                                   description
FROM    all_objects
WHERE   ROWNUM < 11;

INSERT
INTO    snap_test.edge_case_key5
      ( key1, key2, key3, name, order_date, order_value, description )
SELECT
        ROWNUM                                                        key1,
        ROWNUM                                                        key2,
        ROWNUM                                                        key3,
        DBMS_RANDOM.STRING('U',FLOOR(DBMS_RANDOM.VALUE(6,15)))        name,
        SYSDATE - (10000 / (24 * 60)) + ((ROWNUM * 1000) / (24 * 60)) order_date,
        DBMS_RANDOM.VALUE(1,2400)                                     order_value,
        DBMS_RANDOM.STRING('A', 64)                                   description
FROM    all_objects
WHERE   ROWNUM < 21;

INSERT
INTO    snap_test.edge_case_key6
      ( key1, name, order_date, order_value, description )
SELECT
        TRUNC(DBMS_RANDOM.VALUE(1,24))                                key1,
        DBMS_RANDOM.STRING('U',FLOOR(DBMS_RANDOM.VALUE(6,15)))        name,
        SYSDATE - (10000 / (24 * 60)) + ((ROWNUM * 1000) / (24 * 60)) order_date,
        DBMS_RANDOM.VALUE(1,2400)                                     order_value,
        DBMS_RANDOM.STRING('A', 64)                                   description
FROM    all_objects
WHERE   ROWNUM < 11;

INSERT
INTO    snap_test.edge_case_key7
      ( key1, name, order_date, order_value, description )
SELECT
        TRUNC(DBMS_RANDOM.VALUE(1,24))                                key1,
        DBMS_RANDOM.STRING('U',FLOOR(DBMS_RANDOM.VALUE(6,15)))        name,
        SYSDATE - (10000 / (24 * 60)) + ((ROWNUM * 1000) / (24 * 60)) order_date,
        DBMS_RANDOM.VALUE(1,2400)                                     order_value,
        DBMS_RANDOM.STRING('A', 64)                                   description
FROM    all_objects
WHERE   ROWNUM < 11;

INSERT
INTO    snap_test.edge_case_key8
      ( key1, key2, name, order_date, order_value, description )
SELECT
        TRUNC(DBMS_RANDOM.VALUE(1,24))                                key1,
        TRUNC(DBMS_RANDOM.VALUE(1,24))                                key2,
        DBMS_RANDOM.STRING('U',FLOOR(DBMS_RANDOM.VALUE(6,15)))        name,
        SYSDATE - (10000 / (24 * 60)) + ((ROWNUM * 1000) / (24 * 60)) order_date,
        DBMS_RANDOM.VALUE(1,2400)                                     order_value,
        DBMS_RANDOM.STRING('A', 64)                                   description
FROM    all_objects
WHERE   ROWNUM < 11;

INSERT
INTO    snap_test.edge_case_key9
      ( key1, name, order_date, order_value, description )
SELECT
        TRUNC(DBMS_RANDOM.VALUE(1,24))                                key1,
        DBMS_RANDOM.STRING('U',FLOOR(DBMS_RANDOM.VALUE(6,15)))        name,
        SYSDATE - (10000 / (24 * 60)) + ((ROWNUM * 1000) / (24 * 60)) order_date,
        DBMS_RANDOM.VALUE(1,2400)                                     order_value,
        DBMS_RANDOM.STRING('A', 64)                                   description
FROM    all_objects
WHERE   ROWNUM < 11;

INSERT
INTO    snap_test.edge_case_key10
      ( key1, key2, name, order_date, order_value, description )
SELECT
        TRUNC(DBMS_RANDOM.VALUE(1,24))                                key1,
        TRUNC(DBMS_RANDOM.VALUE(1,24))                                key2,
        DBMS_RANDOM.STRING('U',FLOOR(DBMS_RANDOM.VALUE(6,15)))        name,
        SYSDATE - (10000 / (24 * 60)) + ((ROWNUM * 1000) / (24 * 60)) order_date,
        DBMS_RANDOM.VALUE(1,2400)                                     order_value,
        DBMS_RANDOM.STRING('A', 64)                                   description
FROM    all_objects
WHERE   ROWNUM < 11;

INSERT
INTO    snap_test.edge_case_key11
      ( name, order_date, order_value, description )
SELECT
        DBMS_RANDOM.STRING('U',FLOOR(DBMS_RANDOM.VALUE(6,15)))        name,
        SYSDATE - (10000 / (24 * 60)) + ((ROWNUM * 1000) / (24 * 60)) order_date,
        DBMS_RANDOM.VALUE(1,2400)                                     order_value,
        DBMS_RANDOM.STRING('A', 64)                                   description
FROM    all_objects
WHERE   ROWNUM < 11;

INSERT
INTO    snap_test.edge_case_key12
      ( name, order_date, order_value, description )
SELECT
        DBMS_RANDOM.STRING('U',FLOOR(DBMS_RANDOM.VALUE(6,15)))        name,
        SYSDATE - (10000 / (24 * 60)) + ((ROWNUM * 1000) / (24 * 60)) order_date,
        DBMS_RANDOM.VALUE(1,2400)                                     order_value,
        DBMS_RANDOM.STRING('A', 64)                                   description
FROM    all_objects
WHERE   ROWNUM < 21;

INSERT
INTO    snap_test.edge_case
      ( name,
        key1, key2, key3, key4,  key5, key6, key7, key8, key9, key10,
        order_date, order_value, description )
SELECT
        DBMS_RANDOM.STRING('U',FLOOR(DBMS_RANDOM.VALUE(6,15)))                                    name,
        ROWNUM                                                                                    key1,
        TRUNC(DBMS_RANDOM.VALUE(1,10))                                                            key2,
        DECODE(MOD(ROWNUM,                          2), 0, TRUNC(DBMS_RANDOM.VALUE(1,10)), NULL)  key3,
        DECODE(MOD(ROWNUM,                          3), 0, TRUNC(DBMS_RANDOM.VALUE(1,10)), NULL)  key4,
        DECODE(MOD(ROWNUM + 1,                      2), 0, TRUNC(DBMS_RANDOM.VALUE(1,10)), NULL)  key5,
        DECODE(MOD(ROWNUM + 1,                      3), 0, TRUNC(DBMS_RANDOM.VALUE(1,10)), NULL)  key6,
        DECODE(MOD(TRUNC(DBMS_RANDOM.VALUE(1,10)),  4), 0, TRUNC(DBMS_RANDOM.VALUE(1,10)), NULL)  key7,
        DECODE(MOD(TRUNC(DBMS_RANDOM.VALUE(1,10)),  2), 0, TRUNC(DBMS_RANDOM.VALUE(1,10)), NULL)  key8,
        DECODE(MOD(TRUNC(DBMS_RANDOM.VALUE(1,10)),  2), 0, TRUNC(DBMS_RANDOM.VALUE(1,10)), NULL)  key9,
        DECODE(MOD(TRUNC(DBMS_RANDOM.VALUE(1,10)),  2), 0, TRUNC(DBMS_RANDOM.VALUE(1,10)), NULL)  key10,
        SYSDATE - (100000 / ( 24 * 60)) + (ROWNUM / ( 24 * 60))                                   order_date,
        DBMS_RANDOM.VALUE(1,2400)                                                                 order_value,
        DBMS_RANDOM.STRING('A', 64)                                                               description
FROM    all_objects
WHERE   ROWNUM < 11;

CREATE  MATERIALIZED VIEW LOG ON snap_test.edge_case       WITH PRIMARY KEY, ROWID;
CREATE  MATERIALIZED VIEW LOG ON snap_test.edge_case_key1  WITH PRIMARY KEY, ROWID;
CREATE  MATERIALIZED VIEW LOG ON snap_test.edge_case_key2  WITH PRIMARY KEY, ROWID;
CREATE  MATERIALIZED VIEW LOG ON snap_test.edge_case_key3  WITH PRIMARY KEY, ROWID;
CREATE  MATERIALIZED VIEW LOG ON snap_test.edge_case_key4  WITH PRIMARY KEY, ROWID;
CREATE  MATERIALIZED VIEW LOG ON snap_test.edge_case_key5  WITH PRIMARY KEY, ROWID;
CREATE  MATERIALIZED VIEW LOG ON snap_test.edge_case_key6  WITH PRIMARY KEY, ROWID;
CREATE  MATERIALIZED VIEW LOG ON snap_test.edge_case_key7  WITH PRIMARY KEY, ROWID;
CREATE  MATERIALIZED VIEW LOG ON snap_test.edge_case_key8  WITH PRIMARY KEY, ROWID;
CREATE  MATERIALIZED VIEW LOG ON snap_test.edge_case_key9  WITH PRIMARY KEY, ROWID;
CREATE  MATERIALIZED VIEW LOG ON snap_test.edge_case_key10 WITH PRIMARY KEY, ROWID;
CREATE  MATERIALIZED VIEW LOG ON snap_test.edge_case_key11 WITH PRIMARY KEY, ROWID;
CREATE  MATERIALIZED VIEW LOG ON snap_test.edge_case_key12 WITH PRIMARY KEY, ROWID;

SET TERMOUT ON;

CREATE  MATERIALIZED VIEW snap_test.edge_case_view
(       c1_code,  c1_name,  c1_created,
        t1_key,   t1_name,  t1_created, t1_order_date,  t1_order_value, t1_updated,
        t2_key,   t2_name,  t2_created, t2_order_date,  t2_order_value, t2_updated,
        t3_key,   t3_name,  t3_created, t3_order_date,  t3_order_value, t3_updated,
        t4_key,   t4_name,  t4_created, t4_order_date,  t4_order_value, t4_updated,
        t5_key,   t5_name,  t5_created, t5_order_date,  t5_order_value, t5_updated,
        t6_key,   t6_name,  t6_created, t6_order_date,  t6_order_value, t6_updated,
        t7_key,   t7_name,  t7_created, t7_order_date,  t7_order_value, t7_updated,
        t8_key,   t8_name,  t8_created, t8_order_date,  t8_order_value, t8_updated,
        t9_key,   t9_name,  t9_created, t9_order_date,  t9_order_value, t9_updated,
        t10_key,  t10_name, t10_created,t10_order_date, t10_order_value,t10_updated,
        c1_rowid, t1_rowid, t2_rowid,   t3_rowid,       t4_rowid,       t5_rowid,
        t6_rowid, t7_rowid, t8_rowid,   t9_rowid,       t10_rowid )
LOGGING
NOCOMPRESS
NOCACHE
NOPARALLEL
REFRESH FAST
ON      DEMAND
WITH    PRIMARY KEY
DISABLE QUERY REWRITE
AS
SELECT
        c1.code,  c1.name,  c1.created,
        t1.id,    t1.name,  t1.created, t1.order_date,  t1.order_value, t1.updated,
        t2.id,    t2.name,  t2.created, t2.order_date,  t2.order_value, t2.updated,
        t3.id,    t3.name,  t3.created, t3.order_date,  t3.order_value, t3.updated,
        t4.id,    t4.name,  t4.created, t4.order_date,  t4.order_value, t4.updated,
        t5.id,    t5.name,  t5.created, t5.order_date,  t5.order_value, t5.updated,
        t6.id,    t6.name,  t6.created, t6.order_date,  t6.order_value, t6.updated,
        t7.id,    t7.name,  t7.created, t7.order_date,  t7.order_value, t7.updated,
        t8.id,    t8.name,  t8.created, t8.order_date,  t8.order_value, t8.updated,
        t9.id,    t9.name,  t9.created, t9.order_date,  t9.order_value, t9.updated,
        t10.id,   t10.name, t10.created,t10.order_date, t10.order_value,t10.updated,
        c1.rowid, t1.rowid, t2.rowid,   t3.rowid,       t4.rowid,       t5.rowid,
        t6.rowid, t7.rowid, t8.rowid,   t9.rowid,       t10.rowid
FROM
        snap_test.edge_case       c1,
        snap_test.edge_case_key1  t1,
        snap_test.edge_case_key2  t2,
        snap_test.edge_case_key3  t3,
        snap_test.edge_case_key4  t4,
        snap_test.edge_case_key5  t5,
        snap_test.edge_case_key6  t6,
        snap_test.edge_case_key7  t7,
        snap_test.edge_case_key8  t8,
        snap_test.edge_case_key9  t9,
        snap_test.edge_case_key10 t10
WHERE
        c1.key1 = t1.id
AND     c1.key2 = t2.id
AND     c1.key3 = t3.id(+)
AND     c1.key4 = t4.id(+)
AND     c1.key5 = t5.id(+)
AND     c1.key6 = t6.id(+)
AND     c1.key7 = t7.id(+)
AND     c1.key8 = t8.id(+)
AND     c1.key9 = t9.id(+)
AND     c1.key10 = t10.id(+);

CREATE  MATERIALIZED VIEW snap_test.edge_case_pk_view
(       t1_id,      t1_name,    t1_created,   t1_order_date,    t1_order_value,   t1_updated,
        t1a_id,     t1a_name,   t1a_created,  t1a_order_date,   t1a_order_value,  t1a_updated,
        t2_id,      t2_name,    t2_created,   t2_order_date,    t2_order_value,   t2_updated,
        t3_id,      t3_name,    t3_created,   t3_order_date,    t3_order_value,   t3_updated,
        t4_id,      t4_name,    t4_created,   t4_order_date,    t4_order_value,   t4_updated,
        t5_id,      t5_name,    t5_created,   t5_order_date,    t5_order_value,   t5_updated,
        t5a_id,     t5a_name,   t5a_created,  t5a_order_date,   t5a_order_value,  t5a_updated,
        t6_id,      t6_name,    t6_created,   t6_order_date,    t6_order_value,   t6_updated,
        t7_id,      t7_name,    t7_created,   t7_order_date,    t7_order_value,   t7_updated,
        t8_id,      t8_name,    t8_created,   t8_order_date,    t8_order_value,   t8_updated,
        t9_id,      t9_name,    t9_created,   t9_order_date,    t9_order_value,   t9_updated,
        t10_id,     t10_name,   t10_created,  t10_order_date,   t10_order_value,  t10_updated,
        t11_id,     t11_name,   t11_created,  t11_order_date,   t11_order_value,  t11_updated,
        t12a_id,    t12a_name,  t12a_created, t12a_order_date,  t12a_order_value, t12a_updated,
        t12b_id,    t12b_name,  t12b_created, t12b_order_date,  t12b_order_value, t12b_updated,
        t12c_id,    t12c_name,  t12c_created, t12c_order_date,  t12c_order_value, t12c_updated,
        t12d_id,    t12d_name,  t12d_created, t12d_order_date,  t12d_order_value, t12d_updated,
        t12e_id,    t12e_name,  t12e_created, t12e_order_date,  t12e_order_value, t12e_updated,
        t12f_id,    t12f_name,  t12f_created, t12f_order_date,  t12f_order_value, t12f_updated,
        t12g_id,    t12g_name,  t12g_created, t12g_order_date,  t12g_order_value, t12g_updated,
        t12h_id,    t12h_name,  t12h_created, t12h_order_date,  t12h_order_value, t12h_updated,
        t12i_id,    t12i_name,  t12i_created, t12i_order_date,  t12i_order_value, t12i_updated,
        t1_rowid,   t1a_rowid,  t2_rowid,     t3_rowid,         t4_rowid,         t5_rowid,
        t5a_rowid,  t6_rowid,   t7_rowid,     t8_rowid,         t9_rowid,         t10_rowid,
        t11_rowid,  t12a_rowid, t12b_rowid,   t12c_rowid,       t12d_rowid,       t12e_rowid,
        t12f_rowid, t12g_rowid, t12h_rowid,   t12i_rowid )
LOGGING
NOCOMPRESS
NOCACHE
NOPARALLEL
REFRESH FAST
ON      DEMAND
WITH    PRIMARY KEY
DISABLE QUERY   REWRITE
AS
SELECT
        t1.id,      t1.name,    t1.created,   t1.order_date,    t1.order_value,   t1.updated,
        t1a.id,     t1a.name,   t1a.created,  t1a.order_date,   t1a.order_value,  t1a.updated,
        t2.id,      t2.name,    t2.created,   t2.order_date,    t2.order_value,   t2.updated,
        t3.id,      t3.name,    t3.created,   t3.order_date,    t3.order_value,   t3.updated,
        t4.id,      t4.name,    t4.created,   t4.order_date,    t4.order_value,   t4.updated,
        t5.id,      t5.name,    t5.created,   t5.order_date,    t5.order_value,   t5.updated,
        t5a.id,     t5a.name,   t5a.created,  t5a.order_date,   t5a.order_value,  t5a.updated,
        t6.id,      t6.name,    t6.created,   t6.order_date,    t6.order_value,   t6.updated,
        t7.id,      t7.name,    t7.created,   t7.order_date,    t7.order_value,   t7.updated,
        t8.id,      t8.name,    t8.created,   t8.order_date,    t8.order_value,   t8.updated,
        t9.id,      t9.name,    t9.created,   t9.order_date,    t9.order_value,   t9.updated,
        t10.id,     t10.name,   t10.created,  t10.order_date,   t10.order_value,  t10.updated,
        t11.id,     t11.name,   t11.created,  t11.order_date,   t11.order_value,  t11.updated,
        t12a.id,    t12a.name,  t12a.created, t12a.order_date,  t12a.order_value, t12a.updated,
        t12b.id,    t12b.name,  t12b.created, t12b.order_date,  t12b.order_value, t12b.updated,
        t12c.id,    t12c.name,  t12c.created, t12c.order_date,  t12c.order_value, t12c.updated,
        t12d.id,    t12d.name,  t12d.created, t12d.order_date,  t12d.order_value, t12d.updated,
        t12e.id,    t12e.name,  t12e.created, t12e.order_date,  t12e.order_value, t12e.updated,
        t12f.id,    t12f.name,  t12f.created, t12f.order_date,  t12f.order_value, t12f.updated,
        t12g.id,    t12g.name,  t12g.created, t12g.order_date,  t12g.order_value, t12g.updated,
        t12h.id,    t12h.name,  t12h.created, t12h.order_date,  t12h.order_value, t12h.updated,
        t12i.id,    t12i.name,  t12i.created, t12i.order_date,  t12i.order_value, t12i.updated,
        t1.rowid,   t1a.rowid,  t2.rowid,     t3.rowid,         t4.rowid,         t5.rowid,
        t5a.rowid,  t6.rowid,   t7.rowid,     t8.rowid,         t9.rowid,         t10.rowid,
        t11.rowid,  t12a.rowid, t12b.rowid,   t12c.rowid,       t12d.rowid,       t12e.rowid,
        t12f.rowid, t12g.rowid, t12h.rowid,   t12i.rowid
FROM
        snap_test.edge_case_key1  t1,
        snap_test.edge_case_key1  t1a,
        snap_test.edge_case_key2  t2,
        snap_test.edge_case_key3  t3,
        snap_test.edge_case_key4  t4,
        snap_test.edge_case_key5  t5,
        snap_test.edge_case_key5  t5a,
        snap_test.edge_case_key6  t6,
        snap_test.edge_case_key7  t7,
        snap_test.edge_case_key8  t8,
        snap_test.edge_case_key9  t9,
        snap_test.edge_case_key10 t10,
        snap_test.edge_case_key11 t11,
        snap_test.edge_case_key12 t12a,
        snap_test.edge_case_key12 t12b,
        snap_test.edge_case_key12 t12c,
        snap_test.edge_case_key12 t12d,
        snap_test.edge_case_key12 t12e,
        snap_test.edge_case_key12 t12f,
        snap_test.edge_case_key12 t12g,
        snap_test.edge_case_key12 t12h,
        snap_test.edge_case_key12 t12i
WHERE
        t1.id    != t1a.id
AND     t1.key1   = t2.id
AND     t1.key2   = t5.id
AND     t2.key1   = t3.id
AND     t2.key2   = t6.id(+)
AND     t2.key3   = t7.id(+)
AND     t2.key4   = t8.id(+)
AND     t3.key1   = t12a.id
AND     t3.key2   = t12b.id(+)
AND     t5.key1   = t10.id(+)
AND     t5.key2   = t12c.id(+)
AND     t2.id     = t1a.key1
AND     t1a.key2  = t5a.id
AND     t5a.key1  = t12d.id(+)
AND     t5a.key2  = t12e.id(+)
AND     t6.key1   = t12f.id(+)
AND     t7.key1   = t12g.id(+)
AND     t8.key1   = t9.id(+)
AND     t8.key2   = t4.id(+)
AND     t9.key1   = t12h.id(+)
AND     t10.key1  = t11.id(+)
AND     t10.key2  = t12i.id(+);

CREATE  MATERIALIZED VIEW snap_test.edge_case_all_cols_view
(       t1_id,      t1_name,    t1_created,   t1_order_date,    t1_order_value,   t1_updated,
        t1a_id,     t1a_name,   t1a_created,  t1a_order_date,   t1a_order_value,  t1a_updated,
        t2_id,      t2_name,    t2_created,   t2_order_date,    t2_order_value,   t2_updated,
        t3_id,      t3_name,    t3_created,   t3_order_date,    t3_order_value,   t3_updated,
        t4_id,      t4_name,    t4_created,   t4_order_date,    t4_order_value,   t4_updated,
        t5_id,      t5_name,    t5_created,   t5_order_date,    t5_order_value,   t5_updated,
        t5a_id,     t5a_name,   t5a_created,  t5a_order_date,   t5a_order_value,  t5a_updated,
        t6_id,      t6_name,    t6_created,   t6_order_date,    t6_order_value,   t6_updated,
        t7_id,      t7_name,    t7_created,   t7_order_date,    t7_order_value,   t7_updated,
        t8_id,      t8_name,    t8_created,   t8_order_date,    t8_order_value,   t8_updated,
        t9_id,      t9_name,    t9_created,   t9_order_date,    t9_order_value,   t9_updated,
        t10_id,     t10_name,   t10_created,  t10_order_date,   t10_order_value,  t10_updated,
        t11_id,     t11_name,   t11_created,  t11_order_date,   t11_order_value,  t11_updated,
        t12a_id,    t12a_name,  t12a_created, t12a_order_date,  t12a_order_value, t12a_updated,
        t12b_id,    t12b_name,  t12b_created, t12b_order_date,  t12b_order_value, t12b_updated,
        t12c_id,    t12c_name,  t12c_created, t12c_order_date,  t12c_order_value, t12c_updated,
        t12d_id,    t12d_name,  t12d_created, t12d_order_date,  t12d_order_value, t12d_updated,
        t12e_id,    t12e_name,  t12e_created, t12e_order_date,  t12e_order_value, t12e_updated,
        t12f_id,    t12f_name,  t12f_created, t12f_order_date,  t12f_order_value, t12f_updated,
        t12g_id,    t12g_name,  t12g_created, t12g_order_date,  t12g_order_value, t12g_updated,
        t12h_id,    t12h_name,  t12h_created, t12h_order_date,  t12h_order_value, t12h_updated,
        t12i_id,    t12i_name,  t12i_created, t12i_order_date,  t12i_order_value, t12i_updated,
        t1_rowid,   t1a_rowid,  t2_rowid,     t3_rowid,         t4_rowid,         t5_rowid,
        t5a_rowid,  t6_rowid,   t7_rowid,     t8_rowid,         t9_rowid,         t10_rowid,
        t11_rowid,  t12a_rowid, t12b_rowid,   t12c_rowid,       t12d_rowid,       t12e_rowid,
        t12f_rowid, t12g_rowid, t12h_rowid,   t12i_rowid )
LOGGING
NOCOMPRESS
NOCACHE
NOPARALLEL
REFRESH FAST
ON      DEMAND
WITH    PRIMARY KEY
DISABLE QUERY   REWRITE
AS
SELECT
        t1.id,      t1.name,    t1.created,   t1.order_date,    t1.order_value,   t1.updated,
        t1a.id,     t1a.name,   t1a.created,  t1a.order_date,   t1a.order_value,  t1a.updated,
        t2.id,      t2.name,    t2.created,   t2.order_date,    t2.order_value,   t2.updated,
        t3.id,      t3.name,    t3.created,   t3.order_date,    t3.order_value,   t3.updated,
        t4.id,      t4.name,    t4.created,   t4.order_date,    t4.order_value,   t4.updated,
        t5.id,      t5.name,    t5.created,   t5.order_date,    t5.order_value,   t5.updated,
        t5a.id,     t5a.name,   t5a.created,  t5a.order_date,   t5a.order_value,  t5a.updated,
        t6.id,      t6.name,    t6.created,   t6.order_date,    t6.order_value,   t6.updated,
        t7.id,      t7.name,    t7.created,   t7.order_date,    t7.order_value,   t7.updated,
        t8.id,      t8.name,    t8.created,   t8.order_date,    t8.order_value,   t8.updated,
        t9.id,      t9.name,    t9.created,   t9.order_date,    t9.order_value,   t9.updated,
        t10.id,     t10.name,   t10.created,  t10.order_date,   t10.order_value,  t10.updated,
        t11.id,     t11.name,   t11.created,  t11.order_date,   t11.order_value,  t11.updated,
        t12a.id,    t12a.name,  t12a.created, t12a.order_date,  t12a.order_value, t12a.updated,
        t12b.id,    t12b.name,  t12b.created, t12b.order_date,  t12b.order_value, t12b.updated,
        t12c.id,    t12c.name,  t12c.created, t12c.order_date,  t12c.order_value, t12c.updated,
        t12d.id,    t12d.name,  t12d.created, t12d.order_date,  t12d.order_value, t12d.updated,
        t12e.id,    t12e.name,  t12e.created, t12e.order_date,  t12e.order_value, t12e.updated,
        t12f.id,    t12f.name,  t12f.created, t12f.order_date,  t12f.order_value, t12f.updated,
        t12g.id,    t12g.name,  t12g.created, t12g.order_date,  t12g.order_value, t12g.updated,
        t12h.id,    t12h.name,  t12h.created, t12h.order_date,  t12h.order_value, t12h.updated,
        t12i.id,    t12i.name,  t12i.created, t12i.order_date,  t12i.order_value, t12i.updated,
        t1.rowid,   t1a.rowid,  t2.rowid,     t3.rowid,         t4.rowid,         t5.rowid,
        t5a.rowid,  t6.rowid,   t7.rowid,     t8.rowid,         t9.rowid,         t10.rowid,
        t11.rowid,  t12a.rowid, t12b.rowid,   t12c.rowid,       t12d.rowid,       t12e.rowid,
        t12f.rowid, t12g.rowid, t12h.rowid,   t12i.rowid
FROM
        snap_test.edge_case_key1  t1,
        snap_test.edge_case_key1  t1a,
        snap_test.edge_case_key2  t2,
        snap_test.edge_case_key3  t3,
        snap_test.edge_case_key4  t4,
        snap_test.edge_case_key5  t5,
        snap_test.edge_case_key5  t5a,
        snap_test.edge_case_key6  t6,
        snap_test.edge_case_key7  t7,
        snap_test.edge_case_key8  t8,
        snap_test.edge_case_key9  t9,
        snap_test.edge_case_key10 t10,
        snap_test.edge_case_key11 t11,
        snap_test.edge_case_key12 t12a,
        snap_test.edge_case_key12 t12b,
        snap_test.edge_case_key12 t12c,
        snap_test.edge_case_key12 t12d,
        snap_test.edge_case_key12 t12e,
        snap_test.edge_case_key12 t12f,
        snap_test.edge_case_key12 t12g,
        snap_test.edge_case_key12 t12h,
        snap_test.edge_case_key12 t12i
WHERE
        t1.id    != t1a.id
AND     t1.key1   = t2.id
AND     t1.key2   = t5.id
AND     t2.key1   = t3.id
AND     t2.key2   = t6.id(+)
AND     t2.key3   = t7.id(+)
AND     t2.key4   = t8.id(+)
AND     t3.key1   = t12a.id
AND     t3.key2   = t12b.id(+)
AND     t5.key1   = t10.id(+)
AND     t5.key2   = t12c.id(+)
AND     t2.id     = t1a.key1
AND     t1a.key2  = t5a.id
AND     t5a.key1  = t12d.id(+)
AND     t5a.key2  = t12e.id(+)
AND     t6.key1   = t12f.id(+)
AND     t7.key1   = t12g.id(+)
AND     t8.key1   = t9.id(+)
AND     t8.key2   = t4.id(+)
AND     t9.key1   = t12h.id(+)
AND     t10.key1  = t11.id(+)
AND     t10.key2  = t12i.id(+);

ALTER
TABLE   snap_test.edge_case_view
ADD     PRIMARY KEY( c1_code );

ALTER
TABLE   snap_test.edge_case_pk_view
ADD     PRIMARY KEY( t1_id )
DEFERRABLE;

ALTER
TABLE   snap_test.edge_case_all_cols_view
ADD     CONSTRAINT  edge_case_complex_view_uk
UNIQUE  (t1_id)
DEFERRABLE;

EXIT;
