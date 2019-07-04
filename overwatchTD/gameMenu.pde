class GameMenu extends Menu {
  ArrayList<Tower> uiTowers; //Holds Sidebar Towers
  ArrayList<Tower> liveTowers; //Holds In-Game Towers
  boolean sellButtonActive; //prevents adding multiple "Sell" buttons
  GameMenu() {
    super("game_mode_bg_1.PNG");
    sellButtonActive = false;

    uiTowers = new ArrayList<Tower>();
    liveTowers = new ArrayList<Tower>();

    TextButton home = new TextButton(int(width*0.9375), int(height*0.875), font_size, int(width*0.1), int(height*0.06), "HOME");
    TextButton quit = new TextButton(int(width*0.9375), int(height*0.95), font_size, int(width*0.1), int(height*0.06), "QUIT");
    TextButton start = new TextButton(int(width*0.9375), int(height*0.8), font_size, int(width*0.1), int(height*0.06), "START");
    TextButton music = new TextButton(int(width*0.9375), int(height*0.75), int(font_size*0.6), int(width*0.1), int(height*0.03), "Music");
    addTextButton(home);
    addTextButton(quit);
    addTextButton(start);
    addTextButton(music);

    addSidebarTowers();
  }

  ArrayList<Tower> getuiTowers() {
    return uiTowers;
  }
  ArrayList<Tower> getLiveTowers() {
    return liveTowers;
  }

  void addCharacter(Tower t) { 
    uiTowers.add(t);
  }
  void addLiveTower(Tower t) { 
    for (int i = 0; i< obstacles.obstacles.size(); i++) {
      Obstacle temp = obstacles.obstacles.get(i);
      if (PVector.dist(t.position, temp.position) < temp.r/2) {
        t.position = temp.position;
      }
    }
    liveTowers.add(t);
  }

  void displaySellOptions() {
    if (liveTowerSelected && !sellButtonActive) {
      sellButtonActive = true;
      TextButton sell = new TextButton(int(width*0.305), int(height*0.88), int(font_size*0.6), int(width*0.08), int(height*0.04), "SELL");
      TextButton cancel = new TextButton(int(width*0.395), int(height*0.88), int(font_size*0.6), int(width*0.08), int(height*0.04), "CANCEL");
      addTextButton(sell); addTextButton(cancel);
    } else if (towerSelected) {
      TextButton cancel = new TextButton(int(width*0.395), int(height*0.88), int(font_size*0.6), int(width*0.08), int(height*0.04), "CANCEL");
      addTextButton(cancel);
    }
    else if (!liveTowerSelected) { //!liveTowerSelected) {
      removeTextButton("SELL");
      removeTextButton("CANCEL");
      sellButtonActive = false;
    }
  }

  // Creates TowerArrayList of all UI Towers on Sidebar
  void addSidebarTowers() {
    MeiTower mei = new MeiTower(width*0.91, height*0.20);
    addCharacter(mei);
    MercyTower mercy = new MercyTower(width*0.91, height*0.35); 
    addCharacter(mercy);
    WidowmakerTower widowmaker = new WidowmakerTower(width*0.91, height*0.50);
    addCharacter(widowmaker);
    JunkratTower junkrat = new JunkratTower(width*0.96, height*0.275);
    addCharacter(junkrat);
    WinstonTower winston = new WinstonTower(width*0.96, height*0.425);
    addCharacter(winston);
    GenjiTower genji = new GenjiTower(width*0.96, height*0.575);
    addCharacter(genji);
  }

  void displaySidebarTowers() {
    for (int i = 0; i < uiTowers.size(); i++) {
      uiTowers.get(i).display();
    }
  }

  void displayUI() {
    gameMenu.display();
    displaySidebarTowers();
    displaySellOptions();
    goldCounter();
    lifeLine();
    currentRound();

    //draw map
    obstacles.drawObstacles();
    //prm.drawPoints();
    //prm.drawPath();

     ps.run(); //display particle abilities
    // Display In-Game Towers
    for (int i = 0; i < gameMenu.getLiveTowers().size(); i++) {
      Tower t = gameMenu.getLiveTowers().get(i);
      t.display();
      t.addProjectiles();
    } 

    // If tower selected (for buying), tower will hover over mouse position.
    if (towerSelected) {
      activeTower.updateMousePosition();
      activeTower.display();
      activeTower.displayTowerInfo();
    } else if (liveTowerSelected) {
      activeTower.displayTowerInfo();
    }

    // Display ToolTip for In-Game Towers
    else { //tower not selected
      for (int i = 0; i < gameMenu.getLiveTowers().size(); i++) {
        gameMenu.getLiveTowers().get(i).displayTowerInfo();
      }
      for (int j = 0; j < gameMenu.getuiTowers().size(); j++) {
        gameMenu.getuiTowers().get(j).displayToolTip();
      }
    }
    // Display Tower Descripton Box
    fill(100);
    rect(width*0.45, height*0.86, width*0.415, height*0.13);
  }
}