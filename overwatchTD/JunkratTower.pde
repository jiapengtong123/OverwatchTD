class JunkratTower extends Tower {

  JunkratTower(float x1, float y1) {
    super(x1, y1, width*0.15, "Junkrat", 250, 1.0, 50);
    closeRadius = 0.8*attackRadius;
  }
  JunkratTower(Tower t) {
    super(t.position.x, t.position.y, width*0.10, "Junkrat", 100, 0.60, 50);
    system = t.system;
    mercyBuff = t.mercyBuff;
    closeRadius = 0.8*attackRadius;
  }


  void displayBasic() {
    // Display Projectiles
    for (int j = 0; j < system.size(); j++) {
      stroke(200);
      strokeWeight(1);
      fill(222,184,135); 
      ellipse(system.get(j).position.x, system.get(j).position.y, width*0.025, width*0.025);
    }
  }

}