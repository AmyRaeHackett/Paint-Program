/* A paint program which has the theme of mindfulness & meditation
 This program has the basic features of a normal Paint program but it also has
 meditative music, the option to use a black background, and the ability to
 create shapes and patterns which are easy on the eye  */

//loading sound library for the music and sound effects
import processing.sound.*;
SoundFile file;
SoundFile file2;

//images 
PImage inputImage; //loading image
PImage p; //saving image
//toolbar + icons
PImage tools;
PImage icons; 
PImage erase; 
PImage colourSelect; //colours
PImage play; //play pause button
PImage greyBlock; //cleaning up the design of the toolbar

//selecting the colours
color drawColor; 

//for loading images and not enabling user to draw on them until image is fully loaded
boolean noDraw = false;

//for being able to draw on top of a loaded image
boolean drawing = false;

//opacity tool
int opacity = 300;

//for clearing the screen depending on background colour
//also for changing eraser colour
boolean whiteBackground = true;

//shape booleans
boolean rect = false;
boolean circle = false;
boolean line = true;
boolean eraser = false; 

// variables for drawing shapes (rect, ellipse)
int a, b, c, d;

void setup()
{
  //loading images
  colourSelect = loadImage("palette.png");
  tools = loadImage("toolbarLeft.png"); 
  play = loadImage("pause.png");
  icons = loadImage("icons.png");
  greyBlock = loadImage("grey.png"); 

  //loading correct eraser image
  if (eraser == false) {
    erase = loadImage("eraserr.png");
  }

  size(1500, 900);
  background(255);

  /*shapes look better with no fill because it allows the user to make 
   fun shapes and patterns which is good for relaxation purposes*/
  noFill(); 

  strokeWeight(6);
  drawColor = color (0, 0, 0); //getting colour from image

  //music
  file = new SoundFile(this, "eveningbreeze.wav"); //music downloaded from https://www.youtube.com/watch?v=2_kKFjwpwqc&t=64s
  file2 = new SoundFile(this, "file2.wav"); //sound file downloaded from https://www.zapsplat.com/sound-effect-category/magic/
  file.loop(); //music will play indefinitely

  //coordinates for shapes (rect, ellipse)
  a = 0;
  b = 0;
  c = 0;
  d = 0;
}
void draw()
{
  //drawing images
  image(tools, 0, 102);
  image(play, 15, 800);
  image(colourSelect, 0, 0);
  image(icons, 15, 690);
  image(erase, 5, 617.5);
  image(greyBlock, 5, 202);
  image(greyBlock, 5, 360);
  image(greyBlock, 5, 475);
  image(greyBlock, 5, 722);

  //drawing with selected colour
  stroke(drawColor, opacity); 

  //drawing a loaded image and resizing it to fit within the program
  if (inputImage != null && drawing == true) {
    if (inputImage.width > 1500) {
      inputImage.resize(1500, 0);
    }
    if (inputImage.height > 900) {
      inputImage.resize(0, 900);
    }
    drawing = false;
    image(inputImage, 143, 0);
  }
}

void mouseDragged()
{
  //shape end coordinates
  c = mouseX-a;
  d = mouseY-b;

  //drawing with line, rectangle, ellipse or eraser
  if (noDraw == false) {
    if (line == true) {
      line(mouseX, mouseY, pmouseX, pmouseY);
    } else if (rect == true) {
      rect(a, b, c, d);
    } else if (circle == true) {
      ellipse(a, b, c, d);
    } else if (eraser == true) { //changing eraser colour depending on background colour
      if (whiteBackground == false) {
        stroke(0);
      } 
      else if (whiteBackground == true) {
        stroke(255);
      }    
      line(mouseX, mouseY, pmouseX, pmouseY);
    }
  }
}

