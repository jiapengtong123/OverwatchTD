class Tower {
  PVector position;
  float diameterV;  //visual diameter of tower 
  float attackRadius; //attack range radius of tower
  float health;
  float damage;
  float closeRadius; // for special attacks
  PImage img;
  String towerName; //used to find image files;
  int cost;

  int timer; // used to handle attack speed of a tower;
  float attackSpeed;
  ArrayList<Projectile> system;
  boolean mercyBuff;


  Tower(float xp, float yp, float rA, String name, int c, float atkSpeed, float dmg) {
    position = new PVector(xp, yp);
    diameterV = 65;
    attackRadius = rA;
    health = 100;
    img = loadImage(name+"_tower.PNG");
    towerName = name;
    cost = c;
    attackSpeed = atkSpeed;
    system = new ArrayList<Projectile>();
    closeRadius = attackRadius/2;
    mercyBuff = false;
    damage = dmg;
  }
  //Copy Constructor
  Tower(Tower t) {
    this(t.position.x, t.position.y, t.attackRadius, t.towerName, t.cost, t.attackSpeed, t.damage);
  }

  int getCost() { 
    return cost;
  }

  PVector getPosition() { 
    return position;
  }
  String getName() { 
    return towerName;
  }

  // adds Projectiles to ProjectileSystem
  void addProjectiles() {
    float tempAtkSpeed = attackSpeed;
    //if Mercy Buff Applied, attack speed increased by 25%
    if (mercyBuff) {
      tempAtkSpeed = attackSpeed*0.5;
    }
    if (((millis() - timer) >= 1000*tempAtkSpeed) && roundStart) { 

      for (int i = 0; i < agentSyst.getAgents().size(); i++) {
        Agent a = agentSyst.getAgents().get(i);
        if ((PVector.dist(position, a.getPosition())) <= attackRadius) { 
          //speed of moving projectile
          PVector speed = PVector.sub(a.getPosition(), position).normalize(); //normalized velocity vector;
          // All Basic attacks have default speed of three, widowmaker is 10
          if (towerName == "Widowmaker") {
            speed.mult(30);
          } else {
            speed.mult(4);  //DEFAULT SPEED
          }
          Projectile w = new Projectile(position.copy(), speed, attackRadius, damage);
          system.add(w);
          break;
        }
      }
      timer = millis();
    }
  }

  boolean mouseHover() {
    if (dist(mouseX, mouseY, position.x, position.y) < diameterV/2) {
      return true;
    } else { 
      return false;
    }
  }

  void displayTowerInfo() {
    displayAttackRadius();
    displayToolTip();
    towerDescription();
  }

  void displayAttackRadius() {
    stroke(255, 128, 0, 200);
    strokeWeight(2);
    if ((mouseHover() && validPosition()) || liveTowerSelected) {
      fill(150, 150, 150, 100);
      ellipse(position.x, position.y, attackRadius*2, attackRadius*2);
    }
    // If Invalid Position, display attack radius in red
    else if (mouseHover() && !validPosition()) {
      fill(255, 0, 0, 100);
      ellipse(position.x, position.y, attackRadius*2, attackRadius*2);
    }
  }
  void displayToolTip() {
    if (mouseHover() || liveTowerSelected) {
      // all character portraits will have this file format
      // i.e. "Mercy_chibi.PNG"
      PImage character = loadImage(towerName+"_chibi.PNG"); 
      character.resize(int(width*0.06), int(width*0.072));
      image(character, width*0.0075, height*0.86);

      fill(255);
      float column1 = width*0.085; //shift value for 1st column
      float column2 = width*0.275;
      textFont(font, height*0.045);
      text(towerName, column1, height*0.9);
      textFont(font, height*0.03); 
      text("- Attack Radius: " + round(attackRadius) + "\n- Basic Damage: " + damage, column1, height*0.945);
      text("- Health: " + health+ "\n- Cost: " + cost, column2, height*0.945);
    }
  }
  void towerDescription() {
    textFont(font, height*0.028);
    fill(255); //White Text Color
    if (liveTowerSelected) {
      float width_buf = width*0.4575;
      float height_buf = height*0.89;
      if (towerName == "Genji") { 
        text("Genji flings precise and deadly Shuriken at his targets,\nand delivers a Swift Strike with his technologically-\nadvanced katana that cuts down enemies.",width_buf,height_buf);
      } else if (towerName == "Mercy") {
        text("Mercy is capable of dealing damage, but is best played\nby being placed near friendly heroes and buffing them\nwith a 25% attack speed.",width_buf,height_buf);
      } else if (towerName == "Widowmaker") {
        text("Widowmaker equips herself mines that dispense\npoisonous gas and a visor that grants her pin-point\noneshot accuracy at long range.",width_buf, height_buf); 
      } else if (towerName == "Mei") {
        text("Mei’s weather-altering devices slow agents and grants\nher control of the battlefield.", width_buf, height_buf);
      } else if (towerName == "Winston") {
        text("A super-intelligent, genetically engineered gorilla,\nWinston is a brilliant scientist. And he\nwields an electricity-blasting Tesla Cannon.", width_buf, height_buf);
      } else if (towerName == "Junkrat") {
        text("Junkrat uses his Frag Launcher to bounce grenades at\nhis enemies while planting Concussion Mines to\ndefend himself.", width_buf, height_buf);
      }
    }
  }

  void display() {  //Display Tower
    pushMatrix();
    translate(position.x - diameterV/2, position.y - diameterV/2);
    fill(255);  
    PShape customShape = createShape();
    customShape.beginShape(TRIANGLE_FAN);
    int numSides = 100;
    float theta = TWO_PI / numSides;
    customShape.vertex(diameterV/2, diameterV/2);
    for (int i=0; i<numSides+1; i++) {
      float x = sin(i * theta) * diameterV/2 + diameterV/2;
      float y = cos(i * theta) * diameterV/2 + diameterV/2;
      customShape.vertex(x, y);
    }
    customShape.endShape();
    customShape.setStroke(false);
    customShape.setTexture(img);
    customShape.setTextureMode(NORMAL);
    for (int i = 0; i < customShape.getVertexCount(); i++) {
      PVector v = customShape.getVertex(i);
      customShape.setTextureUV(i, map(v.x, 0, diameterV, 0, 1), map(v.y, 0, diameterV, 0, 1));
    }
    shape(customShape);
    popMatrix();
    // If hovering over sidebar towers
    if (mouseHover() && !towerSelected) {
      stroke(0, 255, 255, 100);
      strokeWeight(4);
      noFill();
      ellipse(position.x, position.y, diameterV, diameterV);
    }
    fill(255);
  }
  void updateMousePosition() {
    position.x = mouseX; 
    position.y = mouseY;
  }

  boolean validPosition() {
    // If not in map area
    if ((position.x > 0.87*width-diameterV/2) || (position.y >0.84*height-diameterV/2) || //bottom, right
      (position.x < diameterV/2) || (position.y < diameterV/2)) {                       //left, top
      return false;
    }
    for (int i = 0; i < gameMenu.getLiveTowers().size(); i++) {
      if (dist(position.x, position.y, gameMenu.getLiveTowers().get(i).getPosition().x, gameMenu.getLiveTowers().get(i).getPosition().y) <= diameterV) {
        return false;
      }
    }
    for (int i =0; i< obstacles.obstacles.size(); i++) {
      float x = obstacles.obstacles.get(i).position.x;
      float y = obstacles.obstacles.get(i).position.y;
      float r = obstacles.obstacles.get(i).r;
      if (position.x>x-r/2 && position.x<x+r/2 && position.y>y-r/2 && position.y<y+r/2) {
        return true;
      }
    }
    return false;
  }
}