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
  
  Position getRealPosition() {
    return new Position (
      w * width,
      h * height,
      x * width,
      y * height
    );
  }
}