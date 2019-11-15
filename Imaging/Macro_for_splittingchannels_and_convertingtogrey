/* Lif to Tiff series
* v0.2
*
* Read Lif file from input folder and save each serie (Position) as tiff file in the output folder (Batch mode)
* 
* This macro should NOT be redistributed without author's permission. 
* Explicit acknowledgement to the ALM facility should be done in case of published articles (approved in C.E. 7/17/2017):     
* 
* "The authors acknowledge the support of i3S Scientific Platform Advanced Light Microscopy, 
* member of the national infrastructure PPBI-Portuguese Platform of BioImaging (supported by POCI-01-0145-FEDER-022122)."
* 
* Date: July/2018
* Author: Mafalda Sousa, mafsousa@ibmc.up.pt 
* Advanced Ligth Microscopy, I3S 
* PPBI-Portuguese Platform of BioImaging
* */
 


//run("Bio-Formats Macro Extensions") to extract correct series from .MSR files
ext = "lif"

inDir = getDirectory("Choose Directory Containing " + ext + " Files ");
outDir = getDirectory("Choose Directory for TIFF Output ");
filelist = getFileList(inDir); //load array of all files inside input directory
filename1 = filelist[0];
print(filename1);

setBatchMode(true);

for (i=0; i< filelist.length; i++) {

     

run("Bio-Formats Macro Extensions");
Ext.setId(inDir+File.separator+filelist[i]);
Ext.getSeriesCount(seriesCount);


	
for (a=1; a<= seriesCount; a++) {
	     
	     // process lif files only
	     series_name = "series_" + a;
	     //title = filelist[i] + "_"  + series_name; 
	     //print(title);

	     // open file, requires LOCI tools (aka Bio-Formats)
	     run("Bio-Formats Importer", "open=["+ inDir + filelist[i] +  "] color_mode=Default rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT use_virtual_stack " + series_name);

		title=getTitle();
	    	run("Split Channels");
	    	run("Grays");
	    	
	     saveAs("Tiff", outDir + File.separator + title + ".tiff");
	     close();
	     
	}
}


print("-- Done --");