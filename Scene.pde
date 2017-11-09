/*
 * This abstract class describes any game scene (screen), its game loop and what happens when the eye closes.
 */

abstract class Scene {
  PImage background;
  Eye eye;
  int brightnessAvg;
  
  Scene (PImage _bg, Eye _eye) {
    background = _bg;
    eye = _eye;
    brightnessAvg = 255;
  }
  
  void gameLoop (Capture cam) {
    brightnessAvg = getColorAverage(cam);
    
    sceneRender();
    eyeBehaviour();
    eye.render(brightnessAvg);
    guiRender();
  }
  
  abstract void eyeBehaviour();
  
  void sceneRender () {
    image(background, 0, 0, width, height);
  }
  
  void guiRender () {}
}