class Window {
  PVector dimensions;
  PVector location;
  ArrayList<TextButton> buttons;
  boolean open; //whether window is open
  
  Window(PVector dim, PVector loc) {
    dimensions = dim;
    location = loc;
    buttons = new ArrayList<TextButton>();

    open = false;
  }
  void display() {
    if (open) {
      pushMatrix();
      translate(-dimensions.x/2, -dimensions.y/2);
      stroke(255,120,0,240); strokeWeight(8);
      fill(150,150,150,100);
      rect(location.x, location.y, dimensions.x,dimensions.y);
      popMatrix();
      for (int i = 0; i < buttons.size(); i++) {
        buttons.get(i).display();
      }
    }
  }
  boolean ifOpen() { return open;}
  
  void switchOpen() {open = !open;}
  
  ArrayList<TextButton> getButtons() { return buttons;}
  
  void addButton(TextButton b) {
    buttons.add(b);
  }
}