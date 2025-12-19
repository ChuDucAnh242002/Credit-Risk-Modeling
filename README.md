# Credit-Risk-Modeling

In this credit risk modeling project, the dataset will go through each steps to be analyzed if there are any suspicious activity related to Anti-Money Laundering.

## Dataset

The used dataset's name is Default of Card Clients, which consists of customers' default payments in Taiwan. The research aims for comparing the predictive accuracy of probability of default to determined whether clients are credible or not credible.

| Variable Name | Role    | Type    | Demographic     | Description                | Units | Missing Values |
| ------------- | ------- | ------- | --------------- | -------------------------- | ----- | -------------- |
| ID            | ID      | Integer |                 |                            |       | no             |
| X1            | Feature | Integer |                 | LIMIT_BAL                  |       | no             |
| X2            | Feature | Integer | Sex             | SEX                        |       | no             |
| X3            | Feature | Integer | Education Level | EDUCATION                  |       | no             |
| X4            | Feature | Integer | Marital Status  | MARRIAGE                   |       | no             |
| X5            | Feature | Integer | Age             | AGE                        |       | no             |
| X6            | Feature | Integer |                 | PAY_0                      |       | no             |
| X7            | Feature | Integer |                 | PAY_2                      |       | no             |
| X8            | Feature | Integer |                 | PAY_3                      |       | no             |
| X9            | Feature | Integer |                 | PAY_4                      |       | no             |
| X10           | Feature | Integer |                 | PAY_5                      |       | no             |
| X11           | Feature | Integer |                 | PAY_6                      |       | no             |
| X12           | Feature | Integer |                 | BILL_AMT1                  |       | no             |
| X13           | Feature | Integer |                 | BILL_AMT2                  |       | no             |
| X14           | Feature | Integer |                 | BILL_AMT3                  |       | no             |
| X15           | Feature | Integer |                 | BILL_AMT4                  |       | no             |
| X16           | Feature | Integer |                 | BILL_AMT5                  |       | no             |
| X17           | Feature | Integer |                 | BILL_AMT6                  |       | no             |
| X18           | Feature | Integer |                 | PAY_AMT1                   |       | no             |
| X19           | Feature | Integer |                 | PAY_AMT2                   |       | no             |
| X20           | Feature | Integer |                 | PAY_AMT3                   |       | no             |
| X21           | Feature | Integer |                 | PAY_AMT4                   |       | no             |
| X22           | Feature | Integer |                 | PAY_AMT5                   |       | no             |
| X23           | Feature | Integer |                 | PAY_AMT6                   |       | no             |
| Y             | Target  | Binary  |                 | default payment next month |       | no             |

Citation: I. Yeh. "Default of Credit Card Clients," UCI Machine Learning Repository, 2009. [Online]. Available: https://doi.org/10.24432/C55S3H.

## Analysis Overview

Using the provided dataset, month-to-month percentage changes in bill amounts (X12-X17) and payment payment amounts (X18-X23). Sudden spikes or drops can be suspicious.
Then the utilization ratio are created by calculating (Bill Amount / Credit Limit). Consistently high or rapidly increasing utilization can indicate "bust-out" situation. This results to "bust-out" alert
If the consistent low payment is followed by the high payment, which is a sudden rapid change, results to a steeper alert.

Here are the first 20 observations with Key AML features retrieved from reports/enhanced_data.csv

