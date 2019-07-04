class MercyTower extends Tower {

  MercyTower(float x1, float y1) {
    super(x1, y1, width*0.14, "Mercy", 250, 1.0, 20);
  }
  MercyTower(Tower t) {
    super(t.position.x, t.position.y, width*0.14, "Mercy", 100, 1.0, 20);
    system = t.system;
    mercyBuff = t.mercyBuff;
  }


  void displayBasic() {
    // Display Projectiles
    for (int j = 0; j < system.size(); j++) {
      stroke(147, 112, 219);//light purple
      strokeWeight(7);
      fill(255); 
      ellipse(system.get(j).position.x, system.get(j).position.y, width*0.015, width*0.015);
    }
    //float rand_int = random(0,255);
    //stroke(255,255,rand_int);
    //strokeWeight(20);

    //for (int j = 0; j < system.size(); j++) {
    //  line(position.x, position.y, system.get(j).getPosition().x,system.get(j).getPosition().y);
    //}
  }

  void attackSpeedBuff() {
    //
    stroke(255, 255, 0);
    strokeWeight(5);
    for (int i = 0; i < gameMenu.getLiveTowers().size(); i++) {
      Tower temp = gameMenu.getLiveTowers().get(i);
      // If Friendly towers within attack radius, get 25% attack speed buff
      if (PVector.dist(temp.getPosition(), position) <= attackRadius) {
        temp.mercyBuff = true;
        pushMatrix();
        translate(diameterV/4, -diameterV/4);
        line(temp.position.x-temp.diameterV/8, temp.position.y, temp.position.x+diameterV/8, temp.position.y);
        line(temp.position.x, temp.position.y-temp.diameterV/8, temp.position.x, temp.position.y+diameterV/8);
        popMatrix();
      }
    }
  }
}