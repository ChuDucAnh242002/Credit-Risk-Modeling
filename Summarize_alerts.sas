/* Summary of alerts */
proc tabulate data=aml.aml_alerts;
	class default_payment_next_month;
	var rule_1_triggered rule_2_triggered rule_3_triggered total_alerts;
	table default_payment_next_month ALL,
		  (rule_1_triggered rule_2_triggered rule_3_triggered)*MEAN*F=8.3
		  total_alerts*SUM;
	title "AML Alert Statistics by Default Status";
run;