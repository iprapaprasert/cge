%path = @runpath
cd %path
include les_noprice

%goods = "cropsforestry livestock fishery food bevtobacco textile paper chemical petroleum rubplastic nonmetallic fabmetal machinery othermanu electwater housing trade resthotel transportcomm bankinsur servicesoth"

wfopen ses_expend

smpl @all 

' Create equivalisation for demographic translating
series demog = @recode(n_adults <> 0, 1 + 0.5*(n_adults - 1) + 0.3*n_kids, 1 + 0.3*(n_kids - 1))
series eqexpend = expend / demog

smpl @all if not(quintile = 1 and eqexpend > 60000) and not(quintile = 3 and eqexpend > 400000)
freeze(expand_xtab) expend.statby(max, min) quintile
freeze(eqexpand_xtab) eqexpend.statby(max, min) quintile
delete demog

call les("w_1 w_2 w_4 w_6 w_7 w_8 w_9 w_10 w_11 w_12 w_13 w_15 w_16 w_17 w_18 w_19 w_20 w_21 w_22 w_23 w_25", "@all if quintile = 1 and eqexpend <= 60000", "weight", -7, "expend", "n_kids n_adults", %goods)
delete ls_* demog
rename w_stats w_stats_q1
rename summary summary_q1
rename marshallian marshallian_q1
rename slutsky slutsky_q1

call les("w_1 w_2 w_4 w_6 w_7 w_8 w_9 w_10 w_11 w_12 w_13 w_15 w_16 w_17 w_18 w_19 w_20 w_21 w_22 w_23 w_25", "@all if quintile = 2", "weight", -4, "expend", "n_kids n_adults", %goods)
delete ls_* demog
rename w_stats w_stats_q2
rename summary summary_q2
rename marshallian marshallian_q2
rename slutsky slutsky_q2

call les("w_1 w_2 w_4 w_6 w_7 w_8 w_9 w_10 w_11 w_12 w_13 w_15 w_16 w_17 w_18 w_19 w_20 w_21 w_22 w_23 w_25", "@all if quintile = 3 and eqexpend <= 400000", "weight", -3.5, "expend", "n_kids n_adults", %goods)
delete ls_* demog
rename w_stats w_stats_q3
rename summary summary_q3
rename marshallian marshallian_q3
rename slutsky slutsky_q3


call les("w_1 w_2 w_4 w_6 w_7 w_8 w_9 w_10 w_11 w_12 w_13 w_15 w_16 w_17 w_18 w_19 w_20 w_21 w_22 w_23 w_25", "@all if quintile = 4", "weight", -3, "expend", "n_kids n_adults", %goods)
delete ls_* demog
rename w_stats w_stats_q4
rename summary summary_q4
rename marshallian marshallian_q4
rename slutsky slutsky_q4


call les("w_1 w_2 w_4 w_6 w_7 w_8 w_9 w_10 w_11 w_12 w_13 w_15 w_16 w_17 w_18 w_19 w_20 w_21 w_22 w_23 w_25", "@all if quintile = 5", "weight", -2.5, "expend", "n_kids n_adults", %goods)
delete ls_* demog
rename w_stats w_stats_q5
rename summary summary_q5
rename marshallian marshallian_q5
rename slutsky slutsky_q5

' Create summary table
!num_goods = @wcount(%goods) + 1
table(@wcount(%goods) + 1, 16) summary

!h = 1
%heads = " Good IncomeElast_q1 IncomeElast_q2 IncomeElast_q3 IncomeElast_q4 IncomeElast_q5 Marshallian_q1 Marshallian_q2 Marshallian_q3 Marshallian_q4 Marshallian_q5 Slutsky_q1 Slutsky_q2 Slutsky_q3 Slutsky_q4 Slutsky_q5"
for %head {%heads}
	summary(1,!h) = %head
	!h = !h + 1
next
for !i=1 to 5
	!j = !i+1
	!k = !i+6
	!l = !i+11
	summary_q!i.copyrange 2 1 !num_goods 1 summary 2 1
	summary_q!i.copyrange 2 8 !num_goods 8 summary 2 !j
	summary_q!i.copyrange 2 9 !num_goods 9 summary 2 !k
	summary_q!i.copyrange 2 10 !num_goods 10 summary 2 !l
next