| DEFAULT_PAYMENT_NEXT_MONTH | LIMIT_BAL | AGE | bust_out_alert | sleeper_alert |
| -------------------------- | --------- | --- | -------------- | ------------- |
| 1                          | 20000     | 24  | 0              | 0             |
| 1                          | 120000    | 26  | 0              | 0             |
| 0                          | 90000     | 34  | 0              | 0             |
| 0                          | 50000     | 37  | 0              | 0             |
| 0                          | 50000     | 57  | 0              | 0             |
| 0                          | 50000     | 37  | 0              | 0             |
| 0                          | 500000    | 29  | 0              | 0             |
| 0                          | 100000    | 23  | 0              | 0             |
| 0                          | 140000    | 28  | 0              | 0             |
| 0                          | 20000     | 35  | 0              | 0             |
| 0                          | 200000    | 34  | 0              | 0             |
| 0                          | 260000    | 51  | 0              | 0             |
| 0                          | 630000    | 41  | 0              | 0             |
| 1                          | 70000     | 30  | 0              | 0             |
| 0                          | 250000    | 29  | 0              | 0             |
| 0                          | 50000     | 23  | 1              | 0             |
| 1                          | 20000     | 24  | 0              | 0             |
| 0                          | 320000    | 49  | 0              | 0             |
| 0                          | 360000    | 49  | 0              | 0             |
| 0                          | 180000    | 29  | 0              | 0             |

## Rule creations

Using the data enhanced, rules are created with different specifications.

- Rule 1: Potential Bust-Out Fraud
  This rule will trigger when bust-out score >= 3, maximum of util > 0.85 and the delay payment is more than 1 month

- Rule 2: Structuring pattern
  This rule wil trigger when the payment is rounded more than 3 times, payment is delayed more than 1 month, and the account credit limit is more than 100000

- Rule 3: Sleeper Acount Activation
  This rule will trigger when the first util is more than 0.8 and first payment is more than 0.

## Results

| LIMIT_BAL | util_max | payment_profile | bust_out_score | round_payment_count | delay_count | alert_type_1   | alert_type_2      | alert_type_3  |
| --------- | -------- | --------------- | -------------- | ------------------- | ----------- | -------------- | ----------------- | ------------- |
| 120000    | 0.02879  | Volatile        | 2              | 6                   | 2           |                | Structuring Alert |               |
| 200000    | 0.00794  | Volatile        | 0              | 5                   | 5           |                | Structuring Alert |               |
| 200000    | 0.76260  | Volatile        | 0              | 5                   | 2           |                | Structuring Alert |               |
| 130000    | 0.07932  | Volatile        | 1              | 3                   | 2           |                | Structuring Alert |               |
| 480000    | 1.01472  | Volatile        | 1              | 3                   | 2           |                | Structuring Alert |               |
| 280000    | 0.54348  | Always Delayed  | 1              | 3                   | 6           |                | Structuring Alert |               |
| 240000    | 0.05899  | Volatile        | 0              | 3                   | 3           |                | Structuring Alert |               |
| 200000    | 0.98618  | Volatile        | 2              | 4                   | 2           |                | Structuring Alert |               |
| 130000    | 0.55997  | Always Delayed  | 1              | 5                   | 6           |                | Structuring Alert |               |
| 20000     | 1.08515  | Always Delayed  | 3              | 5                   | 6           | Bust-Out Alert |                   |               |
| 30000     | 0.99453  | Volatile        | 2              | 3                   | 3           |                |                   | Sleeper Alert |
| 140000    | 0.19576  | Volatile        | 0              | 4                   | 2           |                | Structuring Alert |               |
| 360000    | 0.33399  | Deteriorating   | 1              | 3                   | 3           |                | Structuring Alert |               |
| 20000     | 0.95770  | Volatile        | 2              | 4                   | 2           |                |                   | Sleeper Alert |
| 190000    | 0.78975  | Volatile        | 1              | 4                   | 3           |                | Structuring Alert |               |
| 180000    | 0.03252  | Volatile        | 0              | 3                   | 2           |                | Structuring Alert |               |
| 200000    | 0.29992  | Volatile        | 0              | 5                   | 3           |                | Structuring Alert |               |
| 110000    | 0.53056  | Volatile        | 1              | 4                   | 3           |                | Structuring Alert |               |
| 200000    | 0.11605  | Volatile        | 1              | 4                   | 2           |                | Structuring Alert |               |
| 200000    | 0.12408  | Volatile        | 2              | 4                   | 2           |                | Structuring Alert |               |