void mousePressed()
{ 
  //coordinates for drawing beginning of shapes
  a=mouseX;
  b=mouseY;

  //sound effect only triggered when not drawing on canvas section
  if (mouseX < 143) {
    file2.play();
  }

  //selecting colour
  //only able to grab colour from the colour palette, nowhere else
  if (mouseX >= 10 && mouseX < 133 && mouseY < 179 && mouseY >= 7) {
    drawColor = get(mouseX, mouseY);
  }

  /*STROKE SIZES*/
  //stroke size number 1
  if (mouseX > 29 && mouseX < 111 && mouseY > 230 && mouseY < 241) {
    strokeWeight(1);
    tools = loadImage("stroke1.png");
  }

  //stroke size number 2
  if (mouseX > 29 && mouseX < 111 && mouseY > 249 && mouseY < 254) {
    strokeWeight(4);
    tools = loadImage("stroke2.png");
  } 

  //stroke size number 3
  if (mouseX > 29 && mouseX < 111 && mouseY > 266 && mouseY < 277) {
    strokeWeight(10);
    tools = loadImage("stroke3.png");
  } 

  //stroke size number 4
  if (mouseX > 29 && mouseX < 111 && mouseY > 284 && mouseY < 301) {
    strokeWeight(18);
    tools = loadImage("stroke4.png");
  } 

  //stroke size number 5
  if (mouseX > 29 && mouseX < 111 && mouseY > 308 && mouseY < 335) {
    strokeWeight(25);
    tools = loadImage("stroke5.png");
  }

  /*SHAPES*/
  //basic line
  if (mouseX > 47 && mouseX < 88 && mouseY > 438 && mouseY < 473) {
    line = true;
    rect = false;
    circle = false;
    eraser = false;
    tools = loadImage("line.png");
  }
  //square
  if (mouseX > 28 && mouseX < 62 && mouseY > 389 && mouseY < 422) {
    rect = true;
    line = false;
    circle = false;
    eraser = false;
    tools = loadImage("square.png");
  }
  //circle
  if (mouseX > 72 && mouseX < 106 && mouseY > 389 && mouseY < 425) {
    circle = true;
    line = false;
    rect = false;
    eraser = false;
    tools = loadImage("circle.png");
  }
println(mouseX, mouseY);
  //eraser
  if (mouseX > 37 && mouseX < 109 && mouseY > 634 && mouseY < 684) {
    circle = false;
    line = false;
    rect = false;
    eraser = true;
    tools = loadImage("toolbarLeft.png");
    erase = loadImage("eraserr2.png");
  }
  //since the eraser image is an individual image it has to be set as false if the user selects any other shape option
  else if (circle == true || rect == true || line == true) {
    eraser = false;
    erase = loadImage("eraserr.png");
  }

  /*play/pause button*/
  if (mouseX > 33 && mouseX < 100 && mouseY > 823 && mouseY < 860) {
    playButton();
  }

  /*OPACITY LEVELS*/
  //opacity level 1
  if (mouseX > 10 && mouseX < 50 && mouseY > 756 && mouseY < 794) {
    opacity=300;
    tools = loadImage("noopacity.png");
  }

  //opacity level 2
  if (mouseX > 50 && mouseX < 92 && mouseY > 756 && mouseY < 794) {
    opacity=80;
    tools = loadImage("opacity2.png");
  }

  //opacity level 3
  if (mouseX > 90 && mouseX < 135 && mouseY > 756 && mouseY < 794) {
    opacity=30;
    tools = loadImage("opacity3.png");
  }

  /*TOOLS*/
  //saving
  if (mouseX > 19 && mouseX < 50 && mouseY > 688 && mouseY < 729) {
    saveImage();
  }

  //clearing
  if (mouseX > 57 && mouseX < 89 && mouseY > 688 && mouseY < 729) {
    clearCanvas();
  }

  //loading
  if (mouseX > 93 && mouseX < 122 && mouseY > 688 && mouseY < 729) {
    loadingImage();
  }

  /*FILTERS*/
  //threshold
  if (mouseX > 24 && mouseX < 113 && mouseY > 506 && mouseY < 522) {
    filter(THRESHOLD);
    tools = loadImage("threshold.png");
  }

  //grayscale
  if (mouseX > 24 && mouseX < 113 && mouseY > 523 && mouseY < 540) {
    filter(GRAY);
    tools = loadImage("gray.png");
  }

  //posterize
  if (mouseX > 24 && mouseX < 113 && mouseY > 540 && mouseY < 551) {
    filter(POSTERIZE, 6);
    tools = loadImage("posterize.png");
  }

  //blur
  if (mouseX > 24 && mouseX < 113 && mouseY > 551 && mouseY < 568) {
    filter(BLUR, 3);
    tools = loadImage("blur.png");
  }

  //erode
  if (mouseX > 24 && mouseX < 113 && mouseY > 569 && mouseY < 584) {
    filter(ERODE);
    tools = loadImage("erode.png");
  }

  //dilate
  if (mouseX > 24 && mouseX < 113 && mouseY > 584 && mouseY < 605) {
    filter(DILATE);
    tools = loadImage("dilate.png");
  }
}

void keyPressed() {
  /*changing background colour*/
  //NIGHT MODE
  if (key == 'b') {
    background(0);
    colourSelect = loadImage("daymode.png");
    whiteBackground = false;
  }

  //DAY MODE
  if (key == 'w') {
    background(255);
    colourSelect = loadImage("palette.png");
    whiteBackground = true;
  }

  //pause and play button
  if (key == 'p') {
    playButton();
  }

  //saving image
  if (key == 's') {
    saveImage();
  }

  //loading image
  if (key == 'l') {
    loadingImage();
  }

  //clearing the canvas
  if (key == 'c') {
    clearCanvas();
  }
}



void mouseReleased() {
  noDraw = false;
  //used to fix bug
  //loading an image and double clicking drew on top of the image
  //this stops the user from drawing until the image has loaded fully
}

//function for saving images
void fileSelectedSave(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    p.save(selection.getAbsolutePath());
  }
}

//function for loading images
void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    inputImage = loadImage(selection.getAbsolutePath());
    drawing = true;
  }
}

//function for pausing/playing the music
void playButton() {
  if (file.isPlaying()) {
    file.pause();
    play = loadImage("play.png");
  } else {
    file.play();
    play = loadImage("pause.png");
  }
}

void saveImage() {
  p = get(143, 0, 1350, 900);
  selectOutput("Save file:", "fileSelectedSave");
}

void loadingImage() {
  selectInput("Open a file:", "fileSelected");
  noDraw = true;
}

void clearCanvas() {
  if (whiteBackground == true) {
    background(255);
  } else {
    background(0);
  }
  drawing = false;
}

//Thank you!
// :)
