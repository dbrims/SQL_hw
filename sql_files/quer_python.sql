SELECT tr.date, tr.amount, tr.card, m.name, mc.name, credit_card.card_holder
FROM transactions AS tr
JOIN merchant AS m 
ON tr.merchant_id=m.id
JOIN merchant_catagory AS mc 
ON m.id_merchant_catagory=mc.id
JOIN credit_card on tr.card like 
CONCAT(SUBSTRING(CAST(CAST(credit_card.card AS BIGINT) AS VARCHAR(100)),1,4),'%')
WHERE credit_card.card_holder=3 OR credit_card.card_holder=18;

SELECT tr.date, tr.amount, tr.card, m.name, mc.name, credit_card.card_holder
FROM transactions AS tr
JOIN merchant AS m 
ON tr.merchant_id=m.id
JOIN merchant_catagory AS mc 
ON m.id_merchant_catagory=mc.id
JOIN credit_card on tr.card like 
CONCAT(SUBSTRING(CAST(CAST(credit_card.card AS BIGINT) AS VARCHAR(100)),1,4),'%')
WHERE credit_card.card_holder=25 AND (tr.date>'2018-01-01' AND tr.date<'2018-06-30');

SELECT tr.date, tr.amount, tr.card, m.name, mc.name, credit_card.card_holder
FROM transactions AS tr
JOIN merchant AS m 
ON tr.merchant_id=m.id
JOIN merchant_catagory AS mc 
ON m.id_merchant_catagory=mc.id
JOIN credit_card on tr.card like 
CONCAT(SUBSTRING(CAST(CAST(credit_card.card AS BIGINT) AS VARCHAR(100)),1,4),'%')
WHERE credit_card.card_holder=Rand1 OR credit_card.card_holder=Rand2 OR credit_card.card_holder=Rand3;

