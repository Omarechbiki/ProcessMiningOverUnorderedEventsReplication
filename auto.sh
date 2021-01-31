#!/bin/bash

FLINK="/home/omar/flink/flink-1.12.1/bin/flink run -c"
BUFFEREDOUTOFORDERRUNNER="ee.ut.cs.dsg.miner.example.pipeline.BufferedOutOfOrderRunner"
BUFFEREDOOOUNAWARERUNNER="ee.ut.cs.dsg.miner.example.pipeline.BufferedOOOUnawareRunner"
GRAPHACCURRACYCOMPARATOR="ee.ut.cs.dsg.miner.example.pipeline.GraphAccurracyComparator"
OOOUNAWARERUNNER="ee.ut.cs.dsg.miner.example.pipeline.OOOUnawareRunner"
SPECULATIVEOUTOFORDERRUNNER="ee.ut.cs.dsg.miner.example.pipeline.SpeculativeOutOfOrderRunner"
JAR="/home/omar/seminar/Process-Discovery-over-unordered-streams/target/OnlineProcessMinerOverUnorderedStream-1.0-SNAPSHOT.jar"
FILEPATH="/home/omar/seminar/Process-Discovery-over-unordered-streams/resources/synthetic/"
GRAPHPATH="/home/omar/seminar/Process-Discovery-over-unordered-streams/gcomp/"
  
for ((j = 10 ; j <= 60 ; j+=10)); do
  for ((i = 10 ; i < 100 ; i+=10)); do
    echo $FLINK $BUFFEREDOUTOFORDERRUNNER $JAR --source file --filePath $FILEPATH --fileName "1_ooo_${i}_3_10.csv" --windowSize $j  --interArrivalTime 1 
    $FLINK $BUFFEREDOUTOFORDERRUNNER $JAR --source file --filePath $FILEPATH --fileName "1_ooo_${i}_3_10.csv" --windowSize $j  --interArrivalTime 1 
  done    
done

# baseline for windows 10-60

for ((i = 10 ; i <= 60 ; i+=10)); do
  
  echo $FLINK $BUFFEREDOUTOFORDERRUNNER $JAR --source file --filePath $FILEPATH --fileName "baseline.csv" --windowSize $i  --interArrivalTime 1 
  $FLINK $BUFFEREDOUTOFORDERRUNNER $JAR --source file --filePath $FILEPATH --fileName "baseline.csv" --windowSize $i --interArrivalTime 1 

done 
## Speculative


for ((i = 10 ; i < 100 ; i+=10)); do
  echo $FLINK $SPECULATIVEOUTOFORDERRUNNER $JAR --source file --filePath $FILEPATH --fileName "1_ooo_${i}_3_10.csv" --interArrivalTime 1 
  $FLINK $SPECULATIVEOUTOFORDERRUNNER $JAR --source file --filePath $FILEPATH --fileName "1_ooo_${i}_3_10.csv" --interArrivalTime 1 
done 

# speculative baseline
  echo $FLINK $SPECULATIVEOUTOFORDERRUNNER $JAR --source file --filePath $FILEPATH --fileName "baseline.csv" --interArrivalTime 1 
  $FLINK $SPECULATIVEOUTOFORDERRUNNER $JAR --source file --filePath $FILEPATH --fileName "baseline.csv"  --interArrivalTime 1 
: '
elif [[ $1 == "newdataset" ]]; then


for ((j = 10 ; j <= 60 ; j+=10)); do
  for ((i = 10 ; i < 100 ; i+=10)); do
    echo $FLINK $BUFFEREDOUTOFORDERRUNNER $JAR --source file --filePath $FILEPATH --fileName "s${i}.csv" --windowSize $j  --interArrivalTime 1 
    $FLINK $BUFFEREDOUTOFORDERRUNNER $JAR --source file --filePath $FILEPATH --fileName "s${i}.csv" --windowSize $j  --interArrivalTime 1 
  done    
done

# baseline for windows 10-60

for ((i = 10 ; i <= 60 ; i+=10)); do
  
  echo $FLINK $BUFFEREDOUTOFORDERRUNNER $JAR --source file --filePath $FILEPATH --fileName "newsbl.csv" --windowSize $i  --interArrivalTime 1 
  $FLINK $BUFFEREDOUTOFORDERRUNNER $JAR --source file --filePath $FILEPATH --fileName "newsbl.csv" --windowSize $i --interArrivalTime 1 

done 
## Speculative


for ((i = 10 ; i < 100 ; i+=10)); do
  echo $FLINK $SPECULATIVEOUTOFORDERRUNNER $JAR --source file --filePath $FILEPATH --fileName "s${i}.csv" --interArrivalTime 1 
  $FLINK $SPECULATIVEOUTOFORDERRUNNER $JAR --source file --filePath $FILEPATH --fileName "s${i}.csv" --interArrivalTime 1 
done 

# speculative baseline
  echo $FLINK $SPECULATIVEOUTOFORDERRUNNER $JAR --source file --filePath $FILEPATH --fileName "newsbl.csv" --interArrivalTime 1 
  $FLINK $SPECULATIVEOUTOFORDERRUNNER $JAR --source file --filePath $FILEPATH --fileName "newsbl.csv" --interArrivalTime 1 

fi

if [[ $1 == "comparenew" ]]; then
  echo "comparenew"

for ((j = 10 ; j <= 60 ; j+=10)); do
  for ((i = 10 ; i < 100 ; i+=10)); do
    echo $FLINK $GRAPHACCURRACYCOMPARATOR $JAR --baseGraphPath $GRAPHPATH --oooGraphPath $GRAPHPATH --baseGraphFile "newsbl.csv-GlobalDFG-Window-Length$j.txt" --oooGraphFile "s${i}.csv-GlobalDFG-Window-Length$j.txt"
    $FLINK $GRAPHACCURRACYCOMPARATOR $JAR --baseGraphPath $GRAPHPATH --oooGraphPath $GRAPHPATH --baseGraphFile "newsbl.csv-GlobalDFG-Window-Length$j.txt" --oooGraphFile "s${i}.csv-GlobalDFG-Window-Length$j.txt"
  done    
done

# compare graphs specualtive 
for ((i = 10 ; i < 100 ; i+=10)); do
    echo $FLINK $GRAPHACCURRACYCOMPARATOR $JAR --baseGraphPath $GRAPHPATH --oooGraphPath $GRAPHPATH --baseGraphFile "newsbl.csv-GlobalDFG-Speculative.txt" --oooGraphFile "s${i}.csv-GlobalDFG-Speculative.txt"
     $FLINK $GRAPHACCURRACYCOMPARATOR $JAR --baseGraphPath $GRAPHPATH --oooGraphPath $GRAPHPATH --baseGraphFile "newsbl.csv-GlobalDFG-Speculative.txt" --oooGraphFile "s${i}.csv-GlobalDFG-Speculative.txt"
done 

fi
'