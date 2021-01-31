#!/bin/bash
#new dataset
FLINK="/home/omar/flink/flink-1.12.1/bin/flink run -c"
BUFFEREDOUTOFORDERRUNNER="ee.ut.cs.dsg.miner.example.pipeline.BufferedOutOfOrderRunner"
BUFFEREDOOOUNAWARERUNNER="ee.ut.cs.dsg.miner.example.pipeline.BufferedOOOUnawareRunner"
OOOUNAWARERUNNER="ee.ut.cs.dsg.miner.example.pipeline.OOOUnawareRunner"
SPECULATIVEOUTOFORDERRUNNER="ee.ut.cs.dsg.miner.example.pipeline.SpeculativeOutOfOrderRunner"
JAR="/home/omar/seminar/Process-Discovery-over-unordered-streams/target/OnlineProcessMinerOverUnorderedStream-1.0-SNAPSHOT.jar"
FILEPATH="/home/omar/seminar/Process-Discovery-over-unordered-streams/resources/synthetic/"

start=$SECONDS
#Buffered Out of order runner 10-60
for ((j = 10 ; j <= 60 ; j+=10)); do
  for ((i = 10 ; i < 100 ; i+=10)); do
    echo $FLINK $BUFFEREDOUTOFORDERRUNNER $JAR --source file --filePath $FILEPATH --fileName "s${i}.csv" --windowSize $j  --interArrivalTime 1 
    $FLINK $BUFFEREDOUTOFORDERRUNNER $JAR --source file --filePath $FILEPATH --fileName "s${i}.csv" --windowSize $j  --interArrivalTime 1 
  done    
done

# baseline for windows 10-60

for ((i = 10 ; i <= 60 ; i+=10)); do
  
  echo $FLINK $BUFFEREDOUTOFORDERRUNNER $JAR --source file --filePath $FILEPATH --fileName "baselines.csv" --windowSize $i  --interArrivalTime 1 
  $FLINK $BUFFEREDOUTOFORDERRUNNER $JAR --source file --filePath $FILEPATH --fileName "baselines.csv" --windowSize $i --interArrivalTime 1 
done 

## Speculative

for ((i = 10 ; i < 100 ; i+=10)); do
  echo $FLINK $SPECULATIVEOUTOFORDERRUNNER $JAR --source file --filePath $FILEPATH --fileName "s${i}.csv" --interArrivalTime 1 
  $FLINK $SPECULATIVEOUTOFORDERRUNNER $JAR --source file --filePath $FILEPATH --fileName "s${i}.csv" --interArrivalTime 1 
done 

#speculative baseline
echo $FLINK $SPECULATIVEOUTOFORDERRUNNER $JAR --source file --filePath $FILEPATH --fileName "baselines.csv" --interArrivalTime 1 
$FLINK $SPECULATIVEOUTOFORDERRUNNER $JAR --source file --filePath $FILEPATH --fileName "baselines.csv" --interArrivalTime 1 

# Buffered Unaware 10 50 90 
for ((i = 10 ; i <=90 ; i+=40)); do
  echo $FLINK $BUFFEREDOOOUNAWARERUNNER $JAR --source file --filePath $FILEPATH --fileName "s${i}.csv" --windowSize 60 --interArrivalTime 1 
  $FLINK $BUFFEREDOOOUNAWARERUNNER $JAR --source file --filePath $FILEPATH --fileName "s${i}.csv" --windowSize 60 --interArrivalTime 1 
done 

# Speculative Unaware 10 50 90 
for ((i = 10 ; i <=90 ; i+=40)); do
  echo $FLINK $OOOUNAWARERUNNER $JAR --source file --filePath $FILEPATH --fileName "s${i}.csv" --interArrivalTime 1 
  $FLINK $OOOUNAWARERUNNER $JAR --source file --filePath $FILEPATH --fileName "s${i}.csv" --interArrivalTime 1 
done


: '

# baseline BUFFERfor windows 10-60
echo "-----------------HEREEEEEEEEE-------------"

for ((i = 10 ; i <= 60 ; i+=10)); do
  echo $FLINK $BUFFEREDOUTOFORDERRUNNER $JAR --source file --filePath $FILEPATH --fileName "baseline.csv" --windowSize $i --interArrivalTime 1 
  $FLINK $BUFFEREDOUTOFORDERRUNNER $JAR --source file --filePath $FILEPATH --fileName "baseline.csv" --windowSize $i --interArrivalTime 1 
done 
#Buffered Out of order runner
for ((j = 10 ; j <= 60 ; j+=10)); do
  for ((i = 10 ; i < 100 ; i+=10)); do
    echo $FLINK $BUFFEREDOUTOFORDERRUNNER $JAR --source file --filePath $FILEPATH --fileName "1_ooo_${i}_3_10.csv" --windowSize $j  --interArrivalTime 1 
    $FLINK $BUFFEREDOUTOFORDERRUNNER $JAR --source file --filePath $FILEPATH --fileName "1_ooo_${i}_3_10.csv" --windowSize $j  --interArrivalTime 1 
  done    
done


## Speculative

for ((i = 10 ; i < 100 ; i+=10)); do
  echo $FLINK $SPECULATIVEOUTOFORDERRUNNER $JAR --source file --filePath $FILEPATH --fileName "1_ooo_${i}_3_10.csv" --interArrivalTime 1 
  $FLINK $SPECULATIVEOUTOFORDERRUNNER $JAR --source file --filePath $FILEPATH --fileName "1_ooo_${i}_3_10.csv" --interArrivalTime 1 
done 

#speculative baseline
echo $FLINK $SPECULATIVEOUTOFORDERRUNNER $JAR --source file --filePath $FILEPATH --fileName "baseline.csv" --interArrivalTime 1 
$FLINK $SPECULATIVEOUTOFORDERRUNNER $JAR --source file --filePath $FILEPATH --fileName "baseline.csv" --interArrivalTime 1 

# Buffered Unaware 10 50 90 
for ((i = 10 ; i <=90 ; i+=40)); do
  echo $FLINK $BUFFEREDOOOUNAWARERUNNER $JAR --source file --filePath $FILEPATH --fileName "1_ooo_${i}_3_10.csv" --windowSize 60 --interArrivalTime 1 
  $FLINK $BUFFEREDOOOUNAWARERUNNER $JAR --source file --filePath $FILEPATH --fileName "1_ooo_${i}_3_10.csv" --windowSize 60 --interArrivalTime 1 
done 

# Speculative Unaware 10 50 90 
for ((i = 10 ; i <=90 ; i+=40)); do
  echo $FLINK $OOOUNAWARERUNNER $JAR --source file --filePath $FILEPATH --fileName "1_ooo_${i}_3_10.csv" --interArrivalTime 1 
  $FLINK $OOOUNAWARERUNNER $JAR --source file --filePath $FILEPATH --fileName "1_ooo_${i}_3_10.csv" --interArrivalTime 1 
done
'

duration=$(( SECONDS - start ))

echo "Duration of the whole process was " $duration