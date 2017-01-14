//cell classes

//Body Cell(tester)
class body_cell {
  //variables
  int x = 0;
  int y = 0;
  int infected = 0;
  int infectedBy = 0;
  float size = 0;
  int toxinated = 0;
  //initialization
  body_cell(int xx, int yy, float size1) {
    x = xx;//counter vars
    y = yy;//"           "
    size = size1;
  }
  //rendering(not as complicated as it sounds)
  void render() {
    //draws the cell
    if (infected == 0) {
      //if not infected, then draw as white
      if(toxinated == 0){
      customFill(255, 255, 255, 5);
      }
      else{
        customFill(154,254,17,2  );
      }
    } else {
      //else, draw as black
      if (infected > 0) {
        customFill(77, 77, 77, 5);
      }
    }
    //shades the graphics
    ellipse(x, y, size, size);//shape of cell
    //movement
    if(toxinated == 0){
    x += random(-3, 3);
    y += random(-3, 3);
    }
    else if (toxinated == 1){
      
      x += random(-10, 10);
      y += random(-10,10);
      size -= .08;
    }
    for(int i = 0; i < toxins.size(); i++){
      toxin t = toxins.get(i); 
      if(dist(t.x,t.y,x,y) < 10){
        toxinated = 1;
        toxins.remove(t);
      }
    }
    //survival
    if (size < 1) {
      cells.remove(this);
    }
    //infected?
    if (infected > 0) {
      //infection rate
      infected += 1;
      if (infected > 200) {
        //infection has tooken place
        if (infectedBy == 1) {
          //draws new cold viruses
          for(int i = 0; i < 20; i++){
            colds.add(new cold_virus(x,y));
        }
          cells.remove(this);
        }
      }
    }
    if(dist(mouseX,mouseY, x, y) < eraser_size / 2 && eraserOn == 1){
      cells.remove(this);
    }
  }
}
class macrophage_cell {
  //variables
  float x = 0;
  float y = 0;
  float size = 0;
  int toxinated = 0;
  //initialization
  macrophage_cell(int xx, int yy, float size1) {
    x = xx;//counter vars
    y = yy;//"           "
    size = size1;
  }
  //rendering(not as complicated as it sounds)
  void render() {
    //draws the cell
    customFill(92, 190, 234, 5);//shades the graphics
    ellipse(x, y, size, size);//shape of cell
    //movement
    if(toxinated == 0){
    x += random(-3, 3);
    y += random(-3, 3);
    }
    else if (toxinated == 1){
      
      x += random(-6, 6);
      y += random(-6, 6);
      size -= .08;
    }
    for(int i = 0; i < toxins.size(); i++){
      toxin t = toxins.get(i); 
      if(dist(t.x,t.y,x,y) < 10){
        toxinated = 1;
        toxins.remove(t);
      }
    }
    //division rules
    if (size > 30) {
      macrophages.add(new macrophage_cell((int)x, (int)y, size / 2));
      size = size / 2;
    }
    if( size < 1){
      macrophages.remove(this);
    }
    //eats cold viruses flagged with antibodies
    for (int i = 0; i < colds.size(); i++) {
      cold_virus c = colds.get(i);
      if(dist(x,y,c.x,c.y) < 30){
      if(x < c.x){
        x += .2;
      }
      if(x > c.x){
        x -= .2;
      }
      if(y < c.y){
        x += .2;
      }
      if(y > c.y){
        x -= .2;
      }
      if (dist(x, y, c.x, c.y) < 20 && c.captured == 1) { 
        //      antibodies.remove(antibodies.get(i));
        colds.remove(c);
        size += 10;
      }
      }
    }
    //eats bacteria

    //eats staph
    for (int i = 0; i < staphs.size(); i++) {
      staph s = staphs.get(i);
      if (dist(x, y, s.x, s.y) < 10) {
        staphs.remove(s);
        size += 10;
      }
    }
    if(dist(mouseX,mouseY, x, y) < eraser_size / 2 && eraserOn == 1){
      macrophages.remove(this);
    }
  }
}
class killer_t {
  int x = 0;
  int y = 0;
  killer_t(int xx, int yy) {
    x = xx;//counter vars
    y = yy;//"           "
  }
  //rendering(not as complicated as it sounds)
  void render() {
    //draws the cell
    customFill(0, 203, 25, 5);//shades the graphics
    ellipse(x, y, 20, 20);//shape of cell
    //movement
    x += random(-3, 3);
    y += random(-3, 3);

    //kills infected cells
    for (int i = 0; i < cells.size(); i++) {
      //hunts infected cells
      body_cell c = cells.get(i);
      if (dist(c.x, c.y, x, y) < 10 && c.infected > 0) {
        line(c.x, c.y, x, y);
        c.size -= 2;
      }
    }
    if(dist(mouseX,mouseY, x, y) < eraser_size / 2 && eraserOn == 1){
      killers.remove(this);
    }
  }
}
//lymphocytes
class b_cell {
  int on = 0;
  int on_2 = 0;
  int x = 0;
  int y = 0;
  int type = 1;
  int pathogen = 0;
  int startProducing = 0;
  int memory_pathogen = 0;
  int lastSense = 0;
  int lastReplicate = 0;
  b_cell(int xx, int yy, int type1, int pathogen1, int replicate) {
    x = xx;//counter vars
    y = yy;
    type = type1;//"           "
    pathogen = pathogen1;
    lastReplicate = replicate;
  }
  //rendering(not as complicated as it sounds)
  void render() {
    //draws the cell
    if (type == 1) {
      //draws different colors for different types of cell
      customFill(234, 234, 5, 5);
    } else if (type == 2) {
      customFill(156, 7, 232, 5);
    }
    ellipse(x, y, 20, 20);//shape of cell
    //movement
    x += random(-3, 3);
    y += random(-3, 3);

    //makes an antibody
    if (pathogen != 0) {
      //if my remembered pathogen is 1
      if (pathogen == 1) {
        //if regular b_cell
        if (type == 1) {
          //if array counter is less than the total number of cold viruses
          if (on < colds.size() ) {
            if (random(0, 1) < 0.01) {
              //randomly generates an antibody for the cold virus
              antibodies.add(new antibody(x, y, 1, 1, on));
              //iterates through the arraylist
              on += 1;
            }
          }
        }
        if (type == 2) {
          //if a memory cell(purple)
          for (int i = 0; i < colds.size(); i++) {
            //if eating the same cold virus again
            cold_virus c = colds.get(i);
            if (memory_pathogen != 1) {
              //breaks the if-statement
              if (dist(x, y, c.x, c.y) < 20) {
                line(x, y, c.x, c.y);
                lastSense += 1;
                memory_pathogen = 1;
              }
            }
          }
          if (memory_pathogen == 1) {
            if (on < colds.size() && lastSense == 1) {
              
              if (random(0, 1) < 0.1) {
                //since it found the same pathogen, it produces more better antibodies
                  if(lastReplicate != 1){
                  b_cells.add(new b_cell(x,y,2,1, 1));
                  
                  lastReplicate = 1;
                  
                  }
                antibodies.add(new antibody(x, y, 2, 1, on));
                on += 1;
              }
            }
          }
        }
      }
      if (pathogen == 2) {
        //if my pathogen is staph
        if (type == 1) {
          //my type is regular b_cell
          if (on_2 < staphs.size()) {
            //if on_2 as a counter is less than the total number of staph
            if (random(0, 1) < 0.01) {
              //random antibody generation for staph
              antibodies.add(new antibody(x, y, 1, 2, on_2));
              //iterates the counter
              on_2 += 1;
            }
          }
        }
        if (type == 2) {
          for (int i = 0; i < staphs.size(); i++) {
            staph s = staphs.get(i);
            if (memory_pathogen != 2) {
              if (dist(x, y, s.x, s.y) < 20) {
                line(x, y, s.x, s.y);
                memory_pathogen = 2;
              }
            }
          }
          if(memory_pathogen == 2){
            if (on_2 < staphs.size()) {
              if (random(0, 1) < 0.5) {
                //since it found the same pathogen, it produces more better antibodies
                antibodies.add(new antibody(x, y, 2, 2, on_2));
                on_2 += 1;
              }
            }
        }
        }
        
    }
      }
  


    if (startProducing!= 0) {
      //when is activated by a helper_t, duplicates
      for (int i = 0; i < 2; i++) {
        if(pathogen == 1){
        if (random(0, 1) < .5) {
          //random iteration, leads to random number duplicated
          b_cells.add(new b_cell(x, y, 1, 1,0));
          b_cells.add(new b_cell(x, y, 2, 1,0));
        }
        }
        if(pathogen == 2){
          if(random(0,1) < .5){
          b_cells.add(new b_cell(x, y, 1, 2,0));
          b_cells.add(new b_cell(x, y, 2, 2,0));
          }
        }
      }
      //breaks the if-statement
      startProducing = 0;
    }
    if(dist(mouseX,mouseY, x, y) < eraser_size / 2 && eraserOn == 1){
      b_cells.remove(this);
  }
  }
}
class antibody {
  int x;
  int y; 
  int following;
  int type;
  int on;
  int checked = 0;
  antibody(int xx, int yy, int type1, int following1, int on1) {
    x = xx; 
    y = yy;
    on = on1;
    type = type1;
    following = following1;
  }
  void render() {

    if (type == 1) {
      customFill(234, 234, 5, 5);
    }
    if (type == 2) {
      customFill(156, 7, 232, 5);
    }
    ellipse(x, y, 5, 5);
    if (following == 1) {
      if (on < colds.size()) {
        cold_virus c = colds.get(on);
        if(c.captured == 1 && checked != 1 ){
          on += 1;
          
        }
        
        if (dist(x, y, c.x, c.y) < 10) {
          checked = 1;
          c.captured = 1;
          x = c.x;
          y = c.y;
        } else {
          c.captured = 0;
        }

        if (x < c.x) {
          if (type == 1) {
            x += 3;
          }
          if (type == 2) {
            x += 6;
          }
        }
        if (x > c.x) {
          if (type == 1) {
            x -= 3;
          }
          if (type == 2) {
            x -= 6;
          }
        }
        if (y < c.y) {
          if (type == 1) {
            y += 3;
          }
          if (type == 2) {
            y += 6;
          }
        }
        if (y > c.y) {
          if (type == 1) {
            y -= 3;
          }
          if (type == 2) {
            y -= 6;
          }
        }
      } else {
        //x += random(-3, 4);
        //y += random(-3, 4);

        //for (int i = 0; i < macrophages.size(); i++) {
        //  macrophage_cell m = macrophages.get(i);
        //  if (dist(x, y, m.x, m.y) < 5) {
        //    antibodies.remove(this);
        //  }
        //}
        antibodies.remove(this);
      }
    }
    if(following == 2){
      if(on < staphs.size() ){
        staph c = staphs.get(on);
        if(dist(x,y,c.x,c.y) < 10){
          c.captured = 1;
        }
        else{
          c.captured = 0;
        }
        if (x < c.x) {
          if (type == 1) {
            x += 1;
          }
          if (type == 2) {
            x += 3;
          }
        }
        if (x > c.x) {
          if (type == 1) {
            x -= 1;
          }
          if (type == 2) {
            x -= 3;
          }
        }
        if (y < c.y) {
          if (type == 1) {
            y += 1;
          }
          if (type == 2) {
            y += 3;
          }
        }
        if (y > c.y) {
          if (type == 1) {
            y -= 1;
          }
          if (type == 2) {
            y -= 3;
          }
        }
      }
      else{
        //x += random(-3, 4);
        //y += random(-3, 4);

        //for (int i = 0; i < macrophages.size(); i++) {
        //  macrophage_cell m = macrophages.get(i);
        //  if (dist(x, y, m.x, m.y) < 5) {
        //    antibodies.remove(this);
        //  }
        //}
        antibodies.remove(this);
      }
  }
if(dist(mouseX,mouseY, x, y) < eraser_size / 2 && eraserOn == 1){
      antibodies.remove(this);
    }
    //for(int i = 0; i < macrophages.size(); i++){
    //  macrophage_cell m = macrophages.get(i);
    //  if(dist(x,y,m.x,m.y) < 5){
    //   antibodies.remove(this);
    //}  
    //}
  }
}



