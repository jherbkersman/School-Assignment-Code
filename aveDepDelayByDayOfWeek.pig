flights = load 'wholeEnchilada.csv' using PigStorage(',');
flight_details = FOREACH flights GENERATE $3 as day, (int)$15 AS depDelay;
grp_day = GROUP flight_details by day;
aveDepDelay= foreach grp_day generate group, AVG(flight_details.depDelay);
store aveDepDelay into 'Pig_day_AveDepDelay';