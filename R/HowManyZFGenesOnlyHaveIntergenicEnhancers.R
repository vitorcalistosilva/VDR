#MG, 29.10.2019, extremely important example to understand the begining of the data analysis, 
#also works to get the number of zf genes that only have intergenic enhancers, 
#which means calculating intronic enhancers, enhancers with another annotations, a subset, and then a setdiff of both.
library(data.table)
HomerTabZFfile="/Users/vitorcalistosilva/Documents/Zebrafish-i3S/Masters_Zebrafish/Docs/enahncer_distribuition_danrer10"
HomerTabZF=fread(file = HomerTabZFfile,sep = "\t",header = T,stringsAsFactors = F,data.table = F, blank.lines.skip = TRUE)

#what and how many are the genes associated with 14753 putative whole pancreas ZF enhs
UniqGenes=unique(HomerTabZF$`Gene Name`)
NrUniqGs=length(UniqGenes)

#line/row indices / positions of annotations to intronic enhancers:
Idx=grep(pattern = "intergenic",x = HomerTabZF$Annotation,ignore.case = T)
#genes of these indices from intronic enhancers; here we look at the 'gene name' column:
GenesIntEnh=unique(HomerTabZF$`Gene Name`[Idx])
length(GenesIntEnh)

#get lines of the table where these unique 2265 genes appear: which gives these positions/indices:
IdxGs=which(HomerTabZF$`Gene Name`%in%GenesIntEnh)
#get the annotation for them (see the different size/length):
AnnotGsInt=HomerTabZF$Annotation[IdxGs]
GenesGsInt=HomerTabZF$`Gene Name`[IdxGs]

#So, we already know, what are the genes with intronic enhs -> GenesIntEnh
# IdxV1=grep(pattern = "intron",x = AnnotGsInt,ignore.case = T)
# GsV1=unique(HomerTabZF$`Gene Name`[IdxGs[IdxV1]])
#Now, to know which of them only  have intronic enhancers, we do an inverse grep for intron 
#(gives lines that dont contain intron) on their annotation, and then get the associated genes 
#which is a subter of 2265
#heree, check to descomplicar......
IdxV2=grep(pattern = "intergenic",x = AnnotGsInt,ignore.case = T,invert = T)
GsV2=unique(GenesGsInt[IdxV2])
#GsV2=unique(HomerTabZF$`Gene Name`[IdxGs[IdxV2]])
#OnlyIntr=setdiff(GsV1,GsV2)

#how many of 2265 genes with intronic enhancers don't have any other annotation
OnlyInter=setdiff(GenesIntEnh,GsV2)
#setdiff(GsV2,GenesIntEnh)=0