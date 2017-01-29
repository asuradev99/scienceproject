//notes:
//asdasdasd
//current problem: if the number of antibodies is the same as the number of viruses when a macrophage
//tries to eat it, it glitches.
//save test
//have the helper_t cells produce cytokines that track down the b_cells that promotes antibody production
//model immune and un-immune cells
//simulate vacination too
//a macrophage eats bacteria outside of a cell, or viruses with an antibody attached to it.
//a killer t cell kills infected cells with viruses in them.
//bacteria don't invade cells, they stay on the outside and produxe toxins.
//Use a global variable for the production of antigens.
//this is the code for my science project.
//rate if response in influenza virus(to do)
//allergies
//variables
int infected = 0; 
int total_cells = 0;
int total_viruses = 0;
int recognized_cold_virus = 0;
int recognized_staph = 0;
float production_rate = 1;
//timer vars
float time = 0;
int seconds = 0; 
int eraserOn = -1;
int eraser_size = 100;
//array lists

//cells
ArrayList <body_cell> cells;
ArrayList <macrophage_cell> macrophages;
ArrayList <killer_t> killers;
ArrayList <b_cell>b_cells;
ArrayList<helper_t> helpers;
ArrayList<phagocyte> phagocytes;
//pathogens
ArrayList <cold_virus> colds;
ArrayList <staph> staphs;
//antibody
ArrayList <antibody> antibodies;
//bacterial toxins
ArrayList<toxin> toxins;
//list setup
void setup() {
  //time = millis();
  //initializing the vars
  cells = new ArrayList<body_cell>(); 
  macrophages = new ArrayList<macrophage_cell>();
  colds = new ArrayList<cold_virus>();
  killers = new ArrayList<killer_t>();
  b_cells = new ArrayList<b_cell>();
  helpers = new ArrayList<helper_t>();
  phagocytes = new ArrayList<phagocyte>();
  antibodies = new ArrayList<antibody>();
  staphs = new ArrayList<staph>();
  toxins = new ArrayList<toxin>();
  //customs
  //size(1000, 650);
  fullScreen();
  //first_setup(100, 1,2, width/2, height/2);
  //second_setup(10,0,20, width/2, height/2);
}
//main loop
void draw() {
  
  background(0, 0, 0);
  //renders cells
  for (int i = 0; i < cells.size(); i++) {
    body_cell b = cells.get(i);
    b.render();
  }
  
  for (int i = 0; i < colds.size(); i++) {
    cold_virus c = colds.get(i);
    c.render();
  }
  for (int i = 0; i < macrophages.size(); i++) {
    macrophage_cell m = macrophages.get(i);
    m.render();
  }
  for (int i = 0; i < killers.size(); i++) {
    killer_t k = killers.get(i);
    k.render();
  }
  for (int i = 0; i < b_cells.size(); i++) {
    b_cell b = b_cells.get(i);
    b.render();
  }
  for (int i = 0; i < helpers.size(); i++) {
    helper_t h = helpers.get(i);
    h.render();
  }
  for (int i = 0; i < phagocytes.size(); i++) {
    phagocyte p = phagocytes.get(i);
    p.render();
  }
  for (int i = 0; i < staphs.size(); i++) {
    staph s = staphs.get(i);
    s.render();
  }
  for (int i = 0; i < antibodies.size(); i++) {
    antibody a = antibodies.get(i);
    a.render();
  }
  for(int i = 0; i < toxins.size(); i++){
    toxin t = toxins.get(i);
    t.render();
  }
  
  timer();
  drawStats();
  userInterface();
  eraser();
}

