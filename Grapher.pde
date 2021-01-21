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
      int index1 = vertices.get((int)random(0, vertices.size()));
      int index2 = vertices.get((int)random(0, vertices.size()));
      
      PVector v1 = imgUtil.indToCart(this.body.indices.get(index1));
      PVector v2 = imgUtil.indToCart(this.body.indices.get(index2));
      
      //find another vertex where the connecting line doesn't go through the
      //body's edge
      //while(){
        //interpolate between v1 and v2
        
        //if one of the points is not in the body then don't connect them
        
      //}
      
      //connect v1 and v2
      g.strokeWeight(1);
      g.stroke(255);
      //g.line(ve1.x, ve1.y, ve2.x, ve2.y);
      
    }
    g.endDraw();
  }
  
  PGraphics getGrahipcs(){
    return g;
  }
}
