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

| Obs | DEFAULT_PAYMENT_NEXT_MONTH | LIMIT_BAL | AGE | bust_out_alert | sleeper_alert |
| --- | -------------------------- | --------- | --- | -------------- | ------------- |
| 1   | 1                          | 20000     | 24  | 0              | 0             |
| 2   | 1                          | 120000    | 26  | 0              | 0             |
| 3   | 0                          | 90000     | 34  | 0              | 0             |
| 4   | 0                          | 50000     | 37  | 0              | 0             |
| 5   | 0                          | 50000     | 57  | 0              | 0             |
| 6   | 0                          | 50000     | 37  | 0              | 0             |
| 7   | 0                          | 500000    | 29  | 0              | 0             |
| 8   | 0                          | 100000    | 23  | 0              | 0             |
| 9   | 0                          | 140000    | 28  | 0              | 0             |
| 10  | 0                          | 20000     | 35  | 0              | 0             |
| 11  | 0                          | 200000    | 34  | 0              | 0             |
| 12  | 0                          | 260000    | 51  | 0              | 0             |
| 13  | 0                          | 630000    | 41  | 0              | 0             |
| 14  | 1                          | 70000     | 30  | 0              | 0             |
| 15  | 0                          | 250000    | 29  | 0              | 0             |
| 16  | 0                          | 50000     | 23  | 1              | 0             |
| 17  | 1                          | 20000     | 24  | 0              | 0             |
| 18  | 0                          | 320000    | 49  | 0              | 0             |
| 19  | 0                          | 360000    | 49  | 0              | 0             |
| 20  | 0                          | 180000    | 29  | 0              | 0             |

## Results
