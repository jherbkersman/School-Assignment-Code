create table temp_flights(tf string);

LOAD DATA INPATH '/user/maria_dev/testDataNoHdr.csv' OVERWRITE INTO TABLE temp_flights;

select * from temp_flights limit 10;

CREATE TABLE flights (Carrier STRING, arrDelay STRING);

insert overwrite table flights
SELECT 
     regexp_extract(tf, '^(?:([^,]*),?){9}', 1) carrier,
     regexp_extract(tf, '^(?:([^,]*),?){15}', 1) arrDelay
from temp_flights;

select * from flights limit 10;

SELECT carrier, count(arrDelay), sum(arrDelay), sum(arrDelay)/count(arrDelay) FROM flights where arrDelay != 'NA' GROUP BY carrier;

SELECT concat(carrier, ',', count(arrDelay), ',', sum(arrDelay), ',' ,sum(arrDelay)/count(arrDelay)) FROM flights where arrDelay != 'NA' GROUP BY carrier;