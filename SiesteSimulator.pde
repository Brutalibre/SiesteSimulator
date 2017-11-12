
import processing.video.*;
import lord_of_galaxy.timing_utils.*;
import processing.sound.*;

final byte MENU = 0;
final byte GAME = 1;
final byte  WIN = 2;
final byte LOSE = 3;

final byte NB_SCENES = 4;

final byte FRAME_INTERVAL = 100;

AudioDevice device;
SoundFile[] soundFiles;

final byte SLEEP_SOUND = 0;
final byte STUN_SOUND = 1;
final byte WAKE_SOUND = 2;
final byte VICTORY_SOUND = 3;
final byte DEFEAT_SOUND = 4;
final byte MENU_SOUND = 5;
final byte GAME_SOUND = 6;

final String[] SOUNDS = {"Sleep.wav", "Stun.wav", "Wake.wav", "Victory.wav", "Defeat.wav", "Menu.mp3", "Game.mp3",};

Scene[] scenes;
Scene activeScene;

Teacher teacher;

Capture cam;

Stopwatch timer;

void setup () {
  fullScreen(FX2D);
  //size(1200, 675, FX2D);
  
  
  device = new AudioDevice(this, 48000, 32);
  soundFiles = new SoundFile[SOUNDS.length];
  
  initSounds(soundFiles);
  
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

void resetGame () {
  
  teacher = new Teacher(new Stopwatch(this));
  scenes[GAME] = new   GameScene(loadImage("Assets/background.jpg"), new Eye(), this, GAME_SOUND, WIN, LOSE, teacher);
  scenes[MENU] = new StaticScene(loadImage("Assets/titre.jpg"),      new Eye(), this, MENU_SOUND, GAME, 0.5f);
  scenes[WIN]  = new StaticScene(loadImage("Assets/gg.jpg"),         new Eye(), this, VICTORY_SOUND, MENU, 2.0f);
  scenes[LOSE] = new StaticScene(loadImage("Assets/Perdu.jpg"),      new Eye(), this, DEFEAT_SOUND, MENU, 2.0f);
}

void activateScene (int scene) {
  resetGame();
  activeScene.bgSound.stop();
  activeScene = scenes[scene];
}

void initSounds (SoundFile[] file) {  
  for (int i = 0; i < file.length; i++){
    file[i] = new SoundFile(this, "Sounds/" + SOUNDS[i]);
  }
}