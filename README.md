README file for code traitement_imag_calc_test_affichage_162.m

The code is a tool to visualize 2-photon calcium images, and manually select cells that meet the activation criterion. 

1 / System requirements

-	Pc computer with windows 10 or windows 11. Code not tested on linux nor iOS. 
-	A licenced Matlab. Code was developed on R2019a and successfully teste on R2024b, with the following toolboxes : 
o	Image Processing Toolbox
o	Signal Processing Toolbox
-	Bioformats toolbox (https://docs.openmicroscopy.org/bio-formats/5.8.2/users/matlab/index.html)

2 / Installation guide

No installation is required. Just copy the file traitement_imag_calc_test_affichage_162.m in the matlab directory, open it and press F5. 
Alternatively, one can type “traitement_imag_calc_test_affichage_162” in the Matlab command window.

3/ Demo

-	After launch, user will be prompted to open an image file. Accepted format are czi, tif or tiff file. 
-	Then a second windows will ask the user whether images need extra processing to compensate drift, rotation and/or shear, and ask for size of the median and gaussian filters. 
-	The selected processes are then computed, with an execution time between 10s and 120s depending on the computed speed, and the main widow opens.
-	Within the main window, the user can
o	Add, delete, move cells
o	Change the Z plane and Time plane
o	Change images min and max
o	Change the colormap, and the image processing for time image and SD image
o	Visualize the time course of the current pixel, with real time calculation of BaseLine and activation criterion
o	Change time period of BaseLine and Stimulation
o	Change activation level (number od standard deviation over baseline, and offset)
o	Add anatomical zones
o	Export and import data
o	Export transients (pop up for additional parameters)
o	Export images (pop up for additional parameters)

Output of the code can be either : 
-	an excel fil listing all cells, sorted by stack, with raw fluorescence, dF/F, associated zones, and metadata
-	copy of images
-	print of all transients as a multi stack tiff file

