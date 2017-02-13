//bacteria classes
class staph {
  int x;
  int y;
  int captured;
  staph(int xx, int yy){
    x = xx;
    y = yy;
  }
  void render(){
    customFill(219,17,17,5);
    ellipse(x,y,15,15);
    x += random(-2,3);
    y += random(-2,3);
    
    if(random(0,1) < production_rate / 1000 ){
      staphs.add(new staph(x,y));
    }
    if(random(0, 1) < .0008){
      toxins.add(new toxin(x,y));
    }
    if(dist(mouseX,mouseY, x, y) < eraser_size / 2 && eraserOn == 1){
      staphs.remove(this);
  }
  }
}
class toxin {
  int x = 0; 
  int y = 0;
  toxin(int xx, int yy){
    x = xx;
    y = yy;
  }
  void render(){
    customFill(219,17,17,2);
    rect(x,y,5,5);
    
    x += random(-2,3);
    y += random(-2,3);
  }
}