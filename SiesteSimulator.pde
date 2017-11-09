import processing.video.*;
import lord_of_galaxy.timing_utils.*;

final int MENU = 0;
final int GAME = 1;
final int  WIN = 2;
final int LOSE = 3;

final int NB_SCENES = 4;

final int FRAME_INTERVAL = 100;

Scene[] scenes;
Scene activeScene;

Teacher teacher;

Capture cam;

Stopwatch timer;

void setup () {
  //fullScreen(FX2D);
  size(1200, 675, FX2D);
  
  String[] cameras = Capture.list();
  cam = new Capture(this, cameras[0]);
  cam.start();
  
  scenes = new Scene[NB_SCENES];
  
  resetGame();
  
  activeScene = scenes[MENU];
  
  // Using a timer to get a precise frame rate.
  timer = new Stopwatch(this);
  timer.start();
}

void draw () {
  if (timer.millis() >= FRAME_INTERVAL){
    if (cam.available()) {
      cam.read();
      
      fill(0);
      rect(0, 0, width, height);
      
      activeScene.gameLoop(cam);
      
      timer.restart();
    }
  }
}

void resetGame() {
  
  teacher = new Teacher(new Stopwatch(this));
  scenes[GAME] = new   GameScene(loadImage("Assets/background.jpg"), new Eye(), this, WIN, LOSE, teacher);
  scenes[MENU] = new StaticScene(loadImage("Assets/titre.jpg"),      new Eye(), this, GAME, 0.5f);
  scenes[WIN]  = new StaticScene(loadImage("Assets/gg.jpg"),         new Eye(), this, MENU, 2.0f);
  scenes[LOSE] = new StaticScene(loadImage("Assets/Perdu.jpg"),      new Eye(), this, MENU, 2.0f);
}

void activateScene(int scene) {
  resetGame();
  activeScene = scenes[scene];
}