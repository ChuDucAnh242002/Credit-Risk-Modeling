/* Predictive modeling for risk drivers */

/* Logistic Regression for interpretability */
proc logistic data=aml.credit_card_client_enhanced descending;
	class sex education marriage payment_profile;
	model default_payment_next_month = limit_bal age
									   util_spike util_max 
              						   delay_count severe_delay_count
              						   round_payment_count
              						   bust_out_score
									   education marriage age payment_profile
									   / selection=stepwise slentry=0.1 slstay=0.05;
	oddsratio limit_bal / cl=wald;
	oddsratio util_spike / cl=wald;
	output out=predicted P=pred_prob;
	title "Logistic Regression: Identifying Key AML Risk Drivers";
run;

/* Random Forest for Feature Importance */
proc hpforest data=aml.credit_card_client_enhanced;
	target default_payment_next_month / level=binary;
	input limit_bal age util_spike util_max delay_count severe_delay_count 
          round_payment_count bust_out_score / level=interval;
	input sex education marriage payment_profile / level=nominal;
    ods output VariableImportance=var_imp;
    title "Random Forest: Variable Importance for AML Risk";
RUN;
