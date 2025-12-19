/* Descriptive statistics and exploratory data analysis */
proc print data=aml.credit_card_client_enhanced (obs=20) noobs;
	var default_payment_next_month limit_bal age bust_out_alert sleeper_alert;
	TITLE "First 20 Observations with Key AML Features";
run;

proc means data=aml.credit_card_client_enhanced n mean std min p25 p50 p75 max;
	var limit_bal age util1-util6 util_spike bust_out_score;
	class default_payment_next_month;
	title "Descriptive Statistics by Risk Status (Y)";
run;

proc freq data=aml.credit_card_client_enhanced;
	tables default_payment_next_month*bust_out_alert 
		   default_payment_next_month*sleeper_alert 
		   default_payment_next_month*payment_profile /CHISQ;
	title "Association between Default and AML Indicators";
run;

/* Correlation analysis */
proc corr data=aml.credit_card_client_enhanced nosimple;
	var default_payment_next_month;
	with limit_bal util_spike util_max delay_count severe_delay_count
		 round_payment_count bust_out_score;
	title "Correlation of AML Features with Default Status";
run;

/* Visualization of key patterns */
proc sgplot data = aml.credit_card_client_enhanced;
	histogram util_spike / Group=default_payment_next_month transparency=0.5;
	density util_spike / type=kernel group=default_payment_next_month;
	title "Distribution of Utilization Spike by Risk Status";
run;

proc sgplot data=aml.credit_card_client_enhanced;
	vbox bust_out_score / category=default_payment_next_month;
	title "Bust-Out Fraud Score by deafult Status";
run;

