#MG, 08.10.2019, get human orthologs from ZF genes
library(data.table)
#run as "Rscript Get_HumanOrthologs_ZFgenename.R ZFgenes HomologyFile OutputFile"
args = commandArgs(trailingOnly=TRUE)

ZFfile=args[1]
#/home/mafalda/Projects/Conservation_Vitor_MSc/ZF_genenames_intronicEnhs.txt
ZFids=fread(file = ZFfile,sep = "\n",header = F,stringsAsFactors = F,data.table = F)
ZF_IDs=ZFids$V1

HomolFile=args[2]
#/home/mafalda/Projects/Conservation_Vitor_MSc/ZFhuman_Orthologs_mart_export_08.10.2019.txt

FOut=args[3]
#/home/mafalda/Projects/Conservation_Vitor_MSc/HumanOrthologs_ZFintronicEnhs.txt

HomTab=fread(file = HomolFile,sep = "\t",header = T,stringsAsFactors = F,data.table = F)

Idx=which(HomTab[,2]%in%ZF_IDs)

HumanHmlgs=data.frame(GeneName=unique(HomTab[Idx,5]))

fwrite(x = HumanHmlgs,file = FOut,append = F,sep = "\n",col.names = F)