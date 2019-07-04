class sortedList {

  LinkedList<Node> sort;

  sortedList() {

    sort = new LinkedList<Node>();
  }

  void add(Node node) {

    sort.add(node);

    //sort
    for (int i = 0; i < sort.size() - 1; i++)
    {
      for (int j = 0; j < sort.size() - i - 1; j++) {

        if (sort.get(j).fcost> sort.get(j+1).fcost)
        {
          Node temp = new Node();

          temp = sort.get(j);

          sort.set(j, sort.get(j+1));

          sort.set(j+1, temp);
        }
      }
    }
  }

  Node getLowest() {

    return sort.pop();
  }

  boolean contains(int index) {

    boolean has = false;

    for (int i=0; i<sort.size(); i++) {

      if (sort.get(i).index == index) {

        has = true;
      }
    }

    return has;
  }

  void remove() {

    sort.pop();
  }

  int get(int index) {

    int temp = 0;

    for (int i=0; i<sort.size(); i++) {

      if (sort.get(i).index == index) {

        temp = i;

        return temp;
      }
    }

    return temp;
  }
  void tosort() {

    //sort
    for (int i = 0; i < sort.size() - 1; i++)
    {
      for (int j = 0; j < sort.size() - i - 1; j++) {

        if (sort.get(j).fcost> sort.get(j+1).fcost)
        {
          Node temp = new Node();

          temp = sort.get(j);

          sort.set(j, sort.get(j+1));

          sort.set(j+1, temp);
        }
      }
    }
  }
}