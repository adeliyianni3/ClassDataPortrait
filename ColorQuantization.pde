color getOutlier(PImage img) { //https://forum.processing.org/one/topic/getting-average-pixel-color-value-from-a-pimage-that-is-constantly-changing.html
  img.loadPixels();
  ArrayList<Integer> colors = new ArrayList<Integer>();
  for (int i=0; i<img.pixels.length; i++) {
    color c = img.pixels[i];
    float RG = abs(red(c) - green(c));
    float RB = abs(red(c) - blue(c));
    float GB = abs(green(c) - blue(c));
    if (RG > 120 || RB > 120 || GB > 120) {
      colors.add(c);
    }
  }
  int diff = 20;
  while (colors.size()==0) {
  for (int i=0; i<img.pixels.length; i++) {
    color c = img.pixels[i];
    float RG = abs(red(c) - green(c));
    float RB = abs(red(c) - blue(c));
    float GB = abs(green(c) - blue(c));
    if (RG > (120-diff) || RB > (120-diff) || GB > (120-diff)) {
      colors.add(c);
    }
    }
    diff+=20;
  }
  return (getMostCommon(colors));
}

color getMostCommon(ArrayList<Integer> colors) {
  int maxValue = 0;
  int maxCount = 0;
  color first = 0;
  for (int i = 0; i < colors.size(); ++i) {
      int count = 0;
      for (int j = 0; j < colors.size(); j++) {
        if (abs(colors.get(j) - colors.get(i))<=10000) {
          ++count;
        }
      }
      if (count > maxCount) {
          maxCount = count;
          maxValue = colors.get(i);
      }
      first = colors.get(0);
  }
  if (maxValue == 0) {
    maxValue = first;
  }
  return maxValue;
}