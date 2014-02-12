rm(list = ls())

library(mouse4302cdf)
library(altcdfenvs)
	
mask.file = "mask.Sanger.BXD.txt"
to.be.deleted <- read.table(file=mask.file,sep="\t")
index.to.be.deleted <- 1002*to.be.deleted$V3 + to.be.deleted$V2 + 1
newcdf <- wrapCdfEnvAffy(mouse4302cdf,1002,1002,"mouse4302cdf")
newcdf <- removeIndex(newcdf,as.integer(index.to.be.deleted))
envnewcdf <- newcdf@envir

pheno.file = "exampleFile.txt"

phenoData<-read.AnnotatedDataFrame(pheno.file,header=TRUE,as.is=TRUE,row.names=NULL)
raw.data<-ReadAffy(filenames=phenoData$FileName,sampleNames = phenoData$SampleName)
raw.data@cdfName <- "envnewcdf"

rma.data <- rma(raw.data)