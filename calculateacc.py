import os
import csv
import numpy as np
import pandas as pd
pathName = os.getcwd()+'/gcomp/'

#columns = ['Window 10','Window 20', 'Window 30','Window 40','Window 50', 'Window 60', 'Speculative']
columns = []
index = np.arange(10,100,10)
average_df = pd.DataFrame(index=index, columns=columns)
average_df = average_df.fillna(0) # with 0s rather than NaNs
last_globalDFG_accuracy =  pd.DataFrame(index=index, columns=columns)
last_globalDFG_accuracy = last_globalDFG_accuracy.fillna(0)

#Windows
# 1_ooo_"+str(percentage)+"_3_10
for window_size in range(10, 70, 10):
    for percentage in range(10, 100, 10):
        filename="baselines.csv-GlobalDFG-Window-Length"+str(window_size)+".txt compared to s"+str(percentage)+".csv-GlobalDFG-Window-Length"+str(window_size)+".txt.csv"
        tmp=pd.read_csv(pathName+filename) 
        tmp.columns = ['time', 'accuracy']
        average_df.at[percentage, window_size]= tmp["accuracy"].mean()
        last_globalDFG_accuracy.at[percentage, window_size]= tmp["accuracy"].iloc[-1]

#Speculative
#baseline.csv-GlobalDFG-Speculative.txt compared to s10.csv-GlobalDFG-Speculative.txt.csv
#"newsbl.csv-GlobalDFG-Speculative.txt compared to s"+str(percentage)+".csv-GlobalDFG-Speculative.txt.csv"
for percentage in range(10, 100, 10):
    filename="baselines.csv-GlobalDFG-Speculative.txt compared to s"+str(percentage)+".csv-GlobalDFG-Speculative.txt.csv"
    #"newsbl.csv-GlobalDFG-Speculative.txt compared to s"+str(percentage)+".csv-GlobalDFG-Speculative.txt.csv"
    tmp=pd.read_csv(pathName+filename) 
    tmp = tmp.iloc[1:]
    tmp.columns = ['time', 'accuracy']
    print(tmp['accuracy'].iloc[-1])
    average_df.at[percentage, 70] = tmp["accuracy"].mean()
    last_globalDFG_accuracy.at[percentage, 70]= tmp['accuracy'].iloc[-1]
last_globalDFG_accuracy.to_csv(pathName+'MySDataLastDFG.csv')
average_df.to_csv(pathName+'MySDataAverageDFG.csv')
