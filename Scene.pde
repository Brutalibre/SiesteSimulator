/*
 * This abstract class describes any game scene (screen), its game loop and what happens when the eye closes.
 */

abstract class Scene {
  PImage background;
  Eye eye;
  int brightnessAvg;
  
  boolean firstRender;
  Stopwatch stunTimer;
  
  Scene (PImage _bg, Eye _eye, PApplet app) {
    background = _bg;
    eye = _eye;
    brightnessAvg = 255;
    
    stunTimer = new Stopwatch(app);
    
    firstRender = true;
  }
  
  void gameLoop (Capture cam) {
    
    brightnessAvg = getColorAverage(cam);
    
    sceneRender();
    eyeBehaviour();
    eye.render(brightnessAvg);
    guiRender();
    
    if (firstRender) 
      firstRender = false;
  }
  
  abstract void eyeBehaviour();
  
  void sceneRender () {
    image(background, 0, 0, width, height);
  }
  
  void guiRender () {}
}