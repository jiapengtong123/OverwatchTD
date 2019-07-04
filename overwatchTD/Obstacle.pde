class Obstacle {

  PVector position;

  float r = 0;

  Obstacle(float x, float y, float r) {

    position = new PVector(x, y);

    this.r = r;
  }
}

class Obstacles {

  ArrayList<Obstacle> obstacles; 

  int n=1;

  Obstacles() {

    obstacles = new  ArrayList<Obstacle>();
  }


  void add( Obstacle obstacle) {

    obstacles.add(obstacle);
  }


  void drawObstacles() {

    PImage img = loadImage("4.jpg");

    for (int i=0; i<obstacles.size(); i++) {

      pushMatrix();
      noStroke();
      beginShape();
      texture(img);
      float r = obstacles.get(i).r;
      vertex(obstacles.get(i).position.x - r/2,  obstacles.get(i).position.y - obstacles.get(i).r/2, 0, 0);
      vertex(obstacles.get(i).position.x + r/2,  obstacles.get(i).position.y - obstacles.get(i).r/2, r, 0);
      vertex(obstacles.get(i).position.x + r/2,  obstacles.get(i).position.y + obstacles.get(i).r/2, r, r);
      vertex(obstacles.get(i).position.x - r/2,  obstacles.get(i).position.y + obstacles.get(i).r/2, 0, r);
      endShape();


      //rect(obstacles.get(i).position.x - obstacles.get(i).r/2, 
      //  obstacles.get(i).position.y - obstacles.get(i).r/2, 
      //  obstacles.get(i).r, obstacles.get(i).r);
      
      //ellipse(obstacles.get(i).position.x, obstacles.get(i).position.y,
      //obstacles.get(i).r,obstacles.get(i).r);
      popMatrix();
    }
  }
}