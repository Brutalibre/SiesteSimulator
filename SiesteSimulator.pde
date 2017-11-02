import processing.video.*;

int MENU = 0;
int GAME = 1;
int  WIN = 2;
int LOSE = 3;

int NB_SCENES = 4;

Scene[] scenes;
Scene activeScene;

Capture cam;

void setup () {
  fullScreen(FX2D);
  
  String[] cameras = Capture.list();
  cam = new Capture(this, cameras[0]);
  cam.start();
  
  scenes = new Scene[NB_SCENES];
  
  scenes[MENU] = new StaticScene(loadImage("titre.jpg"), new Eye(), GAME);
  scenes[GAME] = new   GameScene(loadImage("main.jpg"),  new Eye(), WIN, LOSE);
  scenes[WIN]  = new StaticScene(loadImage("titre.jpg"), new Eye(), MENU);
  scenes[LOSE] = new StaticScene(loadImage("titre.jpg"), new Eye(), GAME);
  
  activeScene = scenes[MENU];
}

void draw () {
  if (cam.available()) {
    cam.read();
    
    fill(0);
    rect(0, 0, width, height);
    
    activeScene.gameLoop(cam);
    
    fill(255);
    text(frameRate, 10, 10);
  }
}