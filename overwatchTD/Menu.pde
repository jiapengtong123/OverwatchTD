class Menu {
  PImage bgImage;
  ArrayList<TextButton> screenText;

  Menu(String s) {
    screenText = new ArrayList<TextButton>();
    bgImage = loadImage(s);
  }
  void display() {
    bgImage.resize(width,height);
    image(bgImage,0,0);
    for (int i = 0; i < screenText.size(); i++) {
      screenText.get(i).display();
    }
  }
  void addTextButton(TextButton b) {
    screenText.add(b);
  }
  void removeTextButton(String s) {
    for (int i = 0; i < screenText.size(); i++) {
      if (screenText.get(i).getString() == s) {
        screenText.remove(i);
        break;
      }
    }
  }
  ArrayList<TextButton> getButtons() {
    return screenText;        
  }
}
  
  