/*
 * This class describles scenes as menu, victory screen, or defeat screen.
 * It goes over to next scene when the eye closes.
 */

class StaticScene extends Scene {
  int nextScene;
  
  StaticScene(PImage _bg, Eye _eye, int _nextScene) {
    super(_bg, _eye);
    nextScene = _nextScene;
  }
  
  void eyeBehaviour() {
    if (eye.isClosed) {
      activeScene = scenes[nextScene];
    }
  }
}