class helper_t {

  float  x = 0;
  float  y = 0;
  int  info = 0;
  helper_t(int xx, int yy) {
    x = xx;//counter vars
    y = yy;//"           "
  }
  //rendering(not as complicated as it sounds)
  void render() {
    //draws the cell

    customFill(234, 170, 5, 5);
    //shades the graphics
    ellipse(x, y, 20, 20);//shape of cell
    //movement
    x += random(-3, 3);
    y += random(-3, 3);
    //other functions

    if (info != 0) {
      for (int i = 0; i < b_cells.size(); i++) {
        b_cell b = b_cells.get(i);

        if (dist(x, y, b.x, b.y) < 300) {
          if (x < b.x) {
            x += .5;
          };
          if (x > b.x) {
            x -= .5;
          };
          if (y > b.y) {
            y -= .5;
          };
          if (y < b.y) {
            y += .5;
          };

          if (dist(x, y, b.x, b.y) < 20) {
            line(x, y, b.x, b.y);
          };
          if (dist(x, y, b.x, b.y) < 10) {
            b.startProducing = 1;
            b.pathogen = info;
            info = 0;
          };
        }
      }
    }
    if(dist(mouseX,mouseY, x, y) < eraser_size / 2 && eraserOn == 1){
      helpers.remove(this);
    }
  }
}
//phagocyte

