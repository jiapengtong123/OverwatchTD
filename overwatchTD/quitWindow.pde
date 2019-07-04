class QuitWindow extends Window {
  
  QuitWindow() {
    super(new PVector(width*0.40,height*0.40), //dimensions
          new PVector(width/2, height/2)); 
    // Are you sure you want to quit?
    TextButton yes = new TextButton(int(location.x-(0.45*dimensions.x)/2),int(location.y+(0.25*dimensions.y)/2),int(height*0.075), int(width*0.125), int(height*0.085),"YES");;
    TextButton no = new TextButton(int(location.x+(0.45*dimensions.x)/2),int(location.y+(0.25*dimensions.y)/2),int(height*0.075), int(width*0.125), int(height*0.085),"NO");;
    buttons.add(yes); buttons.add(no);
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
    textFont(font,height*0.08);
    text("ARE YOU SURE?", int(location.x-(dimensions.x*0.85)/2),int(location.y-(0.45*dimensions.y)/2)); //Title  
  }
  
}