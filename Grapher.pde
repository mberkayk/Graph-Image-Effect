//the final effect, construct the network
class Grapher {

  PGraphics g;
  ImageUtilities imgUtil;
  Body body;
  
  public Grapher(int w, int h, Body b, int vCount, int linkCount){
    g = createGraphics(w,h);
    imgUtil = new ImageUtilities(w, h);
    this.body = b;
    
    construct(vCount, linkCount);
  }
  
  void construct(int vertexCount, int linkCount){
  
    //select random vertices
    ArrayList<Integer> vertices = new ArrayList<Integer>();
    for(int i = 0; i < vertexCount; i++){
      int random = (int)random(0, this.body.indices.size());
      if(vertices.contains(random) == false){
        vertices.add(random);
      }
    }
  //connect vertices randomly (if they don't intersect with any of the edges)
    g.beginDraw();
    g.background(0);
    for(int i = 0; i < linkCount; i++){
      int v1 = vertices.get((int)random(0, vertices.size()));
      int v2 = vertices.get((int)random(0, vertices.size()));
      
      while(intersectsEdge(v1, v2)){
        v2 = vertices.get((int)random(0, vertices.size()));
      }
      
      //connect v1 and v2
      PVector ve1 = imgUtil.indToCart(v1);
      PVector ve2 = imgUtil.indToCart(v2);
      g.strokeWeight(1);
      g.stroke(255);
      g.line(ve1.x, ve1.y, ve2.x, ve2.y);
      
    }
    g.endDraw();
  }
  
  boolean intersectsEdge(int v1, int v2){
    return false;
  }
  
  PGraphics getGrahipcs(){
    return g;
  }
}
