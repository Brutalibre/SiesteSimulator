/*
 * This class describes a teacher movement.
 * It describes the start position and time, and the arrival position and time.
 */

class Movement {
  Position startPos, endPos;
  int startTime, endTime;
  int zone;
  
  Movement (Position _startP, Position _endP, int _startT, int _endT, int _zone) {
    startPos = _startP;
    endPos = _endP;
    startTime = _startT;
    endTime = _endT;
    zone = _zone;
  }
  
  float mapTime (Stopwatch timer) {
    return map(timer.minute() * 60000 + timer.second() * 1000 + timer.millis(), startTime, endTime, 0, 100);
  }  
  
  Position mapPosition (float percent) {
    if (percent <= 0) {
      percent = 0.001;
    }
      
    float mappedX = map(percent, 0, 100, startPos.x, endPos.x);
    float mappedY = map(percent, 0, 100, startPos.y, endPos.y);
    float mappedW = map(percent, 0, 100, startPos.w, endPos.w);
    float mappedH = map(percent, 0, 100, startPos.h, endPos.h);
    
    return new Position(mappedW, mappedH, mappedX, mappedY);
  }
}