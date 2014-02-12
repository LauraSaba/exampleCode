rm(list=ls())

setwd("/Users/laurasaba/Documents/LXS")

fileListing <- read.table("Source/exonArray.noOutliers.fileListing.txt",sep="\t",header=TRUE)
fileListing$sampleName = paste(fileListing$Strain,fileListing$Mouse,fileListing$Batch,sep=".")

sampleInfo <- cbind(fileListing[,c("sampleName","cel_files")],fileListing$Batch,fileListing$Strain)
colnames(sampleInfo) <- c("Sample Name","FileName","Batch","strain")
write.table(sampleInfo,file="Data/CoreTrans/sampleInfo.txt",sep="\t",row.names=FALSE,col.names=TRUE,quote=FALSE)

coreTrans <- read.table("Data/CoreTrans/rma.summary.txt",sep="\t",header=TRUE)
colnames(coreTrans)<-c("ProbeID",as.character(fileListing$sampleName))
write.table(coreTrans,file="Data/CoreTrans/rma.coreTrans.csv",sep=",",row.names=FALSE,col.names=TRUE)

source('Programs/ComBat.R')
setwd("Data/CoreTrans")
ComBat('rma.coreTrans.csv','sampleInfo.txt',skip=1,type='csv')

adjusted <- read.table(file="Adjusted_rma.coreTrans.csv",sep="\t",header=TRUE,row.names=1)
