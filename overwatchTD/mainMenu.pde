class MainMenu extends Menu {
  
  MainMenu(){
    super("main_menu_2.png");
    
    TextButton b1 = new TextButton(width/2, height/2+50,font_size,300,60, "PLAY");
    TextButton b2 = new TextButton(width/2, height/2+115,font_size,300,60, "OPTIONS");
    TextButton b3 = new TextButton(width/2, height/2+180,font_size,300,60,"QUIT");
    addTextButton(b1); addTextButton(b2); addTextButton(b3);
  }
  
  
}