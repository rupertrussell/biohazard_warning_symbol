// Created with Processing 3.5 Java 
// artwork on redbubbe at: https://www.redbubble.com/shop/ap/24852476
// code on github at: https://github.com/rupertrussell/biohazard_warning_symbol

// Biohazard Warning Symbol
// Code by Rupert Russell
// rupert.russell1@gmail.com
// Released under Creative Commons Licence
// Licensed under Creative Commons Attribution ShareAlike
// https://creativecommons.org/licenses/by-sa/3.0
// https://creativecommons.org/licenses/GPL/2.0/
// Based on the design https://cws.auburn.edu/shared/content/files/1621/biohazard-history.pdf
// https://archive.org/stream/federalregister39kunit#page/n849/mode/1up

//http://99percentinvisible.org/article/biohazard-symbol-designed-to-be-memorable-but-meaningless/

float a = 15;  // Basic Unit size of Warning symbol
float b = 3.5 * a;
float c = 4 * a;
float d = 6 * a;
float e = 11 * a;
float f = 15 * a;
float g = 21 * a;
float h = 30 * a;

PGraphics foreground;
PGraphics clearLines;
PGraphics arc;
PGraphics mask;
PGraphics combined;

void setup() {
  size(800, 800);
  int xWidth = 800;
  int yHeight = 800;

  foreground = createGraphics(xWidth, yHeight);
  clearLines = createGraphics(xWidth, yHeight);
  arc = createGraphics(xWidth, yHeight);
  mask = createGraphics(xWidth, yHeight);
  combined = createGraphics(xWidth, yHeight); 

  background(255, 255, 255);
  noLoop();
}

