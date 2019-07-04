class TextButton {
  PVector position;
  int size; //font size
  int widthB, heightB; //widthB = width of text box
                      // heightB = height of text box
  int bufferH = 5; //const variable to fix height of box
  String str;
  
  TextButton(int xt, int yt, int sz, int w, int h, String s) {
    position = new PVector(xt, yt);
    size = sz;
    widthB = w;
    heightB = h;
    str = s;
  }
  
  boolean overBox() {
    if ((mouseX > position.x-widthB/2) && (mouseY >position.y-heightB/2+bufferH) &&
       (mouseX < position.x+widthB/2) && (mouseY <position.y+heightB/2+bufferH)) {
         return true;
       }
    else {
      return false;
    }
  }
  
  void display() {
    textFont(font, size);
    fill(100,100,100,200);
    if (overBox()) {
         stroke(255,128,0,140);
         strokeWeight(7);
    }
    else {
      noStroke();
    }
    rect(position.x-widthB/2,position.y-heightB/2+bufferH,
        widthB,heightB);
    fill(255);
    text(str,position.x-textWidth(str)/2,position.y+size/2);
  } 
  
  String getString() { return str;}
}