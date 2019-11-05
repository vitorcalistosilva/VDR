#VCS, 29.10.2019, to get ZF genes with intergenic enhancers

library(data.table)
ZFHomerFile="/Users/vitorcalistosilva/Documents/Zebrafish-i3S/Masters_Zebrafish/Docs/enahncer_distribuition_danrer10"
#fread is the command to read/open data files (text files, with tables or other data)
ZFHomerTab=fread(file = ZFHomerFile,sep = "\t",header = T,stringsAsFactors = F,data.table = F, blank.lines.skip = TRUE)
#"/t" means that the separator is a collumn/tab

#get the "annotation" (col 8 of homer zf table) of those indices
ZFAnnot=ZFHomerTab[,8]
#14753, look for "intergenic" in these annotations --> grep gives which lines in ZFAnnot that have "intergenic"
ZFIdxIntergenic=grep(pattern = "intergenic",x = ZFAnnot,ignore.case = T)
#8567

#ZF genes with intergenic enhs
ZFGsIntergenic=unique(ZFHomerTab$`Gene Name`[ZFIdxIntergenic])
#how many genes? 
length(ZFGsIntergenic)
#3308

#ratio of genes with intergenic enhs to the total set of genes zf unique genes(5219)
ZFUnGs <- c(5219)
Rat1=length(ZFGsIntergenic)/ZFUnGs
#0.6338

