proc means data=aml.credit_card_client_enhanced n mean std;
	where default_payment_next_month; /* High-risk accounts */
	var limit_bal age;
	class sex education marriage;
	title "Demographic Profile of High-Risk Accounts";
run;

/*
proc transpose data=aml.credit_card_client_enhanced out=status_long prefix=status;
	by default_payment_next_month;
	var pay_1-pay_6;
run;

proc sgplot data=status_long;
	series x=_name_ y=status1 / group=default_payment_next_month;
	xaxis lable="Month" values=('pay_1', 'pay_2', 'pay_3', 'pay_4', 'pay_5', 'pay_6');
	title "Average Repayment Status Trajectory by Risk Group";
run;
*/

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

