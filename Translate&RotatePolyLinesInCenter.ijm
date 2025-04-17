/* 
 *  This macro takes every 2nd ROI and translate and rotate
 *  so that the first point is at the center of image.
 *  The rotation angle is calculated from the angle of the line between first point of every 2nd ROI to the center of each first ROI (which are circles).
 *  functions are from :
 *  https://forum.image.sc/t/rotate-line-roi-via-rotating-point-coordinates/8323
 *  
*/

title=getTitle();
getDimensions(w,h,ch,sl,fr);
run("To ROI Manager");

newImage("Traces_"+title, "8-bit black", w, h, 1);

nROI=roiManager("count");
for (roi=0;roi<nROI-1;roi+=2){
	roiManager("select", roi);
	List.setMeasurements ;
	x1 = List.getValue("X");
	y1 = List.getValue("Y");
	print (y1);
	roiManager("select", roi+1);
	getSelectionCoordinates( x, y );
	makeLine(x1, y1, x[0], y[0]);	
	List.setMeasurements ;
	angle = List.getValue("Angle");
	print (angle);
	roiManager("select", roi+1);



getSelectionCoordinates( x, y );

dX=-(x[0]-w/2);
dY=-(y[0]-h/2);

run("Translate... ", "x=&dX y=&dY");//run("Draw", "slice");

//waitForUser("Check");
rotateCurrentLineSelection(-angle);run("Draw", "slice");
run("Select None");
}	

// Functions required to do the rotation:
function rotateCurrentLineSelection(theta){
	getSelectionCoordinates( x, y );
	getDimensions(w,h,ch,sl,fr);
	
	newX=newArray(x.length);
	newY=newArray(x.length);
	
		for (i = 0; i < x.length; i++) {

			newX[i]=rotatePointX(theta,x[i],y[i],h,w);
			newY[i]=rotatePointY(theta,x[i],y[i],h,w);
		}
		makeSelection("polyline", newX, newY);
	 }
	 

function rotatePointX(theta,x,y,h,w){
	// Translate to centre origin cartesian and radians
	x1 = x-(w/2); 
	y1 = -(y-(h/2));
	theta = theta*PI/180;
	// Rotate point	
	x2 = (x1*cos(theta))-(y1*sin(theta));
	
	// Translate back to imageJ coordinates
	x2 = x2 + (w/2); 

	point = x2;
	return point;
}



function rotatePointY(theta,x,y,h,w){
	// Translate to centre origin cartesian and radians
	x1 = x-(w/2); 
	y1 = -(y-(h/2));
	theta = theta*PI/180;
	// Rotate point	
	
	y2 = (x1*sin(theta))+(y1*cos(theta));
	// Translate back to imageJ coordinates

	y2 = (h/2)-y2;
	point = y2;
	return point;
}
