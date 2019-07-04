
class PRM {

  int sampleNum =0;

  int neighborNum = 10;

  ArrayList<PVector> points; 

  ArrayList<Integer> map; 

  LinkedList<Node> path; 

  ArrayList<PVector> finalPath;

  Obstacles obstacles;


  PRM(int sampleNum) {

    this.sampleNum = sampleNum;

    points = new ArrayList<PVector>(); 

    map = new  ArrayList<Integer> ();

    finalPath = new  ArrayList<PVector>();

    path = new LinkedList<Node>();

    obstacles = new Obstacles();

    for (int i =0; i< sampleNum * sampleNum; i++) {

      map.add(0);
    }
  }

  void go() {

    //sample points
    samplePoints();

    //create road map
    connect();

    findPath();

    outputPath();
  }

  void addObstacles(Obstacles obstacles) {

    this.obstacles = obstacles;
  }
  void samplePoints() {
  
      int n =  0;
      while (n<sampleNum) {
  
        float x = random(0, 0.80 * width);
        float y = random(0.1*height, 0.725* height);
        PVector point = new PVector(x, y);
  
        boolean valid = true;
  
        for (int i =0; i< obstacles.obstacles.size(); i++) {
          Obstacle temp= obstacles.obstacles.get(i); 
          if (PVector.dist(point, temp.position) <= temp.r/2 * sqrt(2)) {
            valid = false;
          }
        }
  
        if (valid) {
          points.add(point);
          n++;
        }
  
      }  
  
      points.get(0).x= 0.88 * width / 8;
      points.get(0).y= 0.8 * height / 4;
  
  
      points.get(sampleNum-1).x= 30;
      points.get(sampleNum-1).y= 0.8 * height * 0.8;
      println("Loading PRM Points Complete");
    }
  void drawPoints() {


    strokeWeight(10);
    stroke(255);
    beginShape(POINTS);


    for (int i=0; i<sampleNum; i++) {

      vertex( points.get(i).x, points.get(i).y);
    }

    endShape();
    strokeWeight(1);

    //draw map
    beginShape(LINES);
    for (int i=0; i<sampleNum; i++) {

      for (int j=0; j<sampleNum; j++) {

        if (map.get(i* sampleNum + j)==1) {

          vertex(points.get(i).x, points.get(i).y);

          vertex(points.get(j).x, points.get(j).y);
        }
      }
    }
    endShape();
  }


  boolean collisionTest(PVector x1, PVector x2) {

    PVector v1 = new PVector();
    PVector v2 = new PVector();

    v1 = PVector.sub(x2, x1);

    for (int h=0; h<obstacles.obstacles.size(); h++) {

      v2 = PVector.sub(obstacles.obstacles.get(h).position, x1);

      float d = PVector.dot(v2, v1)/ v1.mag();

      v1.normalize();

      v1.mult(d);

      float dis;

      if ((obstacles.obstacles.get(h).position.x >= x1.x && obstacles.obstacles.get(h).position.x <= x2.x) 
        || (obstacles.obstacles.get(h).position.x >= x2.x && obstacles.obstacles.get(h).position.x <= x1.x)
        || (obstacles.obstacles.get(h).position.y >= x2.y && obstacles.obstacles.get(h).position.y <= x1.y)
        || (obstacles.obstacles.get(h).position.y >= x1.y && obstacles.obstacles.get(h).position.y <= x2.y)) {

        dis = PVector.sub(v2, v1).mag();
      } else {

        float a = PVector.sub(obstacles.obstacles.get(h).position, x1).mag();
        float b = PVector.sub(obstacles.obstacles.get(h).position, x2).mag();

        if (a<= b) {
          dis = a;
        } else {
          dis = b;
        }
      }


      if (dis <= obstacles.obstacles.get(h).r/2 *sqrt(2)) {

        //println(dis);

        //println(obstacles.obstacles.get(h).r);

        return false;
      }
    }


    return true;
  }


