title=getTitle();
run("To ROI Manager");
nROI=roiManager("count");
run("From ROI Manager");
roiManager("reset");

Table.create("Radius");


for (i = 1; i < nROI; i=i+2) {
	
selectWindow(title);
run("Duplicate...", "title=copy");
run("To ROI Manager");
roiManager("select", i);
run("Curvature");

selectWindow("SS");
radius=Table.getColumn("R");
Array.getStatistics(radius, min, max, mean, stdDev);
selectWindow("Radius");
Table.set(i, 0,mean);
roiManager("reset");
print("\\Clear");
selectWindow("SS");run("Close");
close("copy");



}