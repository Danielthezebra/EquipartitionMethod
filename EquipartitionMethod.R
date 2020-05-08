#--------------------------------------------- Created by Daniel Carvalho ------------------------------------------------------------
# Created for Dr. Kreymerman's research at Florida Atlantic University.
# Purpose:  This code is for use in finding the stiffness constant of trapped particles when their position has been tracked.
#           Using the tracked position at constant intervals of time you may use this code to find the average of the mean
#           of the sqaures of the displacement from the center of the trap. 

update.packages()  #Updates all add of R's packages and addons
library(pacman)  #loads "pacman" package: which is a package manager
p_load(rio)  #loads "rio" package using pacman package: which is used for importing and exporting data

#------------------------------------------------- updated (5/7/2020) ----------------------------------------------------------------

setwd("C:/Users/zebra/Documents/Research/LaserTrapping/")  #Sets the working file directory

#Set paths for all CSV files
numFiles <- list.files(path="2mkm/SelectedData/",               #Produce Character vector of all names of files
                       pattern="*.csv",                         #file type CSV
                       full.names = T)                          #with same names

delTrapSqMean <- matrix(NA, nrow = length(numFiles),            #creates a matrix/dataframe
                        ncol = 1, byrow = F,                    #with as many rows as there are files, and 1 column 
                        dimnames = list(c(1:length(numFiles)),  #names the rows by amount of files
                        c("Mean")))                             #names column 1 "Mean"

#Notes: 
#     The data used with this code should be inspected to understand the possible errors that could occur in the 
#     following calculations.
#
# (1) When calculating the differentials of the change in position in order to find the moment that the particle
#     is trapped (by associating it with the largest differential), one must check to see if at other times in the data there
#     is a moment where the movement is recorded with higher differential after or before tracking. 
#     If this is not taken into account then the mean square of the differentials for those trials will be really high.
#     Then the average (AvgMean) of the trials of all the means will also be higher than it should and will result in an
#     incorrect calculated stiffness. 
# (2) When setting the position of the trap below I have chosen the moment directly after the max displacement because
#     in most cases the particle will take a moment to settle. But this can be incorrect for some of the trials. It would be
#     wise to check that all the calculations made here are at the proper moments for all the data. 
# (3) When trying to associate the list of delTrapSqMean to the corresponding trial data, the list goes in the same order
#     that the numFiles list is in. numFiles lists all the trial data in order that it was processed and saved.

#------------------------------------------------- Begin calculations -----------------------------------------------------------------

n = 1                                               #Creates a counter for storing means in delTrapSqMean different rows = n

#This is the main loop used to iterate the following calculations over all the csv trials/files data
for (file in numFiles){                             #repeat for each file in numFiles list
  radCol <- read.csv(file)[ ,7]                     #store radius column into radCol dataframe
  
  #This loop finds the changes in the position (radius). Check note (1).
  for (i in length(radCol)-1){                      #repeat for each row (minus one) in radCol
    radDel <- diff(radCol)                          #Store all changes of r in radDel column
  }
  
  #This section sets the position of the trap using the changes in position just calculated above
  maxRadDel <- which.max(abs(radDel))               #Store the max change of r in maxRadDel
  maxRadDel = maxRadDel+1                           #Sets trap position to moment directly after trapping. Check note (2).
  
  #This loop finds the square of the oscillations from the trap position
  for (i in length(radCol)-maxRadDel){              #repeat for number of rows after max change
    radTrapped <- radCol[maxRadDel:NROW(radCol)]    #store in radTrapped the positions after trapping
    delTrap = radTrapped - radCol[maxRadDel]        #Store in delTrap the oscillations from the trap position
    delTrapSq = delTrap^2                           #Store in delTrapSq the squares of the oscillations
  }
  
  #This section finds the mean of the squares of the oscillations
  delTrapSqMean[n,1] <- mean(delTrapSq, na.rm = T)  #Store in delTrapSqMean the average of sqaures of the oscillations. Check note (3).
  n = n + 1
}

AvgMean <- mean(delTrapSqMean)                      #Stores in AvgMean the average of all the means in delTrapSqMean
print(AvgMean)                                      #Prints AvgMean. Check note (1).

#--------------------------------------------------- End calculations -----------------------------------------------------------------



#This function is used to clear the environment data for new calculations
rm(list = ls(all.names = T))  #REMOVE ALL OF ENVIRONMENT




#------------------------------------------------- \/ tests only \/ ------------------------------------------------------------------

print(abs(radDel[maxRadDel]))
A = 5
A = A+1
print(A)

print(radCol[maxRadDel])
test <- radCol[maxRadDel:NROW(radCol)]
test1 = test - radCol[maxRadDel]
test2 = test1^2
test3 = mean(test2, na.rm=T)
print(test3)
View(testCol)
View(testMean)
View(testMean)

for (i in 1:10){
  testSq <- i^2
  testMean[i] <- mean(testSq)  
}
print(testMean)

testMean <- vector()

print(delTrapSqMean)

for (file in numFiles) {
  print(file)
}

View(numFiles)
View(radCol)
View(radDel)
