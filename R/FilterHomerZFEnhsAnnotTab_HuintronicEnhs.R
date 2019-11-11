#VCS, 25.10.2019, filter homer zebrafish enhancer annotation table by zebrafish homologs of Human genes with intronic enhs
###hebrafish
###
library(data.table)
ZFHomerFile="/Users/vitorcalistosilva/Documents/Zebrafish-i3S/Masters_Zebrafish/Docs/enahncer_distribuition_danrer10"
#fread is the command to read/open data files (text files, with tables or other data)
ZFHomerTab=fread(file = ZFHomerFile,sep = "\t",header = T,stringsAsFactors = F,data.table = F, blank.lines.skip = TRUE)
#"/t" means that the separator is a collumn/tab

ZebrafishIDsFile="/Users/vitorcalistosilva/Documents/Zebrafish-i3S/Masters_Zebrafish/Docs/ZebrafishOrthologs_HuintronicEnhs.txt"
Zebrafishids=fread(file = ZebrafishIDsFile,sep = "\n",header = F,stringsAsFactors = F,data.table = F, blank.lines.skip = TRUE)
ZebrafishIDs=Zebrafishids$V1
#10241
#"/n" means that the separator is a new line

#indices of [ZF homologs of Human genes with intronic enhancers] in the zebrafish homer table
#the command below "which() with the operator %in% will get the indices of genes in HomerTab$`Gene Name`
ZFIdx=which(ZFHomerTab$`Gene Name`%in%ZebrafishIDs)
#14081 and those indices corresponde to which genes (unique)?
ZFHHmlgs=unique(ZFHomerTab$`Gene Name`[ZFIdx])
#how many they are?
length(ZFHHmlgs)
#2664

#generate a table with rows/lines only from Idx
#then AnnotHmlgs and GsIntron, don't need the 1st "Idx"

#get the "annotation" (col 8 of homer zebrafish table) of those indices
ZFAnnotHmlgs=ZFHomerTab[ZFIdx,8]
#7965, look for "intron" in these annotations --> grep gives which lines (the index/position of the line) in AnnotHmlgs that have "intron"
ZFIdxIntron=grep(pattern = "intron",x = ZFAnnotHmlgs,ignore.case = T)
#3420

#human genes with intronic enhs
ZFGsIntron=unique(ZFHomerTab$`Gene Name`[ZFIdx[ZFIdxIntron]])
length(ZFGsIntron)
#how many genes? length(GsIntron)
#1387

#ratio of genes with intronic enhs to the total set of genes for which we find homologs zf - human
ZFRat1=length(ZFGsIntron)/length(ZFHHmlgs)
#0.5206456

ZFIdxInterg=grep(pattern = "intergenic",x = ZFAnnotHmlgs,ignore.case = T)
length(ZFIdxInterg)
#4131

#human genes with intronic enhs
ZFGsInterg=unique(ZFHomerTab$`Gene Name`[ZFIdx[ZFIdxInterg]])
length(ZFGsInterg)
#1565
ZFRat3=length(ZFGsInterg)/length(ZFHHmlgs)
#0.5874625

###
#intersect of ZF homologs with intronic enhs and also intergenic enhs:
ZFGsIntroInter=intersect(ZFGsIntron,ZFGsInterg)
length(ZFGsIntroInter)

#check for intersection of intronic with intergenic
ZFInt=is.element(ZFGsInterg,ZFGsIntron)
#which(Int)
length(ZFInt)
#1565
ZFHowmanyInt=grep(pattern = "TRUE", x  = ZFInt, ignore.case = TRUE)
length(ZFHowmanyInt)
#428

#and vice-versa
ZFInti=is.element(ZFGsIntron,ZFGsInterg)
length(ZFInti)
#1387
ZFHowmanyInti=grep(pattern = "TRUE", x  = ZFInti, ignore.case = TRUE)
length(ZFHowmanyInti)
#428

###
#other genes in homer annotations for human: genes in human w/o intronic enhs in zf
ZFOtherGs=unique(ZFHomerTab$`Gene Name`[-ZFIdx])
length(ZFOtherGs)
#2555

#get the "annotation" (col 8 of homer zebrafish table) of those indices
ZFAnnotOther=ZFHomerTab[-ZFIdx,8]
length(ZFAnnotOther)
#6788
ZFIdxOtherIntron=grep(pattern = "intron",x = ZFAnnotOther,ignore.case = T)
length(ZFIdxOtherIntron)
#1697

ZFGsOtherIntron=unique(ZFHomerTab$`Gene Name`[-ZFIdx][ZFIdxOtherIntron])
length(ZFGsOtherIntron)
#878

#ratio of genes with intronic enhs in human to the total set of genes w/o those whose homologs in zf have intronic enhs
ZFRat2=length(ZFGsOtherIntron)/length(ZFOtherGs)
#0.3436399

ZFIdxOtherInterg=grep(pattern = "intergenic",x = ZFAnnotOther,ignore.case = T)
length(ZFIdxOtherInterg)
#4436

ZFGsOtherInterg=unique(ZFHomerTab$`Gene Name`[-ZFIdx][ZFIdxOtherInterg])
length(ZFGsOtherInterg)
#1743

#intersect of ZF other genes with intronic enhs and also intergenic enhs:
ZFGsOtherIntroInter=intersect(ZFGsOtherIntron,ZFGsOtherInterg)
length(ZFGsOtherIntroInter)

#ratio of genes with intronic enhs in human to the total set of genes w/o those whose homologs in zf have intronic enhs
ZFRat4=length(ZFGsOtherInterg)/length(ZFOtherGs)
#0.6821918

#check for intersection of intronic with intergenic
ZFOtherInt=is.element(ZFGsOtherInterg,ZFGsOtherIntron)
#which(Int)
length(ZFOtherInt)
#1743
ZFOtherHowmanyInt=grep(pattern = "TRUE", x  = ZFOtherInt, ignore.case = TRUE)
length(ZFOtherHowmanyInt)
#268

#and vice-versa
ZFOtherInti=is.element(ZFGsOtherIntron,ZFGsOtherInterg)
length(ZFOtherInti)
#878
ZFOtherHowmanyInti=grep(pattern = "TRUE", x  = ZFOtherInti, ignore.case = TRUE)
length(ZFOtherHowmanyInti)
#268

#################

#Making Graphs

