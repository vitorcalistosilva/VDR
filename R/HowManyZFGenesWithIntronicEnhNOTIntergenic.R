#VCS, 29.10.2019
###in the ZF dataset
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

#how many genes, that are intronic have peaks NOT associated with intergenic enhancers?
IdxOthIntergZF=grep(pattern = "intergenic|intron",x = AnnotZF,ignore.case = T,perl = T, invert = TRUE)
length(IdxOthIntergZF)
#290

ZFGsOthInterg=unique(HomerTabZF$`Gene Name`[IdxZF[IdxOthIntergZF]])
length(ZFGsOthInterg)
#253
#11,17%