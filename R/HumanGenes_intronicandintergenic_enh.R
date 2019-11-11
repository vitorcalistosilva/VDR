#14.10.19,VCS
#get human genes with intronic enhancers and then intronic also with intergenic.
###data loading##
library(data.table)

HomerFile="/Users/vitorcalistosilva/Documents/Zebrafish-i3S/Masters_Zebrafish/Docs/HomerAnnotationsHumanEnhs_08.10.2019"
#fread is the command to read/open data files (text files, with tables or other data)
Hu_HomerTab=fread(file = HomerFile,sep = "\t",header = T,stringsAsFactors = F,data.table = F, blank.lines.skip = TRUE)
##this is already done, ijust gave it a new name for convenience (Hu_)
###

#get the "annotation" (col 8 of homer human table)
Hu_geneannotation=Hu_HomerTab[,8]
#look for "intron" in these annotations --> grep gives which lines (the index/position of the line) in Hu_genenames that have "intron"
Hu_IdxIntron=grep(pattern = "intron", x = Hu_geneannotation,ignore.case =T)

Hu_GsIntron=unique(Hu_HomerTab$`Gene Name`[Hu_IdxIntron])
#human genes with intronic enhs

length(Hu_GsIntron)
#how many genes? 12748

Hu_genename_Idx=which(Hu_HomerTab$`Gene Name`%in%Hu_GsIntron)
#search for what are the gene names in the complete dataset that have enhancers in introns

Hu_IdxInterg=grep(pattern = "intergenic",x = Hu_HomerTab$Annotation[Hu_genename_Idx],ignore.case =T)
#look for "intergenic" in these annotations

#####---->HERERER: this part is not right, because above (l27), you are already subsetting the full table by using [Hu_genename_Idx], so then in the next step, 
#you need to keep that consistent, see l40
#Hu_GsInterg=unique(Hu_HomerTab$`Gene Name`[Hu_IdxInterg])
#human genes with intronic enhs

#length(Hu_GsInterg)
#how many genes? 9443

#(length(Hu_GsInterg)*100)/length(Hu_GsIntron)
#ratio of genes with intronic enhancers that also have intergenic enhancers 74.07436
######<-----

Hu_GsInterg2=unique(Hu_HomerTab$`Gene Name`[Hu_genename_Idx[Hu_IdxInterg]])
length(Hu_GsInterg2)
#5041
(length(Hu_GsInterg2)*100)/length(Hu_GsIntron)
#39.54
###
#in the terminal wc -l /Users/vitorcalistosilva/Documents/Zebrafish-i3S/Masters_Zebrafish/Docs/Chip_without_TSS_whole_hg19.peaks.liftOver2_hg38.bed
#it gives how many genes there are in this file, in this case 102517
###