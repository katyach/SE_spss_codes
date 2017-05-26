*Syntax for work with exercise variables.

*1. recoded strength variables into new coding, using the lower limit of time interval: none/0, about 15 min, at least 30 min, at least 60 min, at least 180 min.
*15 was selected, because it was more accurate in categorization. 

recode BaselineExerciseBehaviorStretchingorStrengtheningTotal#ofMinutes  (0=copy) (1 thru 29=15) (30 thru 59=30) (60 thru 179=60) (180 thru highest = 180) into baseline_strenght_low.
execute.
recode PostExerciseBehaviorStretchingorStrengtheningTotal#ofMinutes (0=copy) (1 thru 29=15) (30 thru 59=30) (60 thru 179=60) (180 thru highest = 180) into strenght2_low.
execute.
recode @6MonthExerciseBehaviorStretchingorStrengtheningTotal#ofMinutes (0=copy) (1 thru 29=15) (30 thru 59=30) (60 thru 179=60) (180 thru highest = 180) into strenght3_low.
execute.
recode @12MonthExerciseBehaviorStretchingorStrengtheningTotal#ofMinutes (0=copy) (1 thru 29=15) (30 thru 59=30) (60 thru 179=60) (180 thru highest = 180) into strenght4_low.
execute.
*
The recode was done on the "long-format" file, where all timepoint variables were combined into 1, and the file then returned into wide form. Baseline coding is shown above, other timepoints were recoded following the same format.
recode 
ExerciseBehaviorWalk
ExerciseBehaviorSwimmingorAquatic
ExerciseBehaviorBicycling
ExerciseBehaviorOtherAerobicExerciseEquipe.g.Stairmaster
OtherAerobic 
(0=copy) (1 =15) (2=30) (3=60) (4= 180) into
Walk1_low
Swimming1_low
Bicycling1_low
Equipe1_low
OtherAero1_low. 
execute.

*computing total minimum amount of aerobic exercise. The coding was verified by crosstab. 
COMPUTE aero_LL_sum=SUM(Walk1_low,Swimming1_low,Bicycling1_low,Equipe1_low,OtherAero1_low).
EXECUTE.
recode aero_LL_sum (0=copy) (1 thru 29=15) (30 thru 59=30) (60 thru 179=60) (180 thru highest = 180) into aero_LL_cat_final.
EXECUTE.
crosstabs  aero_LL_sum by aero_LL_cat_final.

*The same steps were repeated with other variables, plus a crosstabl check on one variable. 
recode 
ExerciseBehaviorWalk_A
ExerciseBehaviorSwimmingorAquatic_A
ExerciseBehaviorBicycling_A
ExerciseBehaviorOtherAerobicExerciseEquipe.g.Stairmaster_A
OtherAerobicExercise
ExerciseBehaviorWalk_B
ExerciseBehaviorSwimmingorAquatic_B
ExerciseBehaviorBicycling_B
ExerciseBehaviorOtherAerobicExerciseEquipe.g.Stairmaster_B
ExerciseBehaviorOtherAerobic
ExerciseBehaviorWalk_C
ExerciseBehaviorSwimmingorAquatic_C
ExerciseBehaviorBicycling_C
ExerciseBehaviorOtherAerobicExerciseEquipe.g.Stairmaster_C
ExerciseBehaviorOtherAerobic_A 
(0=copy) (1 =15) (2=30) (3=60) (4= 180) into
Walk2_low
Swimming2_low
Bicycling2_low
Equipe2_low
OtherAero2_low
Walk3_low
Swimming3_low
Bicycling3_low
Equipe3_low
OtherAero3_low
Walk4_low
Swimming4_low
Bicycling4_low
Equipe4_low
OtherAero4_low. 
execute.

CROSSTABs Walk3_low by ExerciseBehaviorWalk_B.

