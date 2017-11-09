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
  fullScreen(FX2D);
  
  String[] cameras = Capture.list();
  cam = new Capture(this, cameras[0]);
  cam.start();
  
  teacher = new Teacher(new Stopwatch(this));
  
  scenes = new Scene[NB_SCENES];
  
  scenes[MENU] = new StaticScene(loadImage("Assets/titre.jpg"),      new Eye(), GAME);
  scenes[GAME] = new   GameScene(loadImage("Assets/background.jpg"), new Eye(), WIN, LOSE);
  scenes[WIN]  = new StaticScene(loadImage("Assets/gg.jpg"),         new Eye(), MENU);
  scenes[LOSE] = new StaticScene(loadImage("Assets/Perdu.jpg"),      new Eye(), GAME);
  
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
      
      fill(255);
      text(frameRate, 10, 10);
      
      timer.restart();
    }
  }
}