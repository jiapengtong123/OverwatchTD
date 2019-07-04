// Projectile and ProjectileSystem classes //<>//
class Projectile {
  PVector velocity; //direction of projectile
  PVector position;
  PVector source; //if projectile is outside or origin tower's attack radius, it will die off
  boolean alive;
  float leashRadius; //used to check if projectile is outside of attack radius of tower
  float damage;

  Projectile(PVector pos, PVector vel, float atkRadius, float dmg) { //init position will always be at center of tower
    source = pos.copy();
    position = pos.copy();
    velocity = vel;
    alive = true;
    leashRadius = atkRadius;
    damage = dmg;
  }
  //Copy Constructor
  Projectile(Projectile p) {
    this(p.velocity, p.position, p.leashRadius, p.damage);
  }
  boolean isAlive() { 
    return alive;
  }  
  PVector getPosition() {
    return position;
  }

  void ifOutsideLeashRadius() {
    if (PVector.dist(position, source) > leashRadius) {
      alive = false;
    }
  }
  void update() { 
    position.add(velocity);
    ifOutsideLeashRadius();
    for (int i=0; i< agentSyst.getAgents().size(); i++) {
      Agent a = agentSyst.getAgents().get(i);
      if (PVector.dist(position, a.position) <= a.r) {
        agentSyst.getAgents().get(i).current_health -= damage;
        alive = false;
      }
    }
  }
}

class ProjectileSystem {
  ArrayList<Projectile> projectiles;

  ProjectileSystem() {
    projectiles = new ArrayList<Projectile>();
  }

  // See addProjectiles() in Tower class to see projectiles added;
  void addProjectile(Projectile p) { 
    projectiles.add(p);
  }

  void displayProjectileSystem() {

    for (int k = 0; k < gameMenu.getLiveTowers().size(); k++) {
      Tower temp = gameMenu.getLiveTowers().get(k);

      if (temp.getName() == "Genji") {
        GenjiTower temp2 = new GenjiTower(temp);
        for (int n = 0; n <temp2.system.size(); n++) {
          temp2.system.get(n).update();
          if (!temp2.system.get(n).isAlive()) {
            temp2.system.remove(n);
          }
        }
        temp2.displayBasic();
        temp2.sword();
      }
      if (temp.getName() == "Mercy") {
        MercyTower temp2 = new MercyTower(temp);
        for (int n = 0; n <temp2.system.size(); n++) {
          temp2.system.get(n).update();

          if (!temp2.system.get(n).isAlive()) {
            temp2.system.remove(n);
          }
        }
        temp2.displayBasic();
        temp2.attackSpeedBuff();
      }
      if (temp.getName() == "Mei") {
        MeiTower temp2 = new MeiTower(temp);
        for (int n = 0; n <temp2.system.size(); n++) {
          temp2.system.get(n).update();

          if (!temp2.system.get(n).isAlive()) {
            temp2.system.remove(n);
          }
        }
        temp2.displayBasic();
        temp2.agentSlow();
      }
      if (temp.getName() == "Widowmaker") {
        WidowmakerTower temp2 = new WidowmakerTower(temp);
        for (int n = 0; n <temp2.system.size(); n++) {
          temp2.system.get(n).update();

          if (!temp2.system.get(n).isAlive()) {
            temp2.system.remove(n);
          }
        }
        temp2.displayBasic();
        temp2.displayMine();
      }
      if (temp.getName() == "Junkrat") {
        JunkratTower temp2 = new JunkratTower(temp);
        for (int n = 0; n <temp2.system.size(); n++) {
          temp2.system.get(n).update();

          if (!temp2.system.get(n).isAlive()) {
            temp2.system.remove(n);
          }
        }
        temp2.displayBasic();
      }
      if (temp.getName() == "Winston") {
        WinstonTower temp2 = new WinstonTower(temp);
        for (int n = 0; n <temp2.system.size(); n++) {
          temp2.system.get(n).update();

          if (!temp2.system.get(n).isAlive()) {
            temp2.system.remove(n);
          }
        }
        temp2.displayBasic();
      }
    }
  }
}