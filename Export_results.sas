proc export data=aml.aml_alerts
	outfile="&reports/aml_alerts.csv"
	dbms=csv replace;
run;

proc export data=aml.credit_card_client_enhanced
	outfile="&reports/enhanced_data.csv"
	dbms=csv replace;
run;