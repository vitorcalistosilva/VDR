#VCS 25.10.2019, get Zebrafish orthologs from Human genes
library(data.table)
#run as "Rscript Get_ZebrafishOrthologs_Humangenename.R Humangenes HomologyFile OutputFile"
args = commandArgs(trailingOnly=TRUE)

Hufile=args[1]
print(Hufile)
#/home/mafalda/Projects/Conservation_Vitor_MSc/Human_genames_intronicEnhs.txt
HuFids=fread(file = Hufile,sep = "\n",header = F, stringsAsFactors = F, data.table = F)
#by default, R names columns with "V1","V2", etc, these are subsetable
Hu_IDs=HuFids$V1

HomolFile=args[2]
print(HomolFile)
#/Users/vitorcalistosilva/Documents/Zebrafish-i3S/Masters_Zebrafish/Docs/ZFhuman_Orthologs_mart_export_08.10.2019.txt

ZFOut=args[3]
print(ZFOut)
#/Users/vitorcalistosilva/Documents/Zebrafish-i3S/Masters_Zebrafish/Docs/ZebrafishOrthologs_HuintronicEnhs.txtH

HomTab=fread(file = HomolFile,sep = "\t",header = T, stringsAsFactors = F, data.table = F)

Idx=which(HomTab[,5]%in%Hu_IDs)

ZebrafishHmlgs=data.frame(GeneName=unique(HomTab[Idx,2]))

fwrite(x = ZebrafishHmlgs, file = ZFOut, append = F, sep = "\n", col.names = F)