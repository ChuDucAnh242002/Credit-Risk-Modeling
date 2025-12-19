data aml.credit_card_client_enhanced;
	set aml.credit_card_client;
	
	if age < 18 or age > 100 then age_flag = 1;
		else age_flag = 0;
	if limit_bal <= 0 then credit_flag = 1; 
		else credit_flag = 0;

	/* Bill amount velocity (percentage change) */
	/* Sudden spike or drop in bill percentage can be suspicious */
	array bill[6] bill_amt1-bill_amt6;
	array bill_pctchg[5];

	do i = 1 to 5;
		if bill[i+1] > 0 then
			bill_pctchg[i] = (bill[i] - bill[i+1]) / bill[i+1] * 100;
		else bill_pctchg[i] = .;
	end;

	array payment[6] pay_amt1-pay_amt6;
	array pay_pctchg[5];
		
	do i = 1 to 5;
		if payment[i+1] > 0 then
			pay_pctchg[i] = (payment[i] - payment[i+1]) / payment[i+1] * 100;
		else pay_pctchg[i] = .;
	end;

	/* Monthly utilization ration (Bill/Credit Limit)*/
	array util[6];
	do i = 1 to 6;
		if limit_bal > 0 then util[i] = bill[i] / limit_bal;
		else util[i] = .;
	end;

	/* Utilization trend and spikes */
	util_avg = mean(of util1-util6);
	util_std = std(of util1-util6);
	util_max = max(of util1-util6);

	/* Spike indicator: utilization increase > 50% in last month */
	if util1 > 0 and util2 > 0 then
		util_spike = (util1 - util2) / util2;
	else util_spike = .;

	util_spike_flag = (util_spike > 0.5);
	
	/* PAYMENT BEHAVIOR PATTERNS */
	/* Repayment status categories */
	array status[6] pay_1-pay_6;

	/* Count of delayed payments */
	delay_count = 0;
	severe_delay_count = 0; /* Delay > 2 months */

	do i = 1 to 6;
		if status[i] > 0 then delay_count + 1;
		if status[i] > 2 then severe_delay_count + 1;
	end;

	/* Payment behavior classification */
	length payment_profile $15;

	if delay_count = 0 then payment_profile = "Always Duly";
	else if delay_count = 6 then payment_profile = "Always Delayed";
	else if 
		status[1] >= status[2] and
		status[2] >= status[3] and
		status[3] >= status[4] and
		status[4] >= status[5] and
		status[5] >= status[6] and
		delay_count > 0 then 
		payment_profile = "Deteriorating";
	else if delay_count > 0 then payment_profile = "Volatile";
	else payment_profile = "Other";

	/* Structuring indicators */
	/* Round payment amounts analysis */
	array round_flags[6];
	do i = 1 to 6;
		/* Check for round payments (ending in 000 or 500) */
		round_flags[i] = (mod(payment[i], 1000) = 0 or
						 (mod(payment[i], 100) = 0 and payment[i] < 1000));
	end;

	round_payment_count = sum(of round_flags1-round_flags6);

	/* Bust-out fraud indicators */
	/* Rapid increase in utilization with delayed payments */
	bust_out_score = 0;
	if util_spike_flag = 1 then bust_out_score + 2;
	if pay_1 > 0 then bust_out_score + 1; /* Current delay */
	if severe_delay_count >= 2 then bust_out_score + 1;
	if util_max > 0.9 then bust_out_score + 1;

	bust_out_alert = (bust_out_score >= 3);

	/* Sleeper account indicators */
	/* Low activity followed by high activity*/
	if bill[6] < (limit_bal * 0.1) and bill[1] > (limit_bal * 0.7) then
		sleeper_alert = 1;
	else sleeper_alert = 0;

	drop i;
run;