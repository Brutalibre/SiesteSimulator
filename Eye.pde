int MIN_LUM = 25;
int MAX_LUM = 255/2;
int CLOSED_LUM = MAX_LUM / 4;
float EYE_WIDTH_MULTIPLIER  = 1.65;
float EYE_HEIGHT_MULTIPLIER = 1.65;
String EYE_SHAPE = "Assets/eyeContour.svg";

class Eye {
  float baseWidth, baseHeight;
  
  int scoringLevel, minCamLuminosity, maxCamLuminosity;
  
  int mappedBrightness;
  boolean isClosed;
  
  PShape shape;
  
  Eye () {
    minCamLuminosity = MIN_LUM;
    maxCamLuminosity = MAX_LUM;
    scoringLevel = CLOSED_LUM;
    
    mappedBrightness = mapBgt((minCamLuminosity + maxCamLuminosity) / 2);
    isClosed = false;
    
    baseWidth = width * EYE_WIDTH_MULTIPLIER;
    baseHeight = height * EYE_HEIGHT_MULTIPLIER;
    
    shape = loadShape(EYE_SHAPE);
    shape.disableStyle();
  }
  
  /*
   * Draw the eye depending on the camera average brightness.
   */ 
  void render (int brightnessAvg) {
    mappedBrightness = mapBgt(brightnessAvg);
    isClosed = brightnessAvg <= scoringLevel;
    
    shapeMode(CENTER);
    shape(shape, width/2, height/2, baseWidth, mappedBrightness);
    
    // This is just to fill the blanks left above and under the shape.
    fill(0);
    rect(0, 0, width, height/2 - mappedBrightness/2 + mappedBrightness/8);
    rect(0, height/2 + mappedBrightness/2 - mappedBrightness/8, width, height/2 -mappedBrightness/2 + mappedBrightness/8);
  }

  /* 
   * Map the camera average brightess to fit the screen height.
   * Also normalize the extreme values.
   */
  int mapBgt(int brightnessAvg) {
    if (brightnessAvg <= minCamLuminosity)        brightnessAvg = minCamLuminosity;
    else if (brightnessAvg >= maxCamLuminosity)   brightnessAvg = maxCamLuminosity;
    
    // Subtract 1 to min luminosity bc resizing the img to 0 causes a crash !
    return int(map(brightnessAvg, minCamLuminosity-1, maxCamLuminosity, 0, baseHeight));
  }
}