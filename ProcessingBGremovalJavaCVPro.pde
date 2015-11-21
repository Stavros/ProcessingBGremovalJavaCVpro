// Stavros Kalapothas
// Background substraction using javaCVPro library in Processing
// Created on 12/2012

// jacvPro background substraction
// w/ accumulate() & addWeighted()

import codeanticode.gsvideo.*;
import monclubelec.javacvPro.*;

GSCapture cam1; // create camera object

OpenCV opencv; // create opencv object

PImage imgSrc; // create pixalerated image object
PImage bg;

int widthCapture=320;
int heightCapture=240;
int fpsCapture=20;

void setup(){ // initialization

        size(widthCapture*2,heightCapture*2); // create a double density space to show 4 images of webcam resolution(320,240)

	cam1 = new    GSCapture(this,widthCapture,heightCapture); // Initialise webcam
	cam1.start();

	opencv = new OpenCV(this); // initialise objet OpenCV
        opencv.allocate(widthCapture,heightCapture); // create buffer image

        bg = loadImage("karate-kid.jpg"); // create background image

        println("Press SPACE to memorize image from webcam!");
        delay(2000);

}

void  draw() {

  if (cam1.available() == true) {
    cam1.read();

    imgSrc=cam1.get(); // capture webcam image in buffer
    opencv.copy(imgSrc); // add image on opencv object

    image(opencv.image(), 0, 0); // show image on applet

    opencv.absDiff(); // apply absDiff on image
    //opencv.copy(imgSrc);
    //opencv.invert();
    //opencv.remember();
    //opencv.gray();
    image(opencv.getMemory2(),0,heightCapture); // show 3rd image

    //------ VARIOUS FILTERS -------//

    //opencv.threshold(opencv.Memory2, 0.1,"BINARY");

    //opencv.average(opencv.Buffer, opencv.Memory, opencv.Buffer);
    //image(opencv.getBuffer(),0 ,heightCapture);

    opencv.accumulate(opencv.Buffer, opencv.Memory,0.05, opencv.Memory2, 20,1, true);
    image(opencv.getMemory2(),0 ,heightCapture); // show 3rd image

    opencv.addWeighted(opencv.Buffer, 1, opencv.Memory, 0.8, 0, opencv.Buffer);
    image(opencv.getBuffer(),widthCapture,heightCapture); // 4th image

  }

}

void keyPressed() { // check key pressed

	if(key==' ') {

        opencv.copy(bg); // add bg image on opencv object
        //opencv.absDiff(); // try absDiff on opencv object
        opencv.remember();  // store opencv object on memory
    	image(opencv.getMemory(),widthCapture,0); // add image recalled from memory

	}

}

public void stop(){ // stop
  cam1.delete();
  super.stop();
}
