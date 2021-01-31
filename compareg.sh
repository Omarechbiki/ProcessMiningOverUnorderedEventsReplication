#!/bin/bash
# compare graphs Buffer
FLINK="/home/omar/flink/flink-1.12.1/bin/flink run -c"
BUFFEREDOUTOFORDERRUNNER="ee.ut.cs.dsg.miner.example.pipeline.BufferedOutOfOrderRunner"
BUFFEREDOOOUNAWARERUNNER="ee.ut.cs.dsg.miner.example.pipeline.BufferedOOOUnawareRunner"
GRAPHACCURRACYCOMPARATOR="ee.ut.cs.dsg.miner.example.pipeline.GraphAccurracyComparator"
OOOUNAWARERUNNER="ee.ut.cs.dsg.miner.example.pipeline.OOOUnawareRunner"
SPECULATIVEOUTOFORDERRUNNER="ee.ut.cs.dsg.miner.example.pipeline.SpeculativeOutOfOrderRunner"
JAR="/home/omar/seminar/Process-Discovery-over-unordered-streams/target/OnlineProcessMinerOverUnorderedStream-1.0-SNAPSHOT.jar"
FILEPATH="/home/omar/seminar/Process-Discovery-over-unordered-streams/resources/synthetic/"
GRAPHPATH="/home/omar/seminar/Process-Discovery-over-unordered-streams/logs/"
: '
for ((j = 10 ; j <= 60 ; j+=10)); do
  for ((i = 10 ; i < 100 ; i+=10)); do
    echo { /home/omar/flink/flink-1.12.1/bin/flink run -c ee.ut.cs.dsg.miner.example.pipeline.GraphAccurracyComparator /home/omar/seminar/Process-Discovery-over-unordered-streams/target/OnlineProcessMinerOverUnorderedStream-1.0-SNAPSHOT.jar --baseGraphPath "/home/omar/" --oooGraphPath "/home/omar/" --baseGraphFile "baseline.csv-GlobalDFG-Window-Length$j.txt" --oooGraphFile "1_ooo_${i}_3_10.csv-GlobalDFG-Window-Length$j.txt" }
    /home/omar/flink/flink-1.12.1/bin/flink run -c ee.ut.cs.dsg.miner.example.pipeline.GraphAccurracyComparator /home/omar/seminar/Process-Discovery-over-unordered-streams/target/OnlineProcessMinerOverUnorderedStream-1.0-SNAPSHOT.jar --baseGraphPath "/home/omar/" --oooGraphPath "/home/omar/" --baseGraphFile "baseline.csv-GlobalDFG-Window-Length$j.txt" --oooGraphFile "1_ooo_${i}_3_10.csv-GlobalDFG-Window-Length$j.txt"
  done    
done

# compare graphs specualtive 

for ((i = 10 ; i < 100 ; i+=10)); do
    echo { /home/omar/flink/flink-1.12.1/bin/flink run -c ee.ut.cs.dsg.miner.example.pipeline.GraphAccurracyComparator /home/omar/seminar/Process-Discovery-over-unordered-streams/target/OnlineProcessMinerOverUnorderedStream-1.0-SNAPSHOT.jar --baseGraphPath "/home/omar/" --oooGraphPath "/home/omar/" --baseGraphFile "baseline.csv-GlobalDFG-Speculative.txt" --oooGraphFile "1_ooo_${i}_3_10.csv-GlobalDFG-Speculative.txt" }
    /home/omar/flink/flink-1.12.1/bin/flink run -c ee.ut.cs.dsg.miner.example.pipeline.GraphAccurracyComparator /home/omar/seminar/Process-Discovery-over-unordered-streams/target/OnlineProcessMinerOverUnorderedStream-1.0-SNAPSHOT.jar --baseGraphPath "/home/omar/" --oooGraphPath "/home/omar/" --baseGraphFile "baseline.csv-GlobalDFG-Speculative.txt" --oooGraphFile "1_ooo_${i}_3_10.csv-GlobalDFG-Speculative.txt"
done 


echo "comparenew"

for ((j = 10 ; j <= 60 ; j+=10)); do
  for ((i = 10 ; i < 100 ; i+=10)); do
    echo $FLINK $GRAPHACCURRACYCOMPARATOR $JAR --baseGraphPath $GRAPHPATH --oooGraphPath $GRAPHPATH --baseGraphFile "baselines.csv-GlobalDFG-Window-Length$j.txt" --oooGraphFile "s${i}.csv-GlobalDFG-Window-Length$j.txt"
    $FLINK $GRAPHACCURRACYCOMPARATOR $JAR --baseGraphPath $GRAPHPATH --oooGraphPath $GRAPHPATH --baseGraphFile "baselines.csv-GlobalDFG-Window-Length$j.txt" --oooGraphFile "s${i}.csv-GlobalDFG-Window-Length$j.txt"
  done    
done

# compare graphs specualtive 
for ((i = 10 ; i < 100 ; i+=10)); do
    echo $FLINK $GRAPHACCURRACYCOMPARATOR $JAR --baseGraphPath $GRAPHPATH --oooGraphPath $GRAPHPATH --baseGraphFile "baselines.csv-GlobalDFG-Speculative.txt" --oooGraphFile "s${i}.csv-GlobalDFG-Speculative.txt"
     $FLINK $GRAPHACCURRACYCOMPARATOR $JAR --baseGraphPath $GRAPHPATH --oooGraphPath $GRAPHPATH --baseGraphFile "baselines.csv-GlobalDFG-Speculative.txt" --oooGraphFile "s${i}.csv-GlobalDFG-Speculative.txt"
