//virus classes
class cold_virus {
  //variables
  int x = 0;
  int y = 0;
  int captured = 0;
  //initialization
  cold_virus(int xx, int yy){
    x = xx;//counter vars
    y = yy;//"           "
  }
  //rendering(not as complicated as it sounds)
  void render(){
    //draws the virus
 
    customFill(165,165,165,5);
  
    //shades the graphics
    ellipse(x,y,10,10);//shape of virus
    //movement
    x += random(-3,4);
    y += random(-3,4);
   
    //for(int i = 0; i < antibodies.size(); i++){
    //  antibody a = antibodies.get(i);
    //  if(dist(x,y,a.x,a.y) < 10){
    //    captured = 1;
    //  }
  //}
//}    //infection
    if(captured != 1){
    for(int i = 0; i < cells.size(); i++){
      body_cell b = cells.get(i);
      if(dist(x,y,b.x,b.y) < 5 && b.infected == 0){
        b.infected = 1;
        b.infectedBy = 1;
        total_viruses += 1;
        colds.remove(this);
        
      }
      }
    }
    if(dist(mouseX,mouseY, x, y) < eraser_size / 2 && eraserOn == 1){
      colds.remove(this);
  }
  }
}