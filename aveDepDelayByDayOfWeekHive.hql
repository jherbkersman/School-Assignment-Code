create table temp_flights(tf string);

LOAD DATA INPATH '/user/maria_dev/wholeEnchilada.csv' OVERWRITE INTO TABLE temp_flights;

select * from temp_flights limit 10;

CREATE TABLE flights (DayOfWeek STRING, depDelay STRING);

insert overwrite table flights
SELECT 
     regexp_extract(tf, '^(?:([^,]*),?){4}', 1) dayOfWeek,
     regexp_extract(tf, '^(?:([^,]*),?){16}', 1) depDelay
from temp_flights;

select * from flights limit 10;

SELECT dayOfWeek, count(depDelay), sum(depDelay), sum(depDelay)/count(depDelay) FROM flights where depDelay != 'NA' GROUP BY dayOfWeek;

SELECT concat(dayOfWeek, ',', count(depDelay), ',', sum(depDelay), ',' ,sum(depDelay)/count(depDelay)) FROM flights where depDelay != 'NA' GROUP BY dayOfWeek;