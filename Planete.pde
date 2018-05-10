class Planete{
  int x, y, radius;
  float mass;
 
  Planete(int _x, int _y, int rad, float m){
    x = _x;
    y = _y;
    radius = rad;
    mass = m;
  }
  
  void show(){
    noFill();
    stroke(255);
    ellipse(x * Xfactor, y * Yfactor, radius * Xfactor, radius * Yfactor);
  }
  
}