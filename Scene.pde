/*
 * This abstract class describes any game scene (screen), its game loop and what happens when the eye closes.
 */

abstract class Scene {
  PImage background;
  Eye eye;
  
  Scene (PImage _bg, Eye _eye) {
    background = _bg;
    eye = _eye;
  }
  
  void gameLoop (Capture cam) {
    int brightnessAvg = getColorAverage(cam);
    
    image(background, 0, 0, width, height);
    
    eye.render(brightnessAvg);
    eyeBehaviour();
  }
  
  abstract void eyeBehaviour();
}