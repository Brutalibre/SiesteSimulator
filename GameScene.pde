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

float POINTS_ADD = 1.0f;
float POINTS_SUB = 1.0f;

class GameScene extends Scene {
  int energy, energyMax;
  PImage energyBarBg, energyBarOv;
  
  PImage tables, lastTable;
  
  boolean isStunned;
  float stunTimer;
  
  int winScene, loseScene;

  GameScene (PImage _bg, Eye _eye, int _winScene, int _loseScene) {
    super(_bg, _eye);
    
    energy = BASE_ENERGY;
    energyMax = ENERGY_MAX;
    energyBarBg = loadImage(ENERGY_ASSET_UNDER);
    energyBarOv = loadImage(ENERGY_ASSET_OVER);
    
    tables = loadImage(TABLES_ASSET);
    lastTable = loadImage(LAST_TABLE_ASSET);
    
    stunTimer = 0;
    
    winScene = _winScene;
    loseScene = _loseScene;
  }

  void sceneRender() {
    image(background, 0, 0, width, height);
    // if "behind", draw teacher here
    image(tables, 0, 0, width, height);
    // if "front", draw teacher here
    image(lastTable, 0, 0, width, height);
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
    else if (energy <= 0 || stunTimer != 0.0f)  {
      // Normalize the energy level so it is never negative.
      energy = 0;
      
      // Simulate a low brightness so the eye appears as closed.
      brightnessAvg = 0;
      
      // Energy is 0 and timer has not been initialized yet
      if (stunTimer == 0.0f)
        stunTimer = millis();
        
      // Energy is not 0 anymore but timer is still running : test with stun duration to reset it.
      else if (stunIsOver())
        stunTimer = 0.0f;
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
    return millis() - stunTimer > STUN_DURATION;
  }
}