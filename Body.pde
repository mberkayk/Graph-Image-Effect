//Set of all pixels that are connected and are the same color

class Body {
  
  ArrayList<Integer> indices;
  ArrayList<Integer> edgePxls;
  int id;
  
  Body(int id){
    this.id = id;
    this.indices = new ArrayList<Integer>();
    this.edgePxls = new ArrayList<Integer>();
  }

}
