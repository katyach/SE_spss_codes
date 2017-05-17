syntax tracker for spss
#first attempt at aggregation - worked for just the count.
#appending it to teh file did not work.

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

*OUTPATIENTS SEPARATED