*total aerobic activity (had to be sum for easier combination). Using the lower limit allows for a more accurate combination of categories via compute-recode, eben if the numbers mean "at least so much exercise". 
*for accuracy, it is important to use the "SUM function" and not just addition.
COMPUTE aero_2_sum=SUM(Walk2_low,Swimming2_low,Bicycling2_low,Equipe2_low,OtherAero2_low).
EXECUTE.
COMPUTE aero_3_sum=SUM(Walk3_low,Swimming3_low,Bicycling3_low,Equipe3_low,OtherAero3_low).
EXECUTE.
COMPUTE aero_4_sum=SUM(Walk4_low,Swimming4_low,Bicycling4_low,Equipe4_low,OtherAero4_low).
EXECUTE.
*looking at the frequency of responses allowed to see if the categories will fit neatly. 
frequencies variables aero_2_sum aero_3_sum aero_4_sum.

*recoding total aero into categories.
recode aero_2_sum aero_3_sum aero_4_sum (0=copy) (1 thru 29=15) (30 thru 59=30) (60 thru 179=60) (180 thru highest = 180) into aero_pp_cat aero_6m_cat aero_12m_cat.
EXECUTE.

*compute total exercise, based on categories. results verified.COMPUTE function is used to look at total minimum amount of exercise and some categories that could be questionable were verified. 
compute baseline_exercise_sum=SUM(aero_LL_cat_final,baseline_strenght_low).
compute post_exercise_sum=SUM(aero_pp_cat,strenght2_low).
compute exercise6mo_sum =SUM(aero_6m_cat,strenght3_low).
compute exercise12mo_sum =SUM(aero_12m_cat,strenght4_low).

*categorizing total exercise at each timepoint into same categories.
recode baseline_exercise post_exercise exercise6mo exercise12mo (0=copy) (1 thru 29=15) (30 thru 59=30) (60 thru 179=60) (180 thru highest = 180) into baseline_exercise_short pp_exercise_short  exercise_6m_short exercise_12m_short.
EXECUTE.

*assigning variable labels for categories.
VALUE LABELS baseline_strenght_low  strenght2_low  strenght3_low strenght4_low  Walk1_low  Swimming1_low  Bicycling1_low  Equipe1_low  OtherAero1_low  Walk2_low  Swimming2_low Bicycling2_low Equipe2_low 
OtherAero2_low  Walk3_low  Swimming3_low  Bicycling3_low  Equipe3_low  OtherAero3_low  Walk4_low Swimming4_low Bicycling4_low Equipe4_low OtherAero4_low aero_LL_cat_final aero_pp_cat aero_6m_cat
aero_12m_cat baseline_exercise_short pp_exercise_short  exercise_6m_short exercise_12m_short
  0 'Reported no exercise'
 15 'less then 30 min per week'
 30 '30 min to 60 min per week'
 60 '1h to 3h of exercise per week'
 180 'At leaset 3h of exercise per week'.

*identifying last observation carried forward for total exercise.Recoding checked manually.
COMPUTE Last_exercise_6m12m = 0.
do IF sysmis ( exercise_12m_short). 
RECODE exercise_6m_short (ELSE=Copy) INTO Last_exercise_6m12m .
ELSE IF exercise_12m_short GE 0.
RECODE exercise_12m_short (ELSE=Copy) INTO Last_exercise_6m12m.
end if.
EXECUTE.

*computing difference between baseline exercise and last observation carried forward.
if ( Last_exercise_6m12m> baseline_exercise_short) exer_maintenance=2.
execute.
if ( Last_exercise_6m12m< baseline_exercise_short) exer_maintenance=1.
execute.
if ( Last_exercise_6m12m=baseline_exercise_short) exer_maintenance=0.
execute.
*a category for those who did not exercise did not exercise at all at both time points.
if (baseline_exercise_short=0 AND  Last_exercise_6m12m=0) exer_maintenance=10.
execute.
*special category for those who reported no exercise at baseline, but was exercising at 6 or 12 mo.
if  (baseline_exercise_short=0 AND  Last_exercise_6m12m>0)  exer_maintenance=12.
execute.
Exercise categories final. 
recode exer_maintenance (0=copy) (2=copy) (12=2) (1=copy) (10=1) into exer_maintenance_final.
execute.


