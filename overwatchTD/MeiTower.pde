class MeiTower extends Tower {

  MeiTower(float x1, float y1) {
    super(x1, y1, width*0.15, "Mei", 250, 1.0, 20);
    closeRadius = 0.8*attackRadius;
  }
  MeiTower(Tower t) {
    super(t.position.x, t.position.y, width*0.10, "Mei", 100, 0.60, 20);
    system = t.system;
    mercyBuff = t.mercyBuff;
    closeRadius = t.closeRadius;
  }


  void displayBasic() {
    // Display Projectiles
    for (int j = 0; j < system.size(); j++) {
      stroke(200);
      strokeWeight(1);
      fill(255); 
      ellipse(system.get(j).position.x, system.get(j).position.y, width*0.025, width*0.025);
    }
    // Add Basic Slowing Velocity to Agents
  }
  // Area slow
  void agentSlow() {
    //
    stroke(255, 255, 0);
    for (int i = 0; i < agentSyst.getAgents().size(); i++) {
      Agent temp = agentSyst.getAgents().get(i);
      // If Agents within closeAttack radius, perform aoe slow
      if (PVector.dist(temp.getPosition(), position) <= closeRadius) {
        temp.meiDebuff = true;
        // display color change in Agent class
      } else {
        temp.meiDebuff  = false;
      }
    }
  }
}