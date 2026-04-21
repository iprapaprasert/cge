subroutine les(string %goods, string %smpl, string %pweight, scalar !frisch, string %exp, string %demog, string %labels)
	' Estimates the LES with no price variability
	
	' Parameters:
	'' goods : expenditure shares of the goods, must be positive, sum to one
	'' smpl : sample
	'' pweight : probability weight
	'' frisch : calibrated Frisch parameter
	'' exp : total expenditure
	'' demog : two series identify number of kids (age < 14) and number of adults (age >= 14), respectively
	'' labels : labels for goods
	
	' To calibrated Frisch parameter, verify that
	'' 1) sum of alpha = 0
	'' 2) beta > 0, sum of beta = 1
	'' 3) subsistence demand are all positive
	'' 4) subsistence demand to income less than one and positive
	'' 5) income elasticities > 0
	'' 6) -1 < Marshallian own-price elasticities < 0
	'' 7) Marshallian cross-price elasticities < 0
	'' 8) Slutsky own-price elasticities > Marshallian own-price elasticities
	'' 9) main diagonal elements of the Slutsky matrix are negative, whereas its off-diagonal elements are positive
	'' the intuition of Frisch parameter is -income / supernumerary expenditure
	
	' Examples:
	'' %exp = "expfd"
	'' %goods = "w_dairy w_proteins w_fruitveg w_flours w_misc"
	'' %demog = "n_kids n_adults"
	'' %labels = "dairy proteins fruitveg flours misc"
	'' %pweight = ""
	'' %smpl = ""
	'' !frisch = -2

	'============================================================'

	if @isempty(%smpl) then
		smpl @all
	else
		smpl {%smpl}
	endif
	
	' Assertion
	if @wcount(%labels) <> @wcount(%goods) then
    	@uiprompt("Error: Number of goods do not match with number of labels", "O", "CB")
		return
	endif
	
	'' Verify the sum of expenditure shares equal to one
	%sum = ""
	for %good {%goods} 
		%sum = %sum + " + " + %good 
	next
	if @abs(@mean({%sum}) - 1) > 1e-06 then
		@uiprompt("Error: Sum of expenditure shares does not equal to one ", "O", "CB")
		return
	endif
	
	' Check average budget share
	group w {%goods}
	freeze(w_stats) w.stats
	
	' Create summary table
	table(@wcount(%goods) + 1, 10) summary
	!h = 1
	%heads = "Good alpha beta BudgetShare MarginalShare SubsistenceToIncome SubsistenceToTotal IncomeElast Marshallian Slutsky"
	for %head {%heads}
		summary(1,!h) = %head
		!h = !h + 1
	next

	' Create equivalisation for demographic translating
	if @wcount(%demog) = 2 then
		%nkids = @word(%demog, 1)
		%nadults = @word(%demog, 2)
		series demog = @recode({%nadults} <> 0, 1 + 0.5*({%nadults} - 1) + 0.3*{%nkids}, 1 + 0.3*({%nkids} - 1))
	else ' no demographic variables
		series demog = 1
	endif
	
	' Linear expenditure system without price variability
	coef(@wcount(%goods)) alpha
	coef(@wcount(%goods)) beta
	
	vector(@wcount(%goods)) sub_exp
	matrix(@wcount(%goods), @wcount(%goods)) marshallian
	matrix(@wcount(%goods), @wcount(%goods)) slutsky
	
	if @wcount(%labels) = @wcount(%goods) then
		sub_exp.setrowlabels {%labels}
		marshallian.setrowlabels {%labels} 
		marshallian.setcollabels {%labels} 
		slutsky.setrowlabels {%labels}
		slutsky.setcollabels {%labels}
	endif
	
	'' Step 1: run regression to get alpha and beta
	for !i=1 to @wcount(%goods)
		%cur_good = @word(%goods, !i)
		if @wcount(%labels) = @wcount(%goods) then
			summary(!i+1, 1) = @word(%labels, !i)
		else
			summary(!i+1, 1) =  %cur_good
		endif
		''' expenditure value on goods i
		if @isempty(%pweight) then
			equation ls_{%cur_good}.ls {%cur_good}*({%exp}/demog) = alpha(!i) + beta(!i)*({%exp}/demog)
		else ' have a probability weight
			equation ls_{%cur_good}.ls(w={%pweight}, wtype=ivar, wscale=avg, cov=white) {%cur_good}*({%exp}/demog) = alpha(!i) + beta(!i)*({%exp}/demog)
		endif
	next
	
	for !i=1 to @wcount(%goods)
		%cur_good = @word(%goods, !i)
	
		''' Step 1.5: add alpha, beta to summary
		summary(!i+1, 2) = alpha(!i)
		summary(!i+1, 3) = beta(!i)
		summary(!i+1, 5) = beta(!i)
	
		''' Step 2: identify the subsistence parameters
		sub_exp(!i) = alpha(!i) + beta(!i)*@mean({%exp})*(1 + 1/!frisch)
	next
	
	'' Subsistence proportion
	for !i=1 to @wcount(%goods)
		''' Step 2.5: add subsistence to summary
		''' add subsistence to income to summary
		!s_i = sub_exp(!i) / @mean({%exp})
		summary(!i+1, 6) = !s_i
		''' add subsistence to total to summary
		summary(!i+1, 7) = sub_exp(!i) / @sum(sub_exp)
	
		''' Step 3: calculate budget share (w)
		''' add average budget share
		!r = (@mean({%exp}) - @sum(sub_exp)) / @mean({%exp})
		!w_i = !s_i + beta(!i)*!r  
		summary(!i+1, 4) = !w_i
	next
	
	'' Elasticities
	for !i=1 to @wcount(%goods)	
		!s_i = summary.@val(!i+1, 6)
		!w_i = summary.@val(!i+1, 4)
		''' Step 4: income elasticities
		summary(!i+1, 8) = beta(!i) / !w_i
	
		''' Step 5: price elasticities
		for !j=1 to @wcount(%goods)
			if !i = !j then
				!kronecker = 1
			else
				!kronecker = 0
			endif 
			!s_j = summary.@val(!j+1, 6)
			!w_j = summary.@val(!j+1, 4)
			marshallian(!i, !j) = !kronecker * (!s_i/!w_i - 1) - beta(!i)/!w_i*!s_j
			slutsky(!i, !j) = !kronecker * (!s_i/!w_i - 1) + beta(!i)/!w_i*(!w_j - !s_j)
		next
		''' add Marshallian
		summary(!i+1, 9) = marshallian(!i, !i)
		''' add Slutsky
		summary(!i+1, 10) = slutsky(!i, !i)
	next
	summary.setjust(1, B, @wcount(%goods) + 1, J) middle right
endsub

' end of program


