int getColorAverage(Capture cam) {
  float colorAvg = 0;
  
  for (int i=0; i < cam.width * cam.height; i++) {
    colorAvg += brightness(cam.pixels[i]);
  }
  
  colorAvg /= cam.width * cam.height;
  
  return int(colorAvg);
}