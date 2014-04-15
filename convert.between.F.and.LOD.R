####################################################################################
##  Example Program For Converting Back And Forth Between F-stats and LOD Scores  ##
##                                                                                ##
##  Created: 04/15/14 by Laura Saba                                               ##
####################################################################################


# get F-stat from ANOVA and convert to LOD score
summary(lm(phenotype ~ genotype))
f = 7.641
n = 38  # number of samples
df = 2  # number of genotype categories minus 1 (for RI panel df=1)
lod = (n/2)*log10(f*(df/(n-df-1))+1) # from Broman and Sen 2009 text
lod

# get LOD score for a particular unadjusted p-value
n=34     # number of samples
df=1     # number of genotype categories minus 1 (for RI panel df=1)
p=0.01   # p-value threshold
f = qf(p=0.01,df1=1,df2=n-df-1,lower.tail=FALSE)
lod = (n/2)*log10(f*(df/(n-df-1))+1)
lod

