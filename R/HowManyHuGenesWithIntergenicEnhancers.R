#VCS, 29.10.2019, to get Human genes with intergenic enhancers

library(data.table)
HuHomerFile="/Users/vitorcalistosilva/Documents/Zebrafish-i3S/Masters_Zebrafish/Docs/HomerAnnotationsHumanEnhs_08.10.2019"
#fread is the command to read/open data files (text files, with tables or other data)
HuHomerTab=fread(file = HuHomerFile,sep = "\t",header = T,stringsAsFactors = F,data.table = F, blank.lines.skip = TRUE)
#"/t" means that the separator is a collumn/tab

#get the "annotation" (col 8 of homer human table) of those indices
HuAnnot=HuHomerTab[,8]
#102517, look for "intergenic" in these annotations --> grep gives which lines in HuAnnot that have "intergenic"
HuIdxIntergenic=grep(pattern = "intergenic",x = HuAnnot,ignore.case = T)
#33382

#Hu genes with intergenic enhs
HuGsIntergenic=unique(HuHomerTab$`Gene Name`[HuIdxIntergenic])
#how many genes? 
length(HuGsIntergenic)
#9289

#ratio of genes with intergenic enhs to the total set of genes zf unique genes(5219)
HuUnGs <- c(18645)
Rat2=length(HuGsIntergenic)/HuUnGs
#0.4982

