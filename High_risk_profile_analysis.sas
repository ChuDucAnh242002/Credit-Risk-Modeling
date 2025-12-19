proc means data=aml.credit_card_client_enhanced n mean std;
	where default_payment_next_month; /* High-risk accounts */
	var limit_bal age;
	class sex education marriage;
	title "Demographic Profile of High-Risk Accounts";
run;

proc print data=aml.aml_alerts (obs=20) noobs;
	var limit_bal util_max payment_profile
		bust_out_score round_payment_count delay_count
		alert_type_1 alert_type_2 alert_type_3;
	where total_alerts > 0;
	title "First 20 Observations of AML Alerts";
run;

proc report data=aml.aml_alerts nowd;
	where total_alerts > 0;
	column default_payment_next_month limit_bal age
		   util_max bust_out_score payment_profile
		   alert_type_1 alert_type_2 alert_type_3 total_alerts;
	define default_payment_next_month / "Default Status" width=8;
	define limit_bal / "Credit Limit" format=dollar12. width=12;
	define util_max / "Max Utilization" format=Percent8.2 width=12;
	define bust_out_score / "Risk Score" width=10;
	define total_alerts / "Total Alerts" width=10;
/* 	title = "Summary: Accounts with AML Alerts"; */
run;

