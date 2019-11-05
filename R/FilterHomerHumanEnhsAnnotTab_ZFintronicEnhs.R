#MG, 08.10.2019, VCS edited, filter homer human enhancer annotation table by human homologs of ZF genes with intronic enhs
###human
###
library(data.table)
HomerFile="/Users/vitorcalistosilva/Documents/Zebrafish-i3S/Masters_Zebrafish/Docs/HomerAnnotationsHumanEnhs_08.10.2019"
#fread is the command to read/open data files (text files, with tables or other data)
HomerTab=fread(file = HomerFile,sep = "\t",header = T,stringsAsFactors = F,data.table = F, blank.lines.skip = TRUE)
#"/t" means that the separator is a collumn/tab

HumanIDsFile="/Users/vitorcalistosilva/Documents/Zebrafish-i3S/Masters_Zebrafish/Docs/HumanOrthologs_ZFintronicEnhs.txt"
Humanids=fread(file = HumanIDsFile,sep = "\n",header = F,stringsAsFactors = F,data.table = F, blank.lines.skip = TRUE)
HumanIDs=Humanids$V1
#1973
#"/n" means that the separator is a new line

#indices of [human homologs of ZF genes with intronic enhancers] in the human homer table
#the command below "which() with the operator %in% will get the indices of genes in HomerTab$`Gene Name`
Idx=which(HomerTab$`Gene Name`%in%HumanIDs)
#14081 and those indices corresponde to which genes (unique)?
HHmlgs=unique(HomerTab$`Gene Name`[Idx])
#how many they are?
length(HHmlgs)
#1600

#generate a table with rows/lines only from Idx
#then AnnotHmlgs and GsIntron, don't need the 1st "Idx"

#get the "annotation" (col 8 of homer human table) of those indices
AnnotHmlgs=HomerTab[Idx,8]
#14081, look for "intron" in these annotations --> grep gives which lines (the index/position of the line) in AnnotHmlgs that have "intron"
IdxIntron=grep(pattern = "intron",x = AnnotHmlgs,ignore.case = T)
#9450

#human genes with intronic enhs
GsIntron=unique(HomerTab$`Gene Name`[Idx[IdxIntron]])
#how many genes? length(GsIntron)
#1356

#ratio of genes with intronic enhs to the total set of genes for which we find homologs zf - human
Rat1=length(GsIntron)/length(HHmlgs)
#0.8475

IdxInterg=grep(pattern = "intergenic",x = AnnotHmlgs,ignore.case = T)
#3531

#human genes with intronic enhs
GsInterg=unique(HomerTab$`Gene Name`[Idx[IdxInterg]])
length(GsInterg)
#847
Rat3=length(GsInterg)/length(HHmlgs)
#0.5294

###
#other genes in homer annotations for human: genes in human w/o intronic enhs in zf
OtherGs=unique(HomerTab$`Gene Name`[-Idx])
length(OtherGs)
#17045

#get the "annotation" (col 8 of homer human table) of those indices
AnnotOther=HomerTab[-Idx,8]
#88436
IdxOtherIntron=grep(pattern = "intron",x = AnnotOther,ignore.case = T)
#49464

GsOtherIntron=unique(HomerTab$`Gene Name`[-Idx][IdxOtherIntron])
length(GsOtherIntron)
#11392

#ratio of genes with intronic enhs in human to the total set of genes w/o those whose homologs in zf have intronic enhs
Rat2=length(GsOtherIntron)/length(OtherGs)
#0.6683

IdxOtherInterg=grep(pattern = "intergenic",x = AnnotOther,ignore.case = T)
#29851

GsOtherInterg=unique(HomerTab$`Gene Name`[-Idx][IdxOtherInterg])
length(GsOtherInterg)
#8442

#ratio of genes with intronic enhs in human to the total set of genes w/o those whose homologs in zf have intronic enhs
Rat4=length(GsOtherInterg)/length(OtherGs)
#0.4953

#check for intersection of intronic with intergenic
OtherInt=is.element(GsOtherInterg,GsOtherIntron)
#which(Int)
length(OtherInt)
#8442
OtherHowmanyInt=grep(pattern = "TRUE", x  = OtherInt, ignore.case = TRUE)
length(OtherHowmanyInt)
#4353

#and vice-versa
OtherInti=is.element(GsOtherIntron,GsOtherInterg)
length(OtherInti)
#113392
OtherHowmanyInti=grep(pattern = "TRUE", x  = OtherInti, ignore.case = TRUE)
length(OtherHowmanyInti)
#4353


####
###now check in the ZF dataset
###
#check proportion of genes with intronic enhs in ZF (2265) that ALSO have INTERGENIC enhs
ZFfile="/Users/vitorcalistosilva/Documents/Zebrafish-i3S/Masters_Zebrafish/Docs/ZF_genenames_intronicEnhs.txt"
ZFids=fread(file = ZFfile,sep = "\n",header = F,stringsAsFactors = F,data.table = F, blank.lines.skip = TRUE)
ZF_IDs=unique(ZFids$V1)
#2265#gene symbols 

HomerTabZFfile="/Users/vitorcalistosilva/Documents/Zebrafish-i3S/Masters_Zebrafish/Docs/enahncer_distribuition_danrer10"
HomerTabZF=fread(file = HomerTabZFfile,sep = "\t",header = T,stringsAsFactors = F,data.table = F, blank.lines.skip = TRUE)

#where 
IdxZF=which(HomerTabZF$`Gene Name`%in%ZF_IDs)
#7270
#in the annotation collumn get the indeces
AnnotZF=HomerTabZF$Annotation[IdxZF]
#this is the annotation refering to the lines that correspond to the genes that have intronic enhancers in zf
IdxIntergZF=grep(pattern = "intergenic",x = AnnotZF,ignore.case = T)
#1863 indices

ZFGsInterg=unique(HomerTabZF$`Gene Name`[IdxZF[IdxIntergZF]])
length(ZFGsInterg)
#696
#30.73%

#check for intersection of intronic with intergenic
Int=is.element(GsInterg,GsIntron)
#which(Int)
length(Int)
#847
HowmanyInt=grep(pattern = "TRUE", x  = Int, ignore.case = TRUE)
length(HowmanyInt)
#688

#and vice-versa
Inti=is.element(GsIntron,GsInterg)
length(Inti)
#1356
HowmanyInti=grep(pattern = "TRUE", x  = Inti, ignore.case = TRUE)
length(HowmanyInti)
#688

#

####NEXT:
##check for intergenic enhnancers in the other genes that do not have intronic enhs


##take only those genes without intergenic enhs [only intronic], get human homologs, and check if they also "only" have intronic enhs, or very few intergenic?

#write files: fwrite()