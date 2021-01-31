#!/bin/bash

FLINK="/home/omar/flink/flink-1.12.1/bin/flink run -c"
BUFFEREDOUTOFORDERRUNNER="ee.ut.cs.dsg.miner.example.pipeline.BufferedOutOfOrderRunner"
BUFFEREDOOOUNAWARERUNNER="ee.ut.cs.dsg.miner.example.pipeline.BufferedOOOUnawareRunner"
OOOUNAWARERUNNER="ee.ut.cs.dsg.miner.example.pipeline.OOOUnawareRunner"
SPECULATIVEOUTOFORDERRUNNER="ee.ut.cs.dsg.miner.example.pipeline.SpeculativeOutOfOrderRunner"
GRAPHACCURRACYCOMPARATOR="ee.ut.cs.dsg.miner.example.pipeline.GraphAccurracyComparator"
JAR="/home/omar/seminar/Process-Discovery-over-unordered-streams/target/OnlineProcessMinerOverUnorderedStream-1.0-SNAPSHOT.jar"
GRAPHPATH="/home/omar/seminar/Process-Discovery-over-unordered-streams/logs/"
FILEPATH="/home/omar/seminar/Process-Discovery-over-unordered-streams/resources/"
BPIBASELINE="bpi1sorted.csv"
BPI="bpi1unsorted.csv"


#Buffered 600

echo $FLINK $BUFFEREDOUTOFORDERRUNNER $JAR --source file --filePath $FILEPATH --fileName $BPI --windowSize 600  --interArrivalTime 1 
$FLINK $BUFFEREDOUTOFORDERRUNNER $JAR --source file --filePath $FILEPATH --fileName $BPI --windowSize 600  --interArrivalTime 1 

#Buffered 600 Unaware

echo $FLINK $BUFFEREDOOOUNAWARERUNNER $JAR --source file --filePath $FILEPATH --fileName $BPI --windowSize 600  --interArrivalTime 1 
$FLINK $BUFFEREDOOOUNAWARERUNNER $JAR --source file --filePath $FILEPATH --fileName $BPI --windowSize 600  --interArrivalTime 1 

# Baseline Buffered 600
echo $FLINK $BUFFEREDOUTOFORDERRUNNER $JAR --source file --filePath $FILEPATH --fileName $BPIBASELINE --windowSize 600  --interArrivalTime 1 
$FLINK $BUFFEREDOUTOFORDERRUNNER $JAR --source file --filePath $FILEPATH --fileName $BPIBASELINE --windowSize 600  --interArrivalTime 1 

#Speculative

echo $FLINK $SPECULATIVEOUTOFORDERRUNNER $JAR --source file --filePath $FILEPATH --fileName $BPI --interArrivalTime 1 
$FLINK $SPECULATIVEOUTOFORDERRUNNER $JAR --source file --filePath $FILEPATH --fileName $BPI --interArrivalTime 1 

#Speculative Unaware

echo $FLINK $OOOUNAWARERUNNER $JAR --source file --filePath $FILEPATH --fileName $BPI --interArrivalTime 1 
$FLINK $OOOUNAWARERUNNER $JAR --source file --filePath $FILEPATH --fileName $BPI --interArrivalTime 1 

# Baseline Buffered 600
echo $FLINK $SPECULATIVEOUTOFORDERRUNNER $JAR --source file --filePath $FILEPATH --fileName $BPIBASELINE --interArrivalTime 1 
$FLINK $SPECULATIVEOUTOFORDERRUNNER $JAR --source file --filePath $FILEPATH --fileName $BPIBASELINE --interArrivalTime 1 


#Comparison speculative 
echo $FLINK $GRAPHACCURRACYCOMPARATOR $JAR --baseGraphPath $GRAPHPATH --oooGraphPath $GRAPHPATH --baseGraphFile "bpi1sorted.csv-GlobalDFG-Speculative.txt" --oooGraphFile "bpi1unsorted.csv-GlobalDFG-Speculative.txt"

$FLINK $GRAPHACCURRACYCOMPARATOR $JAR --baseGraphPath $GRAPHPATH --oooGraphPath $GRAPHPATH --baseGraphFile "bpi1sorted.csv-GlobalDFG-Speculative.txt" --oooGraphFile "bpi1unsorted.csv-GlobalDFG-Speculative.txt"

#Comparison speculative unaware
echo $FLINK $GRAPHACCURRACYCOMPARATOR $JAR --baseGraphPath $GRAPHPATH --oooGraphPath $GRAPHPATH --baseGraphFile "bpi1sorted.csv-GlobalDFG-Speculative.txt" --oooGraphFile "bpi1unsorted.csv-GlobalDFG-OOOUnaware.txt"

$FLINK $GRAPHACCURRACYCOMPARATOR $JAR --baseGraphPath $GRAPHPATH --oooGraphPath $GRAPHPATH --baseGraphFile "bpi1sorted.csv-GlobalDFG-Speculative.txt" --oooGraphFile "bpi1unsorted.csv-GlobalDFG-OOOUnaware.txt"

# Comparison Buffered 600

$FLINK $GRAPHACCURRACYCOMPARATOR $JAR --baseGraphPath $GRAPHPATH --oooGraphPath $GRAPHPATH --baseGraphFile "bpi1sorted.csv-GlobalDFG-Window-Length600.txt" --oooGraphFile "bpi1unsorted.csv-GlobalDFG-Window-Length600.txt"

# Comparison Buffered 600 unaware 

$FLINK $GRAPHACCURRACYCOMPARATOR $JAR --baseGraphPath $GRAPHPATH --oooGraphPath $GRAPHPATH --baseGraphFile "bpi1sorted.csv-GlobalDFG-Window-Length600.txt" --oooGraphFile "bpi1unsorted.csv-GlobalDFG-OOOUnaware-Window-Length600.txt"