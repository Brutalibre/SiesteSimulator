/*
 * This class describles scenes as menu, victory screen, or defeat screen.
 * It goes over to next scene when the eye closes.
 */

class StaticScene extends Scene {
  int nextScene;
  float stunDuration;
  
  StaticScene(PImage _bg, Eye _eye, PApplet _app, byte _bgSound, int _nextScene, float _stunDuration) {
    super(_bg, _eye, _app, _bgSound);
    nextScene = _nextScene;
    stunDuration = _stunDuration;
  }
  
  void eyeBehaviour() {
    if (firstRender)
      stunTimer.start();
    
    if (stunOpen()) {
      brightnessAvg = 255;
    } 
    else if (eye.isClosed) {
      activateScene(nextScene);
    }
  }
  
  boolean stunOpen() {
    return (stunTimer.second() < stunDuration);
  }
}