int    ENERGY_MAX         = 200;
int    BASE_ENERGY        = ENERGY_MAX/2;
String ENERGY_ASSET_UNDER = "Assets/jauge_bg.png";
String ENERGY_ASSET_OVER  = "Assets/jauge_overlay.png";
int    ENERGY_BAR_SHRINK  = 4;
float  ENERGY_BAR_MULTI   = 9.0f / 10.0f;
color  ENERGY_COLOR       = color(111, 65, 192);

String TABLES_ASSET     = "Assets/rangs.png";
String LAST_TABLE_ASSET = "Assets/dernierrang.png";

float STUN_DURATION = 3000.0f;

float POINTS_ADD = 1.5f;
float POINTS_SUB = 1f;

class GameScene extends Scene {
  float energy;
  int energyMax;
  PImage energyBarBg, energyBarOv;
  
  PImage tables, lastTable;
  
  boolean isStunned;
  
  int winScene, loseScene;
  
  Teacher teacher;

  GameScene (PImage _bg, Eye _eye, PApplet app, int _winScene, int _loseScene, Teacher _teacher) {
    super(_bg, _eye, app);
    
    energy = BASE_ENERGY;
    energyMax = ENERGY_MAX;
    energyBarBg = loadImage(ENERGY_ASSET_UNDER);
    energyBarOv = loadImage(ENERGY_ASSET_OVER);
    
    tables = loadImage(TABLES_ASSET);
    lastTable = loadImage(LAST_TABLE_ASSET);
    
    stunTimer.pause();
    
    winScene = _winScene;
    loseScene = _loseScene;
    
    teacher = _teacher;
  }

  void sceneRender() {
    if (firstRender) {
      teacher.startTimer();
    }
    
    // This stops the rendering of the current scene to directly jump to the winning scene.
    if (teacher.checkWin()) {
      activateScene(winScene);
      return;
    }
    
    if (checkLose()) {
      activateScene(loseScene);
      return;
    }
    
    image(background, 0, 0, width, height);
      
      // This means the teacher is behind the tables.
    if (teacher.getCurrentZone() == SAFE || teacher.getCurrentZone() == ALERT) {
      teacher.renderAtCurrentPosition();
      image(tables, 0, 0, width, height);
    }
    else {
      image(tables, 0, 0, width, height);
      teacher.renderAtCurrentPosition();
    }
    
    image(lastTable, 0, 0, width, height);
  }
  
  boolean checkLose() {
    return teacher.getCurrentZone() == DANGER && eye.isClosed;
  }

  void eyeBehaviour() {
    if (eye.isClosed) {
      energy += POINTS_ADD;
    } else {
      energy -= POINTS_SUB;
    }
    
    if (energy > energyMax)
      energy = energyMax;
      
    // If the energy falls to 0, the student falls asleep for some time.
    // If the stunTimer is not 0, it means that the student is already asleep.
    else if (energy <= 0 || !stunTimer.isPaused())  {
      // Simulate a low brightness so the eye appears as closed.
      brightnessAvg = 0;
      
      // Energy is 0 and timer has not been initialized yet
      if (stunTimer.isPaused()) {
        stunTimer.restart();
      }
      // Energy is not 0 anymore but timer is still running : test with stun duration to reset it.
      else if (stunIsOver()) {
        stunTimer.reset();
        println(stunTimer.millis());
      }
    }
  }
  
  void guiRender () {
    imageMode(CENTER);
    
    float posX = width/2;
    float posY = height * ENERGY_BAR_MULTI;
    float barWidth = energyBarOv.width - ENERGY_BAR_SHRINK*2;
    float barHeight = energyBarOv.height - ENERGY_BAR_SHRINK*2;
    
    image(energyBarBg, posX, posY);
    
    // Map the score to the gauge width.
    int mappedScore = int(map(energy, 0, energyMax, 0, barWidth));
    
    fill(ENERGY_COLOR);  
    rect(posX - barWidth/2, posY - barHeight/2, mappedScore, barHeight);
    
    image (energyBarOv, posX, posY);
    
    imageMode(CORNER);
  }
  
  boolean stunIsOver() {
    return (stunTimer.second() * 1000 + stunTimer.millis()) >= STUN_DURATION;
  }
}