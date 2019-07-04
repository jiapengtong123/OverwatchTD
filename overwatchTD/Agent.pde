class Agent {
  PVector position;
  boolean isAlive;
  float init_health;
  float current_health;
  boolean meiDebuff;

  //add
  PVector velocity;
  PVector acceleration;
  float r;
  float maxForce;    
  float maxSpeed;    
  int direction = 0;
  ArrayList<PVector> path;

  Agent(PVector p) {
    position = p;
    isAlive = true;
    meiDebuff = false;
    init_health = 100;
    current_health = 100;

    //add
    float angle = 0;

    velocity = new PVector(cos(angle), sin(angle));
    //easy
    if (difficulty >= 1.25) {
      maxSpeed = 1;
      //hard
    } else if (difficulty <= 0.75) {
      maxSpeed = 2;
      //velocity.mult(1.1);  //hard
    } else { ///normal
      maxSpeed = 1.5;
    }
    acceleration = new PVector(0, 0);

    r = 30.0;

    maxForce = 0.03;

    path = new ArrayList<PVector>();
    isAlive= true;
  }
  PVector getPosition() {
    return position;
  }

  void Display() {
    //println(meiDebuff);

    pushMatrix();
    if (meiDebuff) {
      fill(100, 149, 237);
    } else {
      color to = color(0, 255, 0);
      color from = color(255, 0, 0);
      color interA = lerpColor(from, to, current_health/init_health);
      fill(interA);
    }
    translate(position.x, position.y);
    Bastion();
    popMatrix();
  }

  void Bastion() {

    //scale(1.5);
    float x = 0;
    float y = 0;
    float size = r/2;
    strokeWeight(1);
    //body
    rect(x-size/2, y-size/2, size, size);
    rect(x-size/2*3/5, y+size/2, 0.6*size, size/4);
    rect(x-size/2*2/5, y+size/2+size/4, 0.4*size, size/4*3/4);
    rect(x-size/2, y+size/2+size/4+3*size/16, size, size/4);
    if (frameCount/5/velocity.mag()%2 == 0) {
      //foot
      rect(x-size/2, y+size/2+size/4+3*size/16+size/6, size/5, size/3);
      rect(x-size/2-size/10, y+size/2+size/4+3*size/16+size/4+size/6, size*3/7, 1);

      rect(x+size/2 -size/5, y+size/2+size/4+3*size/16+size/4, size/5, size/3);
      rect(x+size/2 -size/5-size/10, y+size/2+size/4+3*size/16+size/4+size/3, size*3/7, 1);
    } else {
      //foot
      rect(x-size/2, y+size/2+size/4+3*size/16+size/4, size/5, size/3);
      rect(x-size/2-size/10, y+size/2+size/4+3*size/16+size/4+size/3, size*3/7, 1);

      rect(x+size/2 -size/5, y+size/2+size/4+3*size/16+size/6, size/5, size/3);
      rect(x+size/2 -size/5-size/10, y+size/2+size/4+3*size/16+size/4+size/6, size*3/7, 1);
    }
    //head 
    rect(x-size/2, y-size/2-size/2, size/10, size/2);
    rect(x-size/4, y-size/2-size/3, size*3/7, size/2);
    rect(x-size/10, y-size/2-size/3, size/5, size/2);
    //arms
    rect(x+size/2, y-size/2, size/3, size);
    rect(x+size/2, y+size/2, size/3, size/4);
    rect(x-size/2-size/3, y-size/2, size/3, size);
    rect(x-size/2-size/3, y+size/2, size/3, size/4);
  }

  boolean isAlive() {
    return isAlive;
  }

  //add
  void display(ArrayList<Agent> boids, Obstacles obstacles) {

    group(boids, obstacles);
    update();
    border();
    outLooking();
  }

  void addForce(PVector force) {
    acceleration.add(force);
  }

  void group(ArrayList<Agent> boids, Obstacles obstacles) {
    PVector sep = separate(boids);   
    PVector ali = align(boids);      
    PVector coh = cohesion(boids);
    PVector collision = detectObstacle(obstacles);
    PVector target = followPath();


    sep.mult(5.0);
    ali.mult(1.0);
    coh.mult(1.0);
    collision.mult(5.0);
    target.mult(3.0);


    addForce(sep);
    addForce(ali);
    addForce(coh);
    addForce(collision);
    addForce(target);
  }

  void update() {

    velocity.add(acceleration);

    velocity.limit(maxSpeed);
    if (meiDebuff) {

      position.add(PVector.mult(velocity, 0.75));
    } else {
      position.add(velocity);
    }

    acceleration.mult(0);
  }

  PVector followPath() {

    PVector target = new PVector();

    target = path.get(direction);

    //println("direction "+ direction + " target "+ target.x  +" "+ target.y);

    if (PVector.dist(position, target) <= 20) {

      direction--;

      if (direction >= 0) {

        target = path.get(direction);
      } else {

        //agents finish the path 
        isAlive = false;

        lifeCount--;
      }
    }


    PVector result = PVector.sub(target, position);

    result.normalize();

    result.mult(velocity.mag());

    result.limit(maxForce);


    return result;
  }

  PVector detectObstacle(Obstacles obstacles) {

    int num=0;

    PVector pushForce = new PVector(0, 0);

    for (int i=0; i<obstacles.obstacles.size(); i++) {

      float distance = PVector.dist(position, obstacles.obstacles.get(i).position);

      float minDistance = obstacles.obstacles.get(i).r *sqrt(2)/2 + 5;

      if (distance > 0 && distance < minDistance) {

        PVector dis = PVector.sub(position, obstacles.obstacles.get(i).position);

        dis.normalize();
        dis.div(distance);      
        pushForce.add(dis);
        num++;
      }
    }

    if (num > 0) {
      pushForce.div(num);
    }

    if (pushForce.mag() > 0) {
      pushForce.normalize();

      pushForce.mult(velocity.mag());

      pushForce.limit(maxForce);
    }


    return pushForce;
  }


  PVector findNeighbor(PVector target) {
    PVector direction = PVector.sub(target, position);  

    direction.normalize();
    direction.mult(velocity.mag());

    direction.limit(maxForce);  
    return direction;
  }
  void outLooking() {

    if (isAlive) {

      fill(255, 255, 255);
      stroke(192, 192, 192);

      Display();
    }
  }

  void border() {


    if (position.x < -r) velocity.mult(-1);//position.x = 0.88 * width+r;
    if (position.y < -r) velocity.mult(-1);//position.y = 0.8 * height+r;
    if (position.x > 0.88 * width+r) velocity.mult(-1); //position.x = -r;
    if (position.y > 0.8 * height+r) velocity.mult(-1);//position.y = -r;
  }

  PVector separate (ArrayList<Agent> boids) {

    float minDistance = 25.0;
    PVector pullForce = new PVector(0, 0, 0);
    int num = 0;

    for (int i=0; i<boids.size(); i++) {

      float distance = PVector.dist(position, boids.get(i).position);

      if (distance > 0 && distance < minDistance) {

        PVector dis = PVector.sub(position, boids.get(i).position);

        dis.normalize();
        dis.div(distance);        
        pullForce.add(dis);
        num++;
      }
    }

    if (num > 0) {
      pullForce.div(num);
    }

    if (pullForce.mag() > 0) {
      pullForce.normalize();
      pullForce.mult(maxSpeed);
      pullForce.sub(velocity);
      pullForce.limit(maxForce);
    }
    return pullForce;
  }


  PVector align (ArrayList<Agent> boids) {

    float maxNeighbor = 40;
    PVector average = new PVector(0, 0);
    int num = 0;
    for (int i =0; i< boids.size(); i++) {

      float distance = PVector.dist(position, boids.get(i).position);
      if (distance > 0 && distance < maxNeighbor) {
        average.add( boids.get(i).velocity);
        num++;
      }
    }

    if (num > 0) {
      average.div(num);
      average.normalize();
      average.mult(maxSpeed);

      PVector pullForce = PVector.sub(average, velocity);
      pullForce.limit(maxForce);
      return pullForce;
    } else {
      return new PVector(0, 0);
    }
  }


  PVector cohesion (ArrayList<Agent> boids) {

    float maxNeighbor = 40;
    PVector average = new PVector(0, 0);   
    int num = 0;

    for (int i=0; i< boids.size(); i++) {

      float distance = PVector.dist(position, boids.get(i).position);
      if (distance > 0 && distance < maxNeighbor) {
        average.add(boids.get(i).position); 
        num++;
      }
    }

    if (num > 0) {
      average.div(num);
      return findNeighbor(average);
    } else {
      return new PVector(0, 0);
    }
  }

  void addPath(ArrayList<PVector> finalpath) {

    for (int i =0; i<finalpath.size(); i++) {

      path.add(new PVector(finalpath.get(i).x, finalpath.get(i).y));
    }

    direction = path.size()-1;
  }
}

class AgentSystem {
  ArrayList<Agent> agents;
  boolean isAlive;
  Obstacles obstacles;

  AgentSystem() {
    agents = new ArrayList<Agent>();
    obstacles= new Obstacles();
    isAlive = true;
  }

  ArrayList<Agent> getAgents() { 
    return agents;
  }

  void addAgent(Agent a) { 
    agents.add(a);
  }

  void addObsatcles(Obstacles obstacles) {

    this.obstacles = obstacles;
  }


  void displayAgentSystem() {
    if (roundStart) {
      for (int i = agents.size()-1; i>=0; i--) {
        Agent p = agents.get(i);

        agents.get(i).display(agents, obstacles);
        if ( agents.get(i).current_health <= 0) {
          goldCount+=10;
          p.isAlive = false;
        }
        if (!p.isAlive()) {
          agents.remove(p);
        }
      }
    }
  }
}