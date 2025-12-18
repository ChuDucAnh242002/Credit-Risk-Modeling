%let data_path=~/Project/Credit-Risk-Modeling/data/;
$let report_path=~/Project/Credit-Risk-Modeling/reports/;
libname aml "&data_path";

proc import datafile="&data/default_of_credit_card_clients.xls"
		dbms=xls out=aml.credit_card_client  replace;
run;
