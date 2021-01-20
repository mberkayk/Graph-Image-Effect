class Seperator {
  
  PImage image;
  LinkedList<Integer> pxlsToChck;
  
  int bodyID[];
  ArrayList<Body> bodies;
  
  int nextBodyID;
  
  public Seperator(PImage img){
    this.image = img;
    pxlsToChck = new LinkedList<Integer>();
    
    bodyID = new int[image.pixels.length];
    bodies = new ArrayList<Body>();
    
    nextBodyID = 1;
  }
  
  void seperateBodies(){ //<>//
    image.loadPixels();
    boolean notDone = true;
    while(notDone){
      
      if(pxlsToChck.size() > 0){
        int i = pxlsToChck.pollFirst();
        PVector v = imgUtil.indToCart(i);
        checkNeighbours((int)v.x, (int)v.y);
        
      }else {
        
        notDone = false;
        for(int i = 0; i < image.pixels.length; i++){
          if(bodyID[i] == 0){
            notDone = true;
            bodyID[i] = nextID();
            bodies.add(new Body(bodyID[i]));
            
            PVector v = imgUtil.indToCart(i);
            checkNeighbours((int)v.x, (int)v.y);
            break;
          }
        }
      
      }
    }
  }
  
  boolean checkPixel(int x, int y, color c, int id){ //return false  if edge
    int bId = bodyID[imgUtil.cartToInd(x, y)];
    color thisColor = color(image.pixels[imgUtil.cartToInd(x, y)]);
    if(bId != 0){
      if (thisColor != c){
        return false; 
      }else{
        return true;
      }
    }
    
    if(thisColor == c){
      
      addToBody(x, y, id);
      addPxlToChckIfDoesntExist(imgUtil.cartToInd(x, y));
      return true;
      
    }else {
      return false; //different color
    }
  }
  
  void checkNeighbours(int x, int y){
    if(x < 0 || x >= image.width || y < 0 || y >= image.height)return;
    boolean isEdge = false;
    int thisIndex = imgUtil.cartToInd(x, y);
    color c = color(image.pixels[thisIndex]);
    int thisID = bodyID[thisIndex];
    
    if(x - 1 >= 0){
      if(checkPixel(x - 1, y, c, thisID) == false){
        isEdge = true;
      }
    }else {
      isEdge = true;
    }
    if(x + 1 < image.width){
      if(checkPixel(x + 1, y, c, thisID) == false){
        isEdge = true;
      }
    }else {
      isEdge = true;
    }
    if(y - 1 >= 0){
      if(checkPixel(x, y - 1, c, thisID) == false){
        isEdge = true;
      }
    }else {
      isEdge = true;
    }
    if(y+1 < image.height){
      if(checkPixel(x, y + 1, c, thisID) == false){
        isEdge = true;
      }
    }else {
      isEdge = true;
    }
    
    if(isEdge){
      setEdge(x, y, thisID);
    }
  }
  
  void addPxlToChckIfDoesntExist(int a){
    if(pxlsToChck.contains(a) == false){
      pxlsToChck.addLast(a);
    }
  }
  
  
  int nextID(){
    return nextBodyID++;
  }

  void addToBody(int x, int y, int id){
    bodyID[imgUtil.cartToInd(x, y)] = id;
    getBodyByID(id).indices.add(imgUtil.cartToInd(x, y));
  }
  
  void setEdge(int x, int y, int id){
    getBodyByID(id).edgePxls.add(imgUtil.cartToInd(x, y));
  }
  
  Body getBodyByID(int id){
    for(Body body : bodies){
      if(body.id == id){
        return body;
      }
    }
    return null;
  }
  
}
