#29.10.19,VCS
#get ZF genes with enhancers not intronic and not intergenic and then with intronic and with intergenic.
###data loading##
library(data.table)

ZFHomerFile="/Users/vitorcalistosilva/Documents/Zebrafish-i3S/Masters_Zebrafish/Docs/enahncer_distribuition_danrer10"
#fread is the command to read/open data files (text files, with tables or other data)
ZF_HomerTab=fread(file = ZFHomerFile,sep = "\t",header = T,stringsAsFactors = F,data.table = F, blank.lines.skip = TRUE)
###

#get the "annotation" (col 8 of homer ZF table)
ZF_geneannotation=ZF_HomerTab[,8]
#look for "intron" in these annotations --> grep gives which lines (the index/position of the line) in ZF_genenames that have "intron"
ZF_IdxOther=grep(pattern = "intergenic|intron",x = ZF_geneannotation,ignore.case = T,perl = T, invert = TRUE)
#1069

ZF_GsOther=unique(ZF_HomerTab$`Gene Name`[ZF_IdxOther])
#ZFman genes with "other" enhs

length(ZF_GsOther)
#how many genes? 764

#####
#maybe this isn't necessary/relevant
ZF_genename_Idx=which(ZF_HomerTab$`Gene Name`%in%ZF_GsOther)
#search for what are the gene names in the complete dataset that have enhancers in "others"

ZF_IdxIntron=grep(pattern = "intron",x = ZF_HomerTab$Annotation[ZF_genename_Idx],ignore.case =T)
#look for "intron" in these annotations

ZF_GsIntron=unique(ZF_HomerTab$`Gene Name`[ZF_genename_Idx[ZF_IdxIntron]])
#ZFman genes with intronic enhs

length(ZF_GsIntron)
#how many genes? 253

(length(ZF_GsIntron)*100)/length(ZF_GsOther)
#ratio of genes with intronic enhancers that also have intergenic enhancers 33.12

ZF_IdxInterg=grep(pattern = "intergenic",x = ZF_HomerTab$Annotation[ZF_genename_Idx],ignore.case =T)
#look for "intergenic" in these annotations

ZF_GsInterg=unique(ZF_HomerTab$`Gene Name`[ZF_genename_Idx[ZF_IdxInterg]])
#ZFman genes with intergenic enhs

length(ZF_GsInterg)
#how many genes? 286

(length(ZF_GsInterg)*100)/length(ZF_GsOther)
#ratio of genes with intronic enhancers that also have intergenic enhancers 37.43
#####
