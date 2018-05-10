class Objectif{
  int x, y, radius;
 
  Objectif(int _x, int _y, int rad){
    x = _x;
    y = _y;
    radius = rad;
  }
  
  void show(){
    fill(255);
    noStroke();
    strokeWeight(1);
    ellipse(x * Xfactor, y * Yfactor, radius * Xfactor, radius * Yfactor);
  }
  
}