void draw() {

  // initialise the combined layer
  // There is noting in this layer except a white backgroud 
  // we will build this layer from the component layers below
  combined.beginDraw();
  combined.background(255);
  combined.endDraw();

  foreground.beginDraw();
  foreground.noStroke();

  // 3 Main Circles
  foreground.pushMatrix();  // remember the current default screen settings
  foreground.translate(width / 2, height / 2);  // move the origin to the center of the screen

  foreground.rotate(radians(90 - 90));
  foreground.fill(255, 69, 0);
  foreground.ellipse(0, -11 * a, a * 30, a * 30);
  foreground.popMatrix();  // return to the default screen settings for rotation

  foreground.pushMatrix();  // remember the current default screen settings
  foreground.translate(width / 2, height / 2);
  foreground.rotate(radians(210 - 90));
  foreground.ellipse(0, 0 - 11 * a, a * 30, a * 30);

  foreground.popMatrix();  // return to the default screen settings for rotation
  foreground.pushMatrix();  // remember the current default screen settings
  foreground.translate(width / 2, height / 2);
  foreground.rotate(radians(330 - 90 ));
  foreground.ellipse(0, 0 - 11 * a, a * 30, a * 30);
  foreground.popMatrix();  // return to the default screen settings for rotation
  foreground.endDraw();

  // 3 inner white Circles
  foreground.beginDraw();
  foreground.pushMatrix();  // remember the current default screen settings
  foreground.translate(width / 2, height / 2);  // move the origin to the center of the screen
  foreground.rotate(radians(90 - 90));
  foreground.fill(255, 255, 255);
  foreground.ellipse(0, -15 * a, a * 21, a * 21);
  foreground.popMatrix();  // return to the default screen settings for rotation

  foreground.pushMatrix();  // remember the current default screen settings
  foreground.translate(width / 2, height / 2);
  foreground.rotate(radians(210 - 90));
  foreground.ellipse(0, 0 - 15 * a, a * 21, a * 21);
  foreground.popMatrix();  // return to the default screen settings for rotation

  foreground.translate(width / 2, height / 2);
  foreground.rotate(radians(330 - 90 ));
  foreground.ellipse(0, 0 - 15 * a, a * 21, a * 21);

  // foreground.clear();

  // center white circle
  foreground.noStroke();
  foreground.fill(255);
  foreground.ellipse(0, 0, a * 6, a * 6);
  foreground.endDraw();

  // clear lines ------------------------------------------
  clearLines.beginDraw();
  clearLines.smooth();
  clearLines.fill(255, 255, 255);
  clearLines.noStroke();
  clearLines.pushMatrix();
  clearLines.translate(width / 2, height / 2);  // move the origin to the center of the screen
  clearLines.rotate(radians(210 -90 ));
  clearLines.rect(- 0.5 * a, - a * 5, a, a * 5);
  clearLines.popMatrix();
  clearLines.endDraw();
  // End clear lines ------------------------------------------

  // Arc ------------------------------------------
  arc.beginDraw();
  arc.fill(255, 69, 0);
  arc.noStroke();
  // first large orange circle
  arc.ellipse(width / 2, height / 2, (e - a + b) * 2, (e - a + b) * 2);

  // White inner circle
  arc.fill(255);
  arc.ellipse(width / 2, height / 2, (e - a) * 2, (e - a) * 2);
  arc.endDraw();
  // End Arc ------------------------------------------


  // Magenta masks ---------------------
  mask.beginDraw();
  mask.noStroke();
  mask.fill(255, 0, 255);
  mask.pushMatrix();  // remember the current default screen settings
  mask.translate(width / 2, height / 2);  // move the origin to the center of the screen

  mask.rotate(radians(90 - 90));
  mask.ellipse(0, 0 - f, (g - a), (g - a));
  mask.popMatrix();  // return to the default screen settings for rotation

  mask.pushMatrix();  // remember the current default screen settings
  mask.translate(width / 2, height / 2);
  mask.rotate(radians(210 - 90));
  mask.ellipse(0, 0 - f, (g - a), (g - a));
  mask.popMatrix();  // return to the default screen settings for rotation

  mask.pushMatrix();  // remember the current default screen settings
  mask.translate(width / 2, height / 2);
  mask.rotate(radians(330 - 90 ));
  mask.ellipse(0, 0 - f, (g - a), (g - a));
  mask.popMatrix();  // return to the default screen settings for rotation
  mask.endDraw();

  // End Magenta masks ---------------------

  //pixel array method for combining layers  ********************************
  // build up the combined image from layers using masks

  mask.loadPixels(); 
  combined.loadPixels();
  arc.loadPixels(); 
  foreground.loadPixels();

  // add the 3 arcs to the combined image
  for (int p = 0; p <mask.width * mask.height; p++) {
    if (mask.pixels[p]==#FF00FF) {
      // Make White on PG1 transparent and "show" pg2 pixels through it.
      combined.pixels[p]= arc.pixels[p]; //replace it with the new color
    }
  }


  // add all non white pixels in the foreground to the combined image
  for (int p = 0; p <foreground.width * foreground.height; p++) {
    if (foreground.pixels[p] != #FFFFFF) {
      combined.pixels[p]= foreground.pixels[p]; //replace it with the new color
    }
  }


  mask.updatePixels();//then update the pixels
  arc.updatePixels();//then update the pixels
  combined.updatePixels();//then update the pixels

  // Draw 3 white gaps in the 3 main circles  ==========================
  // Gap in the top circle
  combined.beginDraw();
  combined.image(combined, 0, 0);
  combined.noStroke();
  combined.rect(width /2 - c/2, height /2  - h + c /2, c, c);

  // White gap in right hand lower circle
  combined.pushMatrix();  // remember the current default screen settings
  // combined.translate(width / 2 - c / 2, height / 2);
  combined.translate(width / 2, height / 2);

  combined.rotate(radians(210 - 90));
  combined.rect(- c/3, - h + c /3, c, c);
  combined.popMatrix();

  // White gap in left lower hand circle
  combined.pushMatrix();  // remember the current default screen settings
  combined.translate(width / 2, height / 2 );
  // combined.rotate(radians(210 - 90));
  combined.rotate(radians(330 - 90 ));
  combined.rect(- c/2, - h + c /3, c, c);
  combined.popMatrix();


  combined.endDraw();
  combined.updatePixels();//then update the pixels
  // End Draw 3 white gaps in the 3 main circles  ==========================

  // Draw 3 small white gaps attached to the inner most circle =====================

  // Gap in the top circle
  combined.beginDraw();
  combined.image(combined, 0, 0);
  combined.noStroke();

  combined.fill(255);
  combined.rect(width /2 - a/2, height /2  - a * 6, a, a * 4);

  // White gap in right hand lower circle
  combined.pushMatrix();  // remember the current default screen settings
  combined.translate(width / 2, height / 2 );
  combined.stroke(0);
  combined.popMatrix();  // restore the default screen settings

  // right hand side line
  combined.pushMatrix();  // remember the current default screen settings
  //  combined.translate(width / 2, height / 2 + a /2 );
  combined.translate(width / 2, height / 2 );
  combined.noStroke();
  combined.rotate(radians(210 + 90));
  combined.fill(255);
  combined.rect(0 - a /2, 0 + a /2, a, a * 6);
  combined.line(0, 0 + a /2, 100, 600);
  combined.popMatrix();

  // White gap in left lower hand circle
  combined.pushMatrix();  // remember the current default screen settings
  combined.translate(width / 2 - a, height / 2 );
  combined.stroke(0);
  combined.noStroke();
  combined.rotate(radians(330 + 90));
  combined.fill(255);
  combined.rect(0, 0, a, a * 6);
  combined.popMatrix();


  combined.endDraw();
  combined.updatePixels();//then update the pixels

  // End Drawing 3 small white gaps attached to the inner most circle =====================



  // display the final results

  background(255);
  image(arc, 0, 0);
  save("arc.png");

  background(255);
  image(foreground, 0, 0);
  save("foreground.png");

  background(255);
  image(mask, 0, 0);
  save("mask.png");
  background(255);

  image(foreground, 0, 0);
  image(mask, 0, 0);
  save("mask+arcs.png");

  background(255);
  image(combined, 0, 0);
  save("Biohazard_800.png");
}
