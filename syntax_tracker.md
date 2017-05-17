                                    syntax tracker for spss
#first attempt at aggregation - worked for just the count.
*!appending it to teh file did not work.

DATASET ACTIVATE DataSet1.
SORT CASES BY ID(A) DATE_BEHIND(A) UTILIZATION(A).

AGGREGATE
  /OUTFILE='M:\ARES\Projects\BCBH\Supervised Exercise\DIMR files\inpatient_aggr.sav'
  /PRESORTED
  /BREAK=ID UTILIZATION
  /N_BREAK=N.

GET 
  FILE='M:\ARES\Projects\BCBH\Supervised Exercise\DIMR files\inpatient_aggr.sav'. 
DATASET NAME DataSet2 WINDOW=FRONT.

RENAME VARIABLES (N_BREAK=N_Hospitalizations). 

              *OUTPATIENTS SEPARATED by ED and general.
*outpatients - just ED visits - aggregated and removed "others".

SORT CASES BY ID(A) DATE_BEHIND(A) UTILIZATION(A) ABSTRACT_TYPE(A).

AGGREGATE
  /OUTFILE='M:\ARES\Projects\BCBH\Supervised Exercise\DIMR files\outpatient_aggr.sav'
  /PRESORTED
  /BREAK=ID UTILIZATION ABSTRACT_TYPE
  /N_BREAK=N.

GET 
  FILE='M:\ARES\Projects\BCBH\Supervised Exercise\DIMR files\outpatient_aggr.sav'. 
DATASET NAME DataSet2 WINDOW=FRONT.

select if ABSTRACT_TYPE EQ 'E'.
execute.

RENAME VARIABLES (N_BREAK=N_EDvisits). 
DELETE VARIABLES ABSTRACT_TYPE.

*outpatients - all NACRS visits.
SORT CASES BY ID(A) DATE_BEHIND(A) UTILIZATION(A) 
AGGREGATE
  /OUTFILE='M:\ARES\Projects\BCBH\Supervised Exercise\DIMR files\nacrs_aggr.sav'
  /PRESORTED
  /BREAK=ID UTILIZATION 
  /N_BREAK=N.

RENAME VARIABLES (N_BREAK=N_NACRSvisits). 

*merging all and ED visits - NACRS file is a keyed table.
SORT CASES BY ID(A) UTILIZATION(A). 

DATASET ACTIVATE DataSet2.
MATCH FILES /FILE=*
  /TABLE='DataSet4'
  /BY ID UTILIZATION.
EXECUTE.
*Resulting file - nacrs_aggr has both. 


