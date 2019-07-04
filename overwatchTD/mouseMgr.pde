void mousePressed() {
  // MAIN MENU
  if (currentMenu == 0) {
    ArrayList<TextButton> buttons = mainMenu.getButtons();
    for (int i = 0; i<buttons.size(); i++) {
      TextButton b = buttons.get(i);
      if ((b.getString() == "PLAY") && (b.overBox())) {
        currentMenu = 1;

      }
      else if ((b.getString() == "QUIT") && (b.overBox())) {
        quit.switchOpen();
        currentMenu = 3;
      }
      else if ((b.getString()  == "OPTIONS") && (b.overBox())) {
        //switch from false to true if window is not open
        options.switchOpen();
        currentMenu = 2;
      }
    }
  }
  // GAME MODE
  else if (currentMenu == 1) {
   ArrayList<TextButton> buttons = gameMenu.getButtons();
   for(int i = 0; i < buttons.size(); i++) {
     TextButton b = buttons.get(i);
     if ((b.getString() == "HOME") && (b.overBox())) {
       currentMenu = 5;

       restart.switchOpen();
     }
     else if ((b.getString() == "QUIT") && (b.overBox())) {
       currentMenu = 4;
       quit.switchOpen();
     }
     else if ((b.getString() == "START") && (b.overBox())) {
       roundStart = true;
       println("Round has begun!");
     }
     else if ((b.getString() == "Music") && (musicMode == true) && (b.overBox())) {
       println("Music turned off");
       musicMode = false;
     }
     else if ((b.getString() == "Music") && (musicMode == false) && (b.overBox())) {
       println("Music turned on");
       musicMode = true;
     }
     else if ((b.getString() == "SELL") && (liveTowerSelected) && (b.overBox())) {
       goldCount += activeTower.getCost(); //Sold for full value of tower for now.
       gameMenu.getLiveTowers().remove(activeTower);
       liveTowerSelected = false;
       activeTower = null;
     }
     else if ((b.getString() == "CANCEL") && (towerSelected) && (b.overBox())) {
       towerSelected = false;
       activeTower = null;
     }
   }
   // Handles Buying Towers
   if (towerSelected == true) {
     if (goldCount < activeTower.getCost()) {
       println("Not Enough Gold!");
     } 
     else if (!activeTower.validPosition()) {
       println("Invalid Position");
     }
     else{
       goldCount -= activeTower.getCost();
       gameMenu.addLiveTower(activeTower);
       towerSelected = false;
       activeTower = null;
     }
   }
   // Handles Hovering Tower over mouse if Tower selected
   for (int j = 0; j < gameMenu.getuiTowers().size(); j++) {
     if ((gameMenu.getuiTowers().get(j).mouseHover()) && (!towerSelected)) {
      towerSelected = true;
      liveTowerSelected = false; //prevents both being selected;
      activeTower = new Tower(gameMenu.getuiTowers().get(j));
      println(activeTower);
      break;
     }
   }
   //Displays UI for Active Tower
   for (int k = 0; k < gameMenu.getLiveTowers().size(); k++) {
     // No Live Tower Selected
     if ((gameMenu.getLiveTowers().get(k).mouseHover())) {
       liveTowerSelected = true;
       towerSelected = false; //prevents both being selected;
       activeTower = gameMenu.getLiveTowers().get(k);
       break;
     }
     // If Not Hovering over live tower and no liveTower Selected
     else if ((!gameMenu.getLiveTowers().get(k).mouseHover()) && (liveTowerSelected)) {
       liveTowerSelected = false;
       activeTower = null;
     }
   }
  }
  //OPTIONS MENU
  else if (currentMenu == 2) {
    for (int k = 0; k < options.getButtons().size(); k++) {
      TextButton temp = options.getButtons().get(k);
      if ((temp.getString() == "BACK") && temp.overBox()) {
        currentMenu = 0; //Main Menu
        options.switchOpen();
        break;
      } 
      if ((temp.getString() == "EASY") && temp.overBox()) {
         difficulty = 1.25;
      } else if ((temp.getString() == "NORMAL") && temp.overBox()) {
         difficulty = 1;
      } else if ((temp.getString() == "HARD") && temp.overBox()) {
         difficulty = 0.75;
      }
      if ((temp.getString() == "ON") && temp.overBox()) {
        musicMode = true;
      } else if ((temp.getString() == "OFF") && temp.overBox()) {
        musicMode = false;
      }
      if ((temp.getString() == "LOW") && temp.overBox()) {
        volume = 0.33;
      } else if ((temp.getString() == "MEDIUM") && temp.overBox()) {
        volume = 0.66;
      } else if ((temp.getString() == "HIGH") && temp.overBox()) {
        volume = 1.0;
      }
    }
  }
  //QUIT WINDOW
  else if ((currentMenu == 3) || (currentMenu == 4)){
    for (int k = 0; k < quit.getButtons().size(); k++) {
      TextButton b = quit.getButtons().get(k);
      if ((b.getString() == "YES") && (b.overBox())) {
        exit();
      }
      else if ((b.getString() == "NO") && (b.overBox()) && (currentMenu == 3)) {
        quit.switchOpen();
        currentMenu = 0;
      }
      else if ((b.getString() == "NO") && (b.overBox()) && (currentMenu == 4)) {
        quit.switchOpen();
        currentMenu = 1;
      }
    }
  }
  else if (currentMenu == 5) {
    for (int k = 0; k < restart.getButtons().size(); k++) {
      TextButton b = restart.getButtons().get(k);
      if ((b.getString() == "Yes") && (b.overBox())) {
        restart.switchOpen();
        currentMenu = 0;
        restart.restartGame();
      }
      else if ((b.getString() == "No") && (b.overBox())) {
        restart.switchOpen();
        currentMenu = 1;
      }
    }
  }
}