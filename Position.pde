/*
 * This class describes a position and size, relative to screen width and height.
 * It describes a width, height, x-position and y-position.
 */

class Position {
  float w, h, x, y;

  Position (float _w, float _h, float _x, float _y) {
    w = _w;
    h = _h;
    x = _x;
    y = _y;
  }
  
  public boolean equals (Object compared) {
    return ( compared instanceof Position
             && w == ((Position)compared).w 
             && h == ((Position)compared).h 
             && x == ((Position)compared).x 
             && y == ((Position)compared).y 
           );
  }
  
  Position getRealPos() {
    return new Position( w * width, h * height, x *= width, y * height);
  }
}

/*
 * This class describes a real position and size, in pixels (NOT relative to screen).
 *
class RealPosition extends Position {
  RealPosition (float _w, float _h, float _x, float _y) {
    super(_w, _h, _x, _y);
    
    w *= width;
    h *= height;
    x *= width;
    y *= height;
  }
  
  RealPosition (Position pos) {
    super(pos.w, pos.h, pos.x, pos.y);
    
    w *= width;
    h *= height;
    x *= width;
    y *= height;
  }
}*/