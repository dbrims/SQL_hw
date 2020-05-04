ALTER TABLE merchant_catagory
RENAME COLUMN name TO cat_name;

SELECT t.date, t.amount, t.card, cc.card_holder
FROM transactions AS t
JOIN credit_card AS cc on t.card like 
CONCAT(SUBSTRING(CAST(CAST(cc.card AS BIGINT) AS VARCHAR(100)),1,4),'%')
ORDER BY cc.card_holder;



--many of these transactions are from bars/pubs, which this early in the morning would raise a red flag
SELECT t.id, t.date, t.amount, t.card, m.name, mc.cat_name
FROM transactions AS t
JOIN merchant AS m ON t.merchant_id=m.id
	JOIN merchant_catagory as mc ON m.id_merchant_catagory=mc.id
WHERE CAST(date AS TIME)>'07:00:00' AND CAST(date AS TIME)<'09:00:00'
ORDER BY amount
LIMIT 100;

-- just from card usage it is hard to tell if any of the transactions are fraud
SELECT card, COUNT(amount)
FROM transactions
WHERE amount<=2.00
GROUP BY card
ORDER BY COUNT(amount);


-- again just looking at the name of the merchant does not help to identify fraud
-- but if we look at both name and category, we see the top number of small transactions
-- are at a bar which again raises a red flag.  
SELECT m.name, COUNT(amount)
FROM transactions as t
JOIN merchant AS m ON t.merchant_id=m.id
WHERE amount<=2.00
GROUP BY m.name
ORDER BY COUNT(amount) DESC
LIMIT 5;


SELECT m.name,  mc.cat_name, COUNT(amount)
FROM transactions AS t
JOIN merchant AS m ON t.merchant_id=m.id
JOIN merchant_catagory as mc ON m.id_merchant_catagory=mc.id
WHERE amount<=2.00
GROUP BY  mc.cat_name, m.name
ORDER BY COUNT(amount) DESC, m.name;

SELECT t.card,  mc.cat_name, COUNT(amount)
FROM transactions as t
JOIN merchant AS m ON t.merchant_id=m.id
JOIN merchant_catagory AS mc ON m.id_merchant_catagory=mc.id
WHERE amount<=2.00
GROUP BY t.card,  mc.cat_name
ORDER BY t.card;

CREATE VIEW merch_joined AS
	SELECT t.id, t.date, t.amount, t.card, m.name,  mc.cat_name
	FROM transactions AS t
	JOIN merchant AS m ON t.merchant_id=m.id
		JOIN merchant_catagory as mc ON m.id_merchant_catagory=mc.id;
		
SELECT *
FROM merch_joined
WHERE CAST(date AS TIME)>'07:00:00' AND CAST(date AS TIME)<'09:00:00'
ORDER BY amount
LIMIT 100;

-- just from card usage it is hard to tell if any of the transactions are fraud
SELECT card, COUNT(amount)
FROM merch_joined
WHERE amount<=2.00
GROUP BY card
ORDER BY COUNT(amount);


-- again just looking at the name of the merchant does not help to identify fraud
-- but if we look at both name and category, we see the top number of small transactions
-- are at a bar which again raises a red flag.  
SELECT name, COUNT(amount)
FROM merch_joined
WHERE amount<=2.00
GROUP BY name
ORDER BY COUNT(amount) DESC
LIMIT 5;


SELECT name,  cat_name, COUNT(amount)
FROM merch_joined
WHERE amount<=2.00
GROUP BY  cat_name, name
ORDER BY  COUNT(amount) DESC, name;

SELECT card,  cat_name, COUNT(amount)
FROM merch_joined
WHERE amount<=2.00
GROUP BY card, cat_name
ORDER BY card;

