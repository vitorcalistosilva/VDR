#VCS, 29.10.2019
###in the Human dataset
###
#check proportion of genes with intronic enhs in Hu (12748) that ALSO have INTERGENIC enhs
Hufile="/Users/vitorcalistosilva/Documents/Zebrafish-i3S/Masters_Zebrafish/Docs/Human_genames_intronicEnhs.txt"
Huids=fread(file = Hufile,sep = "\n",header = F,stringsAsFactors = F,data.table = F, blank.lines.skip = TRUE)
Hu_IDs=unique(Huids$V1)
#12748#gene symbols 

HomerTabHufile="/Users/vitorcalistosilva/Documents/Zebrafish-i3S/Masters_Zebrafish/Docs/HomerAnnotationsHumanEnhs_08.10.2019"
HomerTabHu=fread(file = HomerTabHufile,sep = "\t",header = T,stringsAsFactors = F,data.table = F, blank.lines.skip = TRUE)

#where 
IdxHu=which(HomerTabHu$`Gene Name`%in%Hu_IDs)
#85293
#in the annotation collumn get the indeces
AnnotHu=HomerTabHu$Annotation[IdxHu]
#this is the annotation refering to the lines that correspond to the genes that have intronic enhancers in Hu
IdxIntergHu=grep(pattern = "intergenic",x = AnnotHu,ignore.case = T)
#19526 indices

#how many genes, that are intronic have peaks NOT associated with intergenic enhancers?
IdxOthIntergHu=grep(pattern = "intergenic|intron",x = AnnotHu,ignore.case = T,perl = T, invert = TRUE)
length(IdxOthIntergHu)
#6966

HuGsOthInterg=unique(HomerTabHu$`Gene Name`[IdxHu[IdxOthIntergHu]])
length(HuGsOthInterg)
#4605
#36,12%