//functions
//handy fill function
void customFill(int r, int g, int b, int w) {
  stroke(r  - 30, g - 30, b - 30);
  strokeWeight(w);
  fill(r, g, b);
}
//keyPressed function, draws cells
void keyPressed() {
  if (key == '1') {
    //adds a body cell
    cells.add(new body_cell(mouseX, mouseY, 20));
  }
  if (key == '2') {
    //adds a macrophage cell
    macrophages.add(new macrophage_cell(mouseX, mouseY, 25));
  }
  if (key == '3') {
    //adds a killer t cell
    killers.add(new killer_t(mouseX, mouseY));
  }
  if (key == 'q') {
    //adds a cold virus
    colds.add(new cold_virus(mouseX, mouseY));
  }
  if (key == '4') {
    //adds a b cell
    b_cells.add(new b_cell(mouseX, mouseY, 1, 0,0));
  }
  if (key == '5') {
    //adds a helper t cell
    helpers.add(new helper_t(mouseX, mouseY));
  }
  if (key == '6') {
    //adds a phagocyte
    phagocytes.add(new phagocyte(mouseX, mouseY));
  }
  if (key == 'w') {
    //adds staphylococcus aureus
    staphs.add(new staph(mouseX, mouseY));
  }
  if(keyCode == RIGHT){
    production_rate += 1;
  }
  if(keyCode == LEFT){
    production_rate -= 1;
  }
  if(keyCode == ' '){
    eraserOn *= -1;
  }
  if(keyCode == UP){
    eraser_size += 10;
  }
  if(keyCode == DOWN){
    eraser_size -= 10;
  }
}
void drawStats() {
  total_cells = cells.size() + macrophages.size() + killers.size() + helpers.size() + b_cells.size() + phagocytes.size();
  total_viruses = colds.size();
  fill(255, 255, 255);
  textSize(25);
  text("Stats:", 20, 30);
  textSize(15);
  text("Body Cells: " + cells.size(), 20, 50);
  text("Viruses: " + total_viruses, 20, 70);
  text("Bacteria: " + staphs.size(), 20, 90);
  text("Body Health: ", 20, 110);
  
  customFill(34,193,23,0);
  rect(120, 95, total_cells / 2, 20);
}
void userInterface(){
 
  customFill(255,255,255,0);
  textSize(25);
  text("User Inputs" ,20,150);
  textSize(15);
  text("Bacteria Production Rate: " + production_rate, 20,170);
  text("Timer: " +  seconds, 20, 190);
  text("Eraser Size: " + eraser_size, 20,210);
}


void timer(){
  infected = 0;
  time += 1 + (total_viruses / 100) * .08;
  for(int i = 0; i < cells.size(); i++){
      body_cell b = cells.get(i);
      if(b.infected > 0 ){
        infected += 1;
      }
    }
  if(antibodies.size() > 500){
    time += antibodies.size() / 1000 * .10;
  }
  if(time >= 60){
    
    time = 0;
    seconds += 1;
    
    println(seconds + " , " + cells.size() + " , " + total_viruses + " , " + infected + ", " + staphs.size());
    
  }
  
}
void first_setup(int body_cells, int viruses,int killers1,  int start_x, int start_y){
  for(int i = 0; i < body_cells; i++){
    cells.add(new body_cell(start_x + (int) random(-20,20),start_y + (int) random(-20,20), 20));
  }
  for(int i = 0; i < viruses; i++){
    colds.add(new cold_virus(start_x + (int) random(-20, 20),start_y + (int)random(-20,20)));
  }
  for(int i = 0; i < killers1; i++){
    killers.add(new killer_t(start_x + (int) random(-80,80), start_y + (int) random(-80,80)));
  }
  for(int i = 0; i < 10; i++){
    macrophages.add(new macrophage_cell(start_x, start_y, 25));
  }
  for(int i = 0; i < 10; i++){
    b_cells.add(new b_cell(start_x + (int)random(-50,50),start_y + (int) random(-50,50), 1,0,0));
    helpers.add(new helper_t(start_x + (int) random(-50,50), start_y + (int) random(-50,50)));
    phagocytes.add(new phagocyte( start_x + (int) random(-50,50), start_y + (int) random(-50,50)));
  }
}
void second_setup(int cell, int macrophages1, int bacteria, int startX, int startY){
  for(int i = 0; i < macrophages1; i++){
    macrophages.add(new macrophage_cell(startX, startY, 25)); 
  }
  for(int i = 0; i < bacteria; i++){
    staphs.add(new staph(startX + (int) random(-50, 50), startY + (int) random(-50,50)));
  }
  for(int i = 0; i < cell; i++){
    cells.add(new body_cell(startX, startY, 20));
  }
}
void eraser(){
  if(eraserOn == 1){
    fill(255,255,255, 100);
    ellipse(mouseX,mouseY, eraser_size,eraser_size);
  }
}