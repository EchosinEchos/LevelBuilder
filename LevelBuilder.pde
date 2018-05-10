ArrayList<Planete> fix = new ArrayList();
ArrayList<Objectif> obj = new ArrayList();

int tailleVert = 150, tailleAcceleration = 350;
int taillePlanete = 30;
float Xfactor, Yfactor;

String fileName;

void setup(){
  Xfactor = width / 1080f;
  Yfactor = height / 1920f;
  
  size(450, 800);
  
  cursor(HAND);
  
}

void draw(){
  background(0);
  
  fill(150);
  noStroke();
  ellipse(mouseX, mouseY, taillePlanete * Xfactor, taillePlanete * Yfactor);
  
  for(Planete p : fix){
    p.show();
  }
  
  for(Objectif o : obj){
    o.show();
  }
  
  
  stroke(255);
  fill(#757575);
  rect(0, (height-tailleVert*Yfactor-tailleAcceleration*Yfactor), width , height);
  noStroke();
  fill(#66BB6A);
  rect(0, (height-tailleVert*Yfactor), width , height);
}


void mouseWheel(MouseEvent event) {
  int nb = event.getCount();
  taillePlanete += nb;
}

void mousePressed(){
  switch(mouseButton){
  case LEFT:
  
  if(mouseY < height-tailleVert*Yfactor-tailleAcceleration*Yfactor){
     fix.add(new Planete(int(mouseX/Xfactor), int(mouseY/Yfactor), taillePlanete, taillePlanete * 1000000000000f));
  }
    break;
  case CENTER:
   if(mouseY < height-tailleVert*Yfactor-tailleAcceleration*Yfactor){
    obj.add(new Objectif(int(mouseX/Xfactor), int(mouseY/Yfactor), taillePlanete));
   }
    break;
  case RIGHT:
    for(int i = obj.size()-1; i >= 0; i--){
      if( sq(mouseX/Xfactor - obj.get(i).x) + sq(mouseY/Yfactor - obj.get(i).y) < sq(obj.get(i).radius/2)){
        obj.remove(i);
      }
    }    
    
    for(int i = fix.size()-1; i >= 0; i--){
      if(sq(mouseX/Xfactor - fix.get(i).x) + sq(mouseY/Yfactor - fix.get(i).y) < sq(fix.get(i).radius/2)){
        fix.remove(i);
      }
    }
    
  }
  
}
  
  void mouseDragged(){
    if(mouseY > height-tailleVert*Yfactor-tailleAcceleration*Yfactor){
      if(mouseY > height-tailleVert*Yfactor){
        tailleVert = tailleVert + round((pmouseY-mouseY)/Yfactor);
      }else{
        tailleAcceleration = tailleAcceleration + round((pmouseY-mouseY)/Yfactor);
      }
    }
  }
  
void keyPressed(){
  switch(keyCode){
    case ENTER:
      println("Saving...");
      selectOutput("Selectionner ou enregistrer le fichier", "saveLevel"); 
      break;
    case 107:    //Plus
      taillePlanete += 10;
      break;
    case 109:    //Minus
      if(taillePlanete-10 > 0){
       taillePlanete -= 10; 
      }
   }
    
}


void saveLevel(File fichier){
  
  if(fichier == null){return;}
  
  fileName = fichier.toString();
  
  JSONArray Level =  new JSONArray();
  JSONArray Obstacles = new JSONArray();
  
  for(int i = 0; i < fix.size(); i++){
   Planete p = fix.get(i);
   JSONObject current = new JSONObject();
   current.setFloat("x", p.x);
   current.setFloat("y", p.y);
   current.setInt("radius", p.radius);
   current.setFloat("mass",p.mass);
   
   Obstacles.setJSONObject(i,current);
  }
  Level.setJSONArray(0,Obstacles);
  
  JSONArray objs = new JSONArray();
  for(int i = 0; i < obj.size(); i++){
    JSONObject current = new JSONObject();
    current.setInt("x",obj.get(i).x);
    current.setInt("y",obj.get(i).y);
    current.setInt("radius",obj.get(i).radius);
    objs.setJSONObject(i,current);
  }
  
  Level.setJSONArray(1,objs);
  
  Level.setInt(2,tailleVert);
  Level.setInt(3,tailleAcceleration);
  
  
  saveJSONArray(Level, fileName);
}