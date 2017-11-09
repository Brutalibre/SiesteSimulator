Position[] SAFE_ZONE_POS = {
  new Position(0.15, 0.472, 0.34, 0.14),
  new Position(0.15, 0.472, 0.57, 0.14)
};

Position[] ALERT_ZONE_POS = {
  SAFE_ZONE_POS[1],
  new Position(0.356, 1.07, 0.69, 0.27)
};
Position[] DANGER_ZONE_POS = {
  ALERT_ZONE_POS[1],
  new Position(0.356, 1.07, 0.21, 0.27)
};
/*
 * This class describes the main antagonist, the teacher.
 * It describes their position at any time and processes their movements.
 */

class Teacher {
  Position currentPos;
  Stopwatch levelTimer;
  
  Teacher (Stopwatch _levelTimer) {
    currentPos = SAFE_ZONE_POS[0].getRealPosition();
    levelTimer = _levelTimer;
  }
}