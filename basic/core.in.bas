
REM DO_FUNCTION(F%, AR%)
DO_FUNCTION:
  REM Get the function number
  FF%=Z%(F%,1)

  REM Get argument values
  R%=AR%+1: GOSUB DEREF
  AA%=R%
  R%=Z%(AR%,1)+1: GOSUB DEREF
  AB%=R%

  REM Switch on the function number
  IF FF%=1 THEN DO_EQUAL_Q

  IF FF%=11 THEN DO_PR_STR
  IF FF%=12 THEN DO_STR
  IF FF%=13 THEN DO_PRN
  IF FF%=14 THEN DO_PRINTLN

  IF FF%=18 THEN DO_LT
  IF FF%=19 THEN DO_LTE
  IF FF%=20 THEN DO_GT
  IF FF%=21 THEN DO_GTE
  IF FF%=22 THEN DO_ADD
  IF FF%=23 THEN DO_SUB
  IF FF%=24 THEN DO_MULT
  IF FF%=25 THEN DO_DIV

  IF FF%=27 THEN DO_LIST
  IF FF%=28 THEN DO_LIST_Q

  IF FF%=45 THEN DO_EMPTY_Q
  IF FF%=46 THEN DO_COUNT

  IF FF%=58 THEN DO_PR_MEMORY
  IF FF%=59 THEN DO_PR_MEMORY_SUMMARY
  ER%=1: ER$="unknown function" + STR$(FF%): RETURN

  DO_EQUAL_Q:
    A%=AA%: B%=AB%: GOSUB EQUAL_Q
    R%=R%+1
    RETURN

  DO_PR_STR:
    AZ%=AR%: PR%=1: SE$=" ": GOSUB PR_STR_SEQ
    AS$=R$: GOSUB STRING
    Z%(ZI%,0) = 4
    Z%(ZI%,1) = R%
    R%=ZI%
    ZI%=ZI%+1
    RETURN
  DO_STR:
    AZ%=AR%: PR%=0: SE$="": GOSUB PR_STR_SEQ
    AS$=R$: GOSUB STRING
    Z%(ZI%,0) = 4
    Z%(ZI%,1) = R%
    R%=ZI%
    ZI%=ZI%+1
    RETURN
  DO_PRN:
    AZ%=AR%: PR%=1: SE$=" ": GOSUB PR_STR_SEQ
    PRINT R$
    R%=0
    RETURN
  DO_PRINTLN:
    AZ%=AA%: PR%=0: SE$=" ": GOSUB PR_STR
    PRINT R$
    R%=0
    RETURN

  DO_LT:
    R%=1
    IF Z%(AA%,1)<Z%(AB%,1) THEN R%=2
    RETURN
  DO_LTE:
    R%=1
    IF Z%(AA%,1)<=Z%(AB%,1) THEN R%=2
    RETURN
  DO_GT:
    R%=1
    IF Z%(AA%,1)>Z%(AB%,1) THEN R%=2
    RETURN
  DO_GTE:
    R%=1
    IF Z%(AA%,1)>=Z%(AB%,1) THEN R%=2
    RETURN

  DO_ADD:
    R%=ZI%: ZI%=ZI%+1: REM Allocate result value
    Z%(R%,0)=2
    Z%(R%,1)=Z%(AA%,1)+Z%(AB%,1)
    RETURN
  DO_SUB:
    R%=ZI%: ZI%=ZI%+1: REM Allocate result value
    Z%(R%,0)=2
    Z%(R%,1)=Z%(AA%,1)-Z%(AB%,1)
    RETURN
  DO_MULT:
    R%=ZI%: ZI%=ZI%+1: REM Allocate result value
    Z%(R%,0)=2
    Z%(R%,1)=Z%(AA%,1)*Z%(AB%,1)
    RETURN
  DO_DIV:
    R%=ZI%: ZI%=ZI%+1: REM Allocate result value
    Z%(R%,0)=2
    Z%(R%,1)=Z%(AA%,1)/Z%(AB%,1)
    RETURN

  DO_LIST:
    R%=AR%
    RETURN
  DO_LIST_Q:
    A%=AA%: GOSUB LIST_Q
    R%=R%+1: REM map to mal false/true
    RETURN

  DO_EMPTY_Q:
    R%=1
    IF Z%(AA%,1)=0 THEN R%=2
    RETURN
  DO_COUNT:
    R%=-1
    DO_COUNT_LOOP:
      R%=R%+1
      IF Z%(AA%,1)<>0 THEN AA%=Z%(AA%,1): GOTO DO_COUNT_LOOP
    Z%(ZI%,0) = 2
    Z%(ZI%,1) = R%
    R%=ZI%: ZI%=ZI%+1: REM Allocate result value
    RETURN

  DO_PR_MEMORY:
    GOSUB PR_MEMORY
    RETURN

  DO_PR_MEMORY_SUMMARY:
    GOSUB PR_MEMORY_SUMMARY
    RETURN

INIT_CORE_SET_FUNCTION:
  GOSUB NATIVE_FUNCTION
  V%=R%: GOSUB ENV_SET_S
  RETURN

REM INIT_CORE_NS(E%)
INIT_CORE_NS:
  REM create the environment mapping
  REM must match DO_FUNCTION mappings

  K$="=": A%=1: GOSUB INIT_CORE_SET_FUNCTION

  K$="pr-str": A%=11: GOSUB INIT_CORE_SET_FUNCTION
  K$="str": A%=12: GOSUB INIT_CORE_SET_FUNCTION
  K$="prn": A%=13: GOSUB INIT_CORE_SET_FUNCTION
  K$="println": A%=14: GOSUB INIT_CORE_SET_FUNCTION

  K$="<":  A%=18: GOSUB INIT_CORE_SET_FUNCTION
  K$="<=": A%=19: GOSUB INIT_CORE_SET_FUNCTION
  K$=">":  A%=20: GOSUB INIT_CORE_SET_FUNCTION
  K$=">=": A%=21: GOSUB INIT_CORE_SET_FUNCTION
  K$="+":  A%=22: GOSUB INIT_CORE_SET_FUNCTION
  K$="-":  A%=23: GOSUB INIT_CORE_SET_FUNCTION
  K$="*":  A%=24: GOSUB INIT_CORE_SET_FUNCTION
  K$="/":  A%=25: GOSUB INIT_CORE_SET_FUNCTION

  K$="list": A%=27: GOSUB INIT_CORE_SET_FUNCTION
  K$="list?": A%=28: GOSUB INIT_CORE_SET_FUNCTION

  K$="empty?": A%=45: GOSUB INIT_CORE_SET_FUNCTION
  K$="count": A%=46: GOSUB INIT_CORE_SET_FUNCTION

  K$="pr-memory": A%=58: GOSUB INIT_CORE_SET_FUNCTION
  K$="pr-memory-summary": A%=59: GOSUB INIT_CORE_SET_FUNCTION

  RETURN