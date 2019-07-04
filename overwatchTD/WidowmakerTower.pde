class WidowmakerTower extends Tower {
  PImage mine;
  float timer;

  WidowmakerTower(float x1, float y1) {
    super(x1, y1, width*0.25, "Widowmaker", 100, 2.0, 100);
    mine = loadImage("Widowmaker_Mine.png");
    timer = 0;
  }
  WidowmakerTower(Tower t) {
    super(t.position.x, t.position.y, width*0.25, "Widowmaker", 100, 1.75, 100);
    system = t.system;
    mercyBuff = t.mercyBuff;
    mine = loadImage("Widowmaker_Mine.png");
  }

  void displayBasic() {
    // Display Projectiles
    for (int j = 0; j < system.size(); j++) {
      Projectile proj = system.get(j);
      stroke(255);//white
      fill(255); 
      ellipse(proj.position.x, proj.position.y, width*0.005, width*0.005);
    }
  }

  void displayMine() {
    for (int i =0; i<agentSyst.getAgents().size(); i++) {
      Agent temp = agentSyst.getAgents().get(i);

      if (PVector.dist(position, temp.position) <= 200) {
        temp.current_health -= 0.25;
      }
    }
    tint(255, 127);
    image(mine, position.x-mine.width/2, position.y-mine.height/2);
    tint(255, 255);
    if (((millis() - timer) >= 5000) && roundStart) { //5seconds
      ps.addParticles(5, position, color(186, 85, 211), color(0, 255, 0));
      timer = millis();
    }
  }
}