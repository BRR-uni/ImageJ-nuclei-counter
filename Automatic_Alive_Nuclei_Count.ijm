run("Duplicate...", "title=DAPI");
DAPI_window = "DAPI";

//Forzar la escala automaticamente a la usada por el confocal
run("Set Scale...", "distance=6.4110 known=1 unit=micron global");

//Preprocesado
//run("Enhance Contrast...", "saturated=.3 normalize");
//run("Brightness/Contrast...");
//run("Enhance Contrast", "saturated=0.35");
//run("Apply LUT");
//run("Close");
run("Gaussian Blur...", "sigma=2");

//Segmentación
run("Command From Macro", "command=[de.csbdresden.stardist.StarDist2D], args=['input':'"+DAPI_window+"', 'modelChoice':'Versatile (fluorescent nuclei)', 'normalizeInput':'true', 'percentileBottom':'1.0', 'percentileTop':'99.8', 'probThresh':'0.5', 'nmsThresh':'0.2', 'outputType':'Label Image', 'nTiles':'1', 'excludeBoundary':'2', 'roiPosition':'Automatic', 'verbose':'false', 'showCsbdeepProgress':'false', 'showProbAndDist':'false'], process=[false]");
//close(currentFile);
setAutoThreshold("Default dark");
run("Threshold...");
setOption("BlackBackground", true);
setThreshold(1, 65535, "raw");
run("Convert to Mask");
run("Close");
run("Watershed");
run("Analyze Particles...", "size=20-10000 show=[Overlay Masks] exclude clear summarize");

selectWindow("DAPI");
run("Scale Bar...", "width=20 height=24 thickness=4 font=40 color=White background=None location=[Lower Right] horizontal bold overlay");
selectWindow("Label Image");
selectWindow("Summary");
