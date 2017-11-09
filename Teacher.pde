String TEACHER_ASSET =   "Assets/jose.png";
String MOVEMENTS_ASSET = "Assets/Levels.json";

byte SAFE = 0;
byte ALERT = 1;
byte DANGER = 2;

/*
 * This class describes the main antagonist, the teacher.
 * It describes their position at any time and processes their movements.
 */

class Teacher {
  // POSITION CONSTANTS. Must be declared here for correct initialization.
  // These Positions are the key Positions for the teacher movements. 0 -> 1 is Safe, 1 -> 2 is Alert, 2 -> 3 is Danger.
  Position[] ZONE_POS =   { new Position(0.15, 0.472, 0.34, 0.14), new Position(0.15, 0.472, 0.57, 0.14), new Position(0.356, 1.07, 0.69, 0.27), new Position(0.356, 1.07, 0.21, 0.27) };
  
  ArrayList<Movement> movements;
  byte currentMovement;
  
  public byte zone;
  boolean win;
  
  Position currentPos;
  Stopwatch levelTimer;
  
  PImage sprite;
  
  Teacher (Stopwatch _levelTimer) {
    currentPos = ZONE_POS[SAFE];
    levelTimer = _levelTimer;
    
    sprite = loadImage(TEACHER_ASSET);
    movements = new ArrayList<Movement>();
    
    JSONArray json = loadJSONArray(MOVEMENTS_ASSET);
    
    for (int i = 0; i < json.size(); i++) {
      JSONObject mvt = json.getJSONObject(i);
      
      Position posStart = ZONE_POS[mvt.getInt("posStart")];
      Position posEnd = ZONE_POS[mvt.getInt("posEnd")];
      int timeStart = mvt.getInt("timeStart");
      int timeEnd = mvt.getInt("timeEnd");
      int zone = mvt.getInt("posStart");
      
      movements.add(new Movement(posStart, posEnd, timeStart, timeEnd, zone));
    }
    
    currentMovement = 0;
    win = false;
  }
  
  public void startTimer() {
    levelTimer.start();
  }
  
  int getCurrentZone () {
     return movements.get(currentMovement).zone;
  }
  
  boolean checkWin() {
    return win;
  }
  
  void renderAtCurrentPosition () {
    float percent = movements.get(currentMovement).mapTime(levelTimer);
    
    if (percent >= 100) {
      currentMovement ++;
      
      if (currentMovement < movements.size())
        percent = movements.get(currentMovement).mapTime(levelTimer);
      else {
        win = true;
        return;
      }
    }
    
    currentPos = movements.get(currentMovement).mapPosition(percent);
    
    Position realPos = currentPos.getRealPos();
    
    image(sprite, realPos.x, realPos.y, realPos.w, realPos.h);
  }
  
}