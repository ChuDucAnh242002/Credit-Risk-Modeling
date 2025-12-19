/* Segmentation & Rule creation */
proc fastclus data=aml.credit_card_client_enhanced maxclusters=5 out=clusters;
	var limit_bal util_avg util_std delay_count round_payment_count;
	title "Cluster Analysis for Customer Segmentation";
run;

proc freq data=clusters;
	tables cluster*default_payment_next_month;
	title "Default Distribution across Clusters";
run;

/* Create rule-based alerts */
data aml.aml_alerts;
	set aml.credit_card_client_enhanced;
	
	/* Rule 1: Potential Bust-Out Fraud */
	if bust_out_score >= 3 and
	   util_max > 0.85 AND 
       severe_delay_count >= 1 THEN DO;
       alert_type_1 = "Bust-Out Alert";
       alert_score_1 = bust_out_score;
       rule_1_triggered = 1;
	end;
	else rule_1_triggered = 0;

	/* Rule 2: Structuring Pattern */
	if round_payment_count >= 3 and
		delay_count >= 2 and
		limit_bal > 100000 then do;
		alert_type_2 = "Structuring Alert";
        alert_score_2 = round_payment_count;
        rule_2_triggered = 1;
	end;
	else rule_2_triggered = 0;

	/* Rule 3: Sleeper Account Activation */
	if sleeper_alert = 1 and
	   	util1 > 0.8 and
	   	pay_1 > 0 then do
	   	alert_type_3 = "Sleeper Alert";
       	alert_score_3 = util1;
       	rule_3_triggered = 1;
	end;
	else rule_3_triggered = 0;

	total_alerts = sum(rule_1_triggered, rule_2_triggered, rule_3_triggered);
	
	keep default_payment_next_month limit_bal sex education marriage age alert: rule: total_alerts
		 bust_out_score util_max payment_profile round_payment_count delay_count; 
run;


	
	
	