#29.10.19,VCS
#get Hu genes with enhancers not intronic and not intergenic and then with intronic and with intergenic.
###data loading##
library(data.table)

HuHomerFile="/Users/vitorcalistosilva/Documents/Zebrafish-i3S/Masters_Zebrafish/Docs/HomerAnnotationsHumanEnhs_08.10.2019"
#fread is the command to read/open data files (text files, with tables or other data)
Hu_HomerTab=fread(file = HuHomerFile,sep = "\t",header = T,stringsAsFactors = F,data.table = F, blank.lines.skip = TRUE)
###

#get the "annotation" (col 8 of homer Hu table)
Hu_geneannotation=Hu_HomerTab[,8]
#look for "intron" in these annotations --> grep gives which lines (the index/position of the line) in Hu_genenames that have "intron"
Hu_IdxOther=grep(pattern = "intergenic|intron",x = Hu_geneannotation,ignore.case = T,perl = T, invert = TRUE)
#10221

Hu_GsOther=unique(Hu_HomerTab$`Gene Name`[Hu_IdxOther])
#Human genes with "other" enhs

length(Hu_GsOther)
#how many genes? 7138

#####
#maybe this isn't necessary/relevant
Hu_genename_Idx=which(Hu_HomerTab$`Gene Name`%in%Hu_GsOther)
#search for what are the gene names in the complete dataset that have enhancers in "others"

Hu_IdxIntron=grep(pattern = "intron",x = Hu_HomerTab$Annotation[Hu_genename_Idx],ignore.case =T)
#look for "intron" in these annotations

Hu_GsIntron=unique(Hu_HomerTab$`Gene Name`[Hu_genename_Idx[Hu_IdxIntron]])
#human genes with intronic enhs

length(Hu_GsIntron)
#how many genes? 4606

(length(Hu_GsIntron)*100)/length(Hu_GsOther)
#ratio of genes with intronic enhancers that also have intergenic enhancers 64.53

Hu_IdxInterg=grep(pattern = "intergenic",x = Hu_HomerTab$Annotation[Hu_genename_Idx],ignore.case =T)
#look for "intergenic" in these annotations

Hu_GsInterg=unique(Hu_HomerTab$`Gene Name`[Hu_genename_Idx[Hu_IdxInterg]])
#human genes with intergenic enhs

length(Hu_GsInterg)
#how many genes? 2989

(length(Hu_GsInterg)*100)/length(Hu_GsOther)
#ratio of genes with intronic enhancers that also have intergenic enhancers 41.87
#####
