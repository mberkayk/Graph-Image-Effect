//the final effect, construct the network
class Grapher {

  PGraphics g;
  ImageUtilities imgUtil;
  Body body;
  
  int linkCount;
  int vertexCount;
  
  public Grapher(int w, int h, Body b, int vCount, int linkCount){
    g = createGraphics(w,h);
    g.noSmooth();
    imgUtil = new ImageUtilities(w, h);
    this.body = b;
    
    this.vertexCount = vCount;
    this.linkCount = linkCount;
    
    construct();
  }
  
  void construct(){
  
     println("constructing");
    //select random vertices
    // vertices is an array of indices of the body.indices array
    ArrayList<Integer> vertices = new ArrayList<Integer>();
    for(int i = 0; i < vertexCount; i++){
      int random = (int)random(0, this.body.edgePxls.size());
      if(vertices.contains(random) == false){
        vertices.add(random);
      }
    }
    //connect vertices randomly (if they don't intersect with any of the edges)
    g.beginDraw();
    g.background(0);
    for(int i = 0; i < linkCount; i++){
      int index1 = vertices.get((int)random(0, vertices.size()));
      int index2 = vertices.get((int)random(0, vertices.size()));
      
      PVector v1 = imgUtil.indToCart(this.body.edgePxls.get(index1));
      PVector v2 = imgUtil.indToCart(this.body.edgePxls.get(index2));
      
      while(isLineInsideBody(v1, v2) == false){
        index2 = vertices.get((int)random(0, vertices.size()));
        v2 = imgUtil.indToCart(this.body.edgePxls.get(index2));
      }
      
      //connect v1 and v2
      g.strokeWeight(1);
      g.stroke(255, 255, 255, 50);
      g.line(v1.x, v1.y, v2.x, v2.y);
      
    }
    g.endDraw();
    println("finished");
  }
  
  PGraphics getGrahipcs(){
    return g;
  }
  
  boolean isLineInsideBody(PVector v1, PVector v2){
    int x1 = (int)v1.x; int y1 = (int)v1.y;
    int x2 = (int)v2.x; int y2 = (int)v2.y;
    
    float x = x1; float y = y1;
    int num  = abs(x2-x1) + abs(y2-y1);
    
    for(int i = 0; i < num; i++){
      int index = imgUtil.cartToInd((int)x, (int)y);
      if(body.indices.contains(index) == false){
        return false;
      }
      x += (x2-x1)/(float)num;
      y += (y2-y1)/(float)num;
    }
    
    return true;
  }
}