done 
'
# Buffered Unaware 10 50 90% comparison with buffering baseline 60
for ((i = 10 ; i <=90 ; i+=40)); do
  echo     $FLINK $GRAPHACCURRACYCOMPARATOR $JAR --baseGraphPath $GRAPHPATH --oooGraphPath $GRAPHPATH --baseGraphFile "baselines.csv-GlobalDFG-Window-Length60.txt" --oooGraphFile "s${i}.csv-GlobalDFG-OOOUnaware-Window-Length60.txt" 
    $FLINK $GRAPHACCURRACYCOMPARATOR $JAR --baseGraphPath $GRAPHPATH --oooGraphPath $GRAPHPATH --baseGraphFile "baselines.csv-GlobalDFG-Window-Length60.txt" --oooGraphFile "s${i}.csv-GlobalDFG-OOOUnaware-Window-Length60.txt"
done 

# Buffered  10 50 90% comparison with buffering baseline 60
for ((i = 10 ; i <=90 ; i+=40)); do
  echo     $FLINK $GRAPHACCURRACYCOMPARATOR $JAR --baseGraphPath $GRAPHPATH --oooGraphPath $GRAPHPATH --baseGraphFile "baselines.csv-GlobalDFG-Window-Length60.txt" --oooGraphFile "s${i}.csv-GlobalDFG-Window-Length60.txt" 
    $FLINK $GRAPHACCURRACYCOMPARATOR $JAR --baseGraphPath $GRAPHPATH --oooGraphPath $GRAPHPATH --baseGraphFile "baselines.csv-GlobalDFG-Window-Length60.txt" --oooGraphFile "s${i}.csv-GlobalDFG-Window-Length60.txt"
done 

# Specualtive Unaware 10 50 90% comparison with specualtive baseline 
for ((i = 10 ; i <=90 ; i+=40)); do
  echo     $FLINK $GRAPHACCURRACYCOMPARATOR $JAR --baseGraphPath $GRAPHPATH --oooGraphPath $GRAPHPATH --baseGraphFile "baselines.csv-GlobalDFG-Speculative.txt" --oooGraphFile "s${i}.csv-GlobalDFG-OOOUnaware.txt"
    $FLINK $GRAPHACCURRACYCOMPARATOR $JAR --baseGraphPath $GRAPHPATH --oooGraphPath $GRAPHPATH --baseGraphFile "baselines.csv-GlobalDFG-Speculative.txt" --oooGraphFile "s${i}.csv-GlobalDFG-OOOUnaware.txt"
done 

# Specualtive  10 50 90% comparison with specualtive baseline 
for ((i = 10 ; i <=90 ; i+=40)); do
  echo $FLINK $GRAPHACCURRACYCOMPARATOR $JAR --baseGraphPath $GRAPHPATH --oooGraphPath $GRAPHPATH --baseGraphFile "baselines.csv-GlobalDFG-Speculative.txt" --oooGraphFile "s${i}.csv-GlobalDFG-Speculative.txt"
  $FLINK $GRAPHACCURRACYCOMPARATOR $JAR --baseGraphPath $GRAPHPATH --oooGraphPath $GRAPHPATH --baseGraphFile "baselines.csv-GlobalDFG-Speculative.txt" --oooGraphFile "s${i}.csv-GlobalDFG-Speculative.txt"
done 

: '
# Compare paper sysntetic dataset

for ((j = 10 ; j <= 60 ; j+=10)); do
  for ((i = 10 ; i < 100 ; i+=10)); do
    echo $FLINK $GRAPHACCURRACYCOMPARATOR $JAR --baseGraphPath $GRAPHPATH --oooGraphPath $GRAPHPATH --baseGraphFile "baseline.csv-GlobalDFG-Window-Length$j.txt" --oooGraphFile "1_ooo_${i}_3_10.csv-GlobalDFG-Window-Length$j.txt"
    $FLINK $GRAPHACCURRACYCOMPARATOR $JAR --baseGraphPath $GRAPHPATH --oooGraphPath $GRAPHPATH --baseGraphFile "baseline.csv-GlobalDFG-Window-Length$j.txt" --oooGraphFile "1_ooo_${i}_3_10.csv-GlobalDFG-Window-Length$j.txt"
  done    
done

# compare graphs specualtive 
for ((i = 10 ; i < 100 ; i+=10)); do
    echo $FLINK $GRAPHACCURRACYCOMPARATOR $JAR --baseGraphPath $GRAPHPATH --oooGraphPath $GRAPHPATH --baseGraphFile "baseline.csv-GlobalDFG-Speculative.txt" --oooGraphFile "1_ooo_${i}_3_10.csv-GlobalDFG-Speculative.txt"
     $FLINK $GRAPHACCURRACYCOMPARATOR $JAR --baseGraphPath $GRAPHPATH --oooGraphPath $GRAPHPATH --baseGraphFile "baseline.csv-GlobalDFG-Speculative.txt" --oooGraphFile "1_ooo_${i}_3_10.csv-GlobalDFG-Speculative.txt"
done 
'