  void connect() {

    for (int i=0; i<points.size(); i++) {

      ArrayList<float[]> neighbor = new ArrayList<float[]>(); 

      for (int j=0; j<points.size(); j++) {

        if (collisionTest(points.get(i), points.get(j))) {

          PVector distance = new PVector(points.get(i).x - points.get(j).x, points.get(i).y - points.get(j).y);

          float [] temp = new float[2];
          temp[0] = distance.mag();
          temp[1] = j;

          neighbor.add(temp);
        }
      }

      //bubble sort
      for (int k = 0; k < neighbor.size() - 1; k++)
      {
        for (int j = 0; j < neighbor.size() - k - 1; j++) {

          if (neighbor.get(j)[0]> neighbor.get(j+1)[0])
          {
            float [] temp = new float[2];

            temp = neighbor.get(j);

            neighbor.set(j, neighbor.get(j+1));

            neighbor.set(j+1, temp);
          }
        }
      }

      //change the map
      for (int j =0; j<neighbor.size(); j++) {

        if (j== neighborNum) {

          break;
        }

        if (i!=(int)neighbor.get(j)[1]) {

          map.set(i * sampleNum +(int)neighbor.get(j)[1], 1);
        }
      }
    }
  }

  //use A* to find the path in the road map
  int findPath() {
    println("Finding path......");
    sortedList open = new sortedList();
    LinkedList<Node> close = new LinkedList<Node>();

    Node start = new Node(0, -1);

    open.add(start);

    boolean done =false;

    Node current = new Node();

    while (!done) {

      //get the lowest f cost
      current = open.getLowest();

      close.add(current);

      if (current.index == sampleNum-1) {

        path = close;

        return 1;
      }

      ArrayList<Node> adjacent = new  ArrayList<Node>();

      for (int i =0; i < sampleNum; i++) {

        if (map.get(current.index * sampleNum + i)==1) {

          Node temp= new Node(i, current.index);

          temp.gcost = PVector.dist(points.get(i), points.get(current.index));

          adjacent.add(temp);

          //println("Node and successor: " + temp.parent + " "+ temp.index);
        }
      }


      for (int i=0; i<adjacent.size(); i++) {

        Node currentAdj = adjacent.get(i);

        if (!open.contains(currentAdj.index)) {

          currentAdj.parent = current.index;

          currentAdj.hcost = PVector.dist(points.get(currentAdj.index), 
            points.get(sampleNum-1));

          currentAdj.gcost += current.gcost;

          currentAdj.fcost = currentAdj.hcost + currentAdj.gcost;


          open.add(currentAdj);
        } else {

          int cindex =  open.get(currentAdj.index);

          if (open.sort.get(cindex).gcost >
            current.gcost + currentAdj.gcost) {

            open.sort.get(cindex).parent = current.index;

            open.sort.get(cindex).gcost = currentAdj.gcost + current.gcost;

            open.sort.get(cindex).fcost = open.sort.get(cindex).gcost + open.sort.get(cindex).hcost;

            open.tosort();
          }
        }
      }
      
      if (open.sort.size() ==0) {
        println("fail");
        return 0;
      }
      
    }

    println("fail");
    return 0;

  }


  void outputPath() {

    if (path.size()>0) {

      Node current = path.get(path.size()-1);

      while (current.parent !=-1) {

        for (int i=0; i< path.size(); i++) {

          if (path.get(i).index == current.parent) {



            finalPath.add(new PVector(points.get(current.index).x, points.get(current.index).y));

            current = path.get(i);

            break;
          }
        }
      }


      PVector temp = new PVector(points.get(current.index).x, points.get(current.index).y);

      finalPath.add(temp);
    } else {

      println("fail");
    }
    println("Path-Finding Complete");
  }

  void drawPath() {


    for (int i=finalPath.size()-1; i>=0; i--) {

      fill(255, 0, 0);

      if (i == finalPath.size()-1 || i ==0) {

        fill(255, 255, 0);
      }

      //println(finalPath.get(i).x + " " + finalPath.get(i).y);

      ellipse(finalPath.get(i).x, finalPath.get(i).y, 20, 20);
    }
  }
}