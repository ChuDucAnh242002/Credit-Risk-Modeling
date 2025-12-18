/* proc datasets library=aml nolist; */
/* 	modify credit_card_client; */


data aml.credit_card_client_clean;
	set aml.credit_card_client;
	rename
		default_payment_next_month = default_payment_next_month;
run;