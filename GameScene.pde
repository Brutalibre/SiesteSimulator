int    ENERGY_MAX         = 100;
int    BASE_ENERGY        = ENERGY_MAX/2;
String ENERGY_ASSET_UNDER = "jauge_bg.png";
String ENERGY_ASSET_OVER  = "jauge_overlay.png";
int    ENERGY_BAR_SHRINK  = 4;
float  ENERGY_BAR_MULTI   = 9.0f / 10.0f;
color  ENERGY_COLOR       = color(111, 65, 192);

float STUN_DURATION = 3.1f;

class GameScene extends Scene {
  int energy, energyMax;
  PImage energyBarBg, energyBarOv;
  color energyColor;
  
  boolean isStunned;
  float stunTimer, stunDuration;
  
  int winScene, loseScene;

  GameScene (PImage _bg, Eye _eye, int _winScene, int _loseScene) {
    super(_bg, _eye);
    
    energy = BASE_ENERGY;
    energyMax = ENERGY_MAX;
    energyBarBg = loadImage(ENERGY_ASSET_UNDER);
    energyBarOv = loadImage(ENERGY_ASSET_OVER);
    energyColor = ENERGY_COLOR;
    
    stunDuration = STUN_DURATION;
    stunTimer = 0;
    
    winScene = _winScene;
    loseScene = _loseScene;
  }
  
  void eyeBehaviour() {
    if (eye.isClosed) {
      energy++;
    } else {
      energy--;
    }
    
    if (energy > energyMax)
      energy = energyMax;
    else if (energy < 0) 
      energy = 0;
    
    drawEnergy();
  }
  
  void drawEnergy() {
    imageMode(CENTER);
    
    float posX = width/2;
    float posY = height * ENERGY_BAR_MULTI;
    float barWidth = energyBarOv.width - ENERGY_BAR_SHRINK*2;
    float barHeight = energyBarOv.height - ENERGY_BAR_SHRINK*2;
    
    /* int bgPosX = width / 2 - energyBarBg.width / 2;
    int bgPosY = height / 2 - energyBarBg.height / 2;
    int ovPosX = width / 2 - energyBarOv.width / 2;
    int ovPosY = height / 2 - energyBarOv.height / 2;
    
    translate(0, height / 2 * ENERGY_BAR_MULTI); */
    
    image(energyBarBg, posX, posY);
    
    // Map the score to the gauge width.
    int mappedScore = int(map(energy, 0, energyMax, 0, barWidth));
    
    fill(energyColor);  
    rect(posX - barWidth/2, posY - barHeight/2, mappedScore, barHeight);
    
    image (energyBarOv, posX, posY);
    
    imageMode(CORNER);
  }
}