//@ File (label="Select a file", style="open") openedFile
/*La linea de arriba ejecuta el selector de archivo y guarda la ruta
al archivo en la variable opendedFile*/
open(openedFile); //abrir el archivo seleccionado
//debe de elegirse la opción de abrir con split channels
currentFile = File.getName(openedFile); //guarda el nombre del archivo

close(currentFile + " - C=0"); //cierra el canal de MLKL
close(currentFile + " - C=1"); //cierra el canal de Tuj1
selectWindow(currentFile + " - C=2"); //crea una copia del canal de DAPI
run("Duplicate...", " ");
//selectWindow(currentFile + " - C=2"); //cierra la ventana de la imagen original
//close();
currentFile = currentFile + " - C=2-1" //actualiza el nombre del archivo actual

//Forzar la escala automaticamente a la usada por el confocal
run("Set Scale...", "distance=6.4110 known=1 unit=micron global");
//Preprocesado
run("Gaussian Blur...", "sigma=2");
run("Enhance Contrast...", "saturated=.3 normalize");

//Selección de Threshold manual
run("Threshold...");
setAutoThreshold("Default dark no-reset");
waitForUser("Set threshold manualy \n click apply and then OK")
run("Close");
run("Convert to Mask");
run("Watershed");

//Analizar particulas
run("Analyze Particles...", "size=23-10000 show=[Overlay Masks] exclude clear summarize");
//close(currentFile);
//selectWindow("Summary");
