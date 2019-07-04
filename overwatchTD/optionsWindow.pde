class OptionsMenu extends Window {

  OptionsMenu() {
    super(new PVector(width*0.70, height*0.70), //dimensions
      new PVector(width/2, height/2));     //
    difficulty = 1;
    TextButton exit = new TextButton(int(location.x+(0.835*dimensions.x)/2), //location
      int(location.y+(0.825)*dimensions.y/2), 
      int(height*0.045), int(width*0.1), int(height*0.09), "BACK"); //font size, box width/height
    buttons.add(exit);
    TextButton easy = new TextButton(int(location.x-(0.15*dimensions.x)/2), int(location.y-(0.620*dimensions.y)/2), int(height*0.04), int(width*0.1), int(height*0.069), "EASY");
    TextButton normal = new TextButton(int(location.x+(0.20*dimensions.x)/2), int(location.y-(0.620*dimensions.y)/2), int(height*0.04), int(width*0.1), int(height*0.069), "NORMAL");
    TextButton hard = new TextButton(int(location.x+(0.55*dimensions.x)/2), int(location.y-(0.620*dimensions.y)/2), int(height*0.04), int(width*0.1), int(height*0.069), "HARD");
    TextButton musicOn = new TextButton(int(location.x+(0.005*dimensions.x)/2), int(location.y-(0.40*dimensions.y)/2), int(height*0.04), int(width*0.1), int(height*0.069), "ON");
    TextButton musicOff = new TextButton(int(location.x+(0.355*dimensions.x)/2), int(location.y-(0.40*dimensions.y)/2), int(height*0.04), int(width*0.1), int(height*0.069), "OFF");
    TextButton lowVol = new TextButton(int(location.x-(0.15*dimensions.x)/2), int(location.y-(0.18*dimensions.y)/2), int(height*0.04), int(width*0.1), int(height*0.069), "LOW");
    TextButton medVol = new TextButton(int(location.x+(0.20*dimensions.x)/2), int(location.y-(0.18*dimensions.y)/2), int(height*0.04), int(width*0.1), int(height*0.069), "MEDIUM");
    TextButton highVol = new TextButton(int(location.x+(0.55*dimensions.x)/2), int(location.y-(0.18*dimensions.y)/2), int(height*0.04), int(width*0.1), int(height*0.069), "HIGH");

    buttons.add(easy);
    buttons.add(normal);
    buttons.add(hard);
    buttons.add(musicOn);
    buttons.add(musicOff);
    buttons.add(lowVol);
    buttons.add(medVol);
    buttons.add(highVol);
  }

  float getDifficulty() {
    return difficulty;
  }

  // Circles Current Selections in Option Menu
  void displayCurrentSelection() {
    noFill();
    stroke(255); 
    strokeWeight(5);

    if (difficulty >= 1.25) {
      //EASY
      ellipse(int(location.x-(0.15*dimensions.x)/2), int(location.y-(0.620*dimensions.y)/2), 150, 50);
    } else if (difficulty <= 0.75) {
      //HARD
      ellipse(int(location.x+(0.55*dimensions.x)/2), int(location.y-(0.620*dimensions.y)/2), 150, 50);
    } else {
      //MEDIUM
      ellipse(int(location.x+(0.20*dimensions.x)/2), int(location.y-(0.620*dimensions.y)/2), 150, 50);
    }

    if (musicMode) {
      ellipse(int(location.x+(0.005*dimensions.x)/2), int(location.y-(0.40*dimensions.y)/2), 150, 50);
    } else if (!musicMode) {
      ellipse(int(location.x+(0.355*dimensions.x)/2), int(location.y-(0.40*dimensions.y)/2), 150, 50);
    }
    if (volume <0.35) { //LOW
      ellipse(int(location.x-(0.15*dimensions.x)/2), int(location.y-(0.18*dimensions.y)/2), 150, 50);
    } else if ( volume > 0.99) {  // MEDIUM
      ellipse(int(location.x+(0.55*dimensions.x)/2), int(location.y-(0.18*dimensions.y)/2), 150, 50);
    } else {  //HIGH
      ellipse(int(location.x+(0.20*dimensions.x)/2), int(location.y-(0.18*dimensions.y)/2), 150, 50);
    }
  }

  void displayUI() {
    //Create Window
    display(); 
    displayHeadings();
    //Button Display
    for (int k = 0; k < buttons.size(); k++) {
      buttons.get(k).display();
    }
    displayCurrentSelection();
  }
  void displayHeadings() {
    fill(50, 50, 50, 200);
    noStroke();
    //Box Around Buttons
    rect(location.x-(0.95*dimensions.x)/2, location.y-(0.7*dimensions.y)/2, dimensions.x*0.945, height*0.07);
    rect(location.x-(0.95*dimensions.x)/2, location.y-(0.48*dimensions.y)/2, dimensions.x*0.945, height*0.07);
    rect(location.x-(0.95*dimensions.x)/2, location.y-(0.26*dimensions.y)/2, dimensions.x*0.945, height*0.07);
    fill(255);
    textFont(font, height*0.075);
    text("OPTIONS", int(location.x-(0.95*dimensions.x)/2), int(location.y-(0.78*dimensions.y)/2)); //Title  
    textFont(font, height*0.055);
    text("DIFFICULTY", int(location.x -(0.90*dimensions.x)/2), int(location.y-(0.55*dimensions.y)/2)); //Volume
    text("MUSIC", int(location.x-(0.90*dimensions.x)/2), int(location.y-(0.31*dimensions.y)/2)); //Music
    text("VOLUME", int(location.x-(0.90*dimensions.x)/2), int(location.y-(0.07*dimensions.y)/2)); //Difficulty
  }
}