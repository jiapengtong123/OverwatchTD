class GenjiTower extends Tower {
  GenjiTower(float x1, float y1) {
    super(x1, y1, width*0.17, "Genji", 250, 1.0, 50);
    closeRadius = 0.5 * attackRadius;
  }
  GenjiTower(Tower t) {
    super(t.position.x, t.position.y, width*0.17, "Genji", 100, 1.0, 50);
    system = t.system;
    mercyBuff = t.mercyBuff;
    closeRadius = t.closeRadius;
  }


  void displayBasic() {
    // Display Projectiles
    for (int j = 0; j < system.size(); j++) {
      pushMatrix();
      stroke(0, 255, 0);
      strokeWeight(1);
      fill(192, 192, 192);
      translate(system.get(j).position.x, system.get(j).position.y);
      rotate(frameCount / 5.0);
      star(0, 0);
      ellipse(0, 0, 6, 6);
      popMatrix();
    }
  }

  void star(float x, float y) {
    float npoints = 4;
    float radius1 = 10;
    float radius2 = 20;
    float angle = TWO_PI / npoints;
    float halfAngle = angle/2.0;
    beginShape();
    for (float a = 0; a < TWO_PI; a += angle) {
      float sx = x + cos(a) * radius2;
      float sy = y + sin(a) * radius2;
      vertex(sx, sy);
      sx = x + cos(a+halfAngle) * radius1;
      sy = y + sin(a+halfAngle) * radius1;
      vertex(sx, sy);
    }
    endShape(CLOSE);
  }


  void sword() {
    for (int j = 0; j < agentSyst.getAgents().size(); j++) {

      Agent temp = agentSyst.getAgents().get(j);
      PVector agentPos = temp.getPosition();
      //println(PVector.dist(agentPos,position));
      //println("Close Radius: " + closeRadius);
      if (PVector.dist(agentPos, position) <= closeRadius) {


        println("Sword called");
        temp.current_health -= 1;
        int l = int(closeRadius);
        int w = 5;
        int n = 0;
        int tw = 10;

        pushMatrix();
        noStroke();

        translate(position.x, position.y);

        float a = frameCount/5;
        rotate(a);

        a=0;

        fill(192, 192, 192);
        rect(0, 0, l, w);
        triangle(l, 0, l+10, 0, l, w);

        rect(0, 0, l/3, w);
        rect(l/3, -w, w, 3*w);
        fill(50, 205, 50);
        n = l*2/3/ tw;
        int x = l/3;
        int y = w;
        for (int k = 0; k<n; k++) {
          triangle(x, y, x+tw/2, w*0.2, x+tw, y);
          x+=tw;
        }

        popMatrix();
      }
    }
  }
}