class phagocyte {
  int infectedWith = 0;
  int lastEaten = 0;
  float x = 0;
  float y = 0;
  phagocyte(int xx, int yy) {
    x = xx;//counter vars
    y = yy;//"           "
  }
  //rendering(not as complicated as it sounds)
  void render() {
    //draws the cell

    customFill(224, 102, 222, 5);
    //shades the graphics
    ellipse(x, y, 25, 25);//shape of cell
    //movement
    x += random(-3, 3);
    y += random(-3, 3);
    //touching infected cell
    for (int i = 0; i < cells.size(); i++) {
      body_cell b = cells.get(i);
      if (dist(b.x, b.y, x, y) < 8 && b.infected > 0) {
        if (b.infectedBy != infectedWith) {
          lastEaten = b.infectedBy;
          infectedWith = b.infectedBy;
          cells.remove(b);
        }
      }
    }
    //cold virus eating
    for (int i = 0; i < colds.size(); i++) {
      cold_virus b = colds.get(i);
      if (dist(b.x, b.y, x, y) < 8) {
        if (infectedWith != 1) {

          line(b.x, b.y, x, y);
          lastEaten = 1;
          colds.remove(b);
          infectedWith = 1;
        }
      }
    }
    //staph eating
    for (int i = 0; i < staphs.size(); i++) {
      staph s = staphs.get(i);
      if (dist(s.x, s.y, x, y) < 8) {
        if (infectedWith != 2) {

          line(s.x, s.y, x, y);
          lastEaten = 2;
          staphs.remove(s);
          infectedWith = 2;
        }
      }
    }
    if (lastEaten != 0) {
      for (int i = 0; i < helpers.size(); i++) {
        helper_t h = helpers.get(i);

        if (dist(x, y, h.x, h.y) < 200) {
          if (x < h.x) {
            x += .5;
          };
          if (x > h.x) {
            x -= .5;
          };
          if (y > h.y) {
            y -= .5;
          };
          if (y < h.y) {
            y += .5;
          };
        }
        if (dist(x, y, h.x, h.y) < 20) {
          line(x, y, h.x, h.y);
        }
        if (dist(x, y, h.x, h.y)< 10) {
          h.info = lastEaten;
          lastEaten = 0;
        }
      }
    }
    if(dist(mouseX,mouseY, x, y) < eraser_size / 2 && eraserOn == 1){
      phagocytes.remove(this);
    }
  }
}