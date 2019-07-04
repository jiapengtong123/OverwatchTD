class RestartWindow extends Window {

  RestartWindow() {
    super(new PVector(width*0.40, height*0.40), //dimensions
      new PVector(width/2, height/2)); 
    // Are you sure you want to quit?
    TextButton yes = new TextButton(int(location.x-(0.45*dimensions.x)/2), int(location.y+(0.25*dimensions.y)/2), int(height*0.075), int(width*0.125), int(height*0.085), "Yes");
    ;
    TextButton no = new TextButton(int(location.x+(0.45*dimensions.x)/2), int(location.y+(0.25*dimensions.y)/2), int(height*0.075), int(width*0.125), int(height*0.085), "No");
    ;
    buttons.add(yes); 
    buttons.add(no);
  }
  void displayUI() {
    //Create Window

    display(); 
    displayHeadings();
    //Button Display
    for (int k = 0; k < buttons.size(); k++) {
      buttons.get(k).display();
    }
  }
  void displayHeadings() {
    fill(255);
    textFont(font, height*0.04);
    text("Are you sure you want to leave?\nAll progress will be lost!", int(location.x-(dimensions.x*0.85)/2), int(location.y-(0.45*dimensions.y)/2)); //Title
  }

  void restartGame() {
    goldCount = int(1000 * difficulty); 
    lifeCount = int(100* difficulty);
    currentMenu = 0;
    roundStart = false;
    level = 1;
    projSyst = new ProjectileSystem();
    agentSyst = new AgentSystem();
    createAgents();
    activeTower = null;
    towerSelected = false; // If Active Buying Tower
    liveTowerSelected = false; // If Active Live Tower; cannot have buying and live tower true
    gameMenu = new GameMenu();
    ps = new ParticleSystem();
  }
}