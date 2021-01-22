import java.util.LinkedList;

PImage input;
PImage output;

Seperator sprtr;
ImageUtilities imgUtil;
Effects eff;
Body selectedBody;
Grapher graph;

void settings(){
  String url = "assets/deer_figure_head.png";
  
  input = loadImage(url);
  output = loadImage(url);
  
  size(input.width, input.height);
  noSmooth();
}

void setup(){
  
  imgUtil = new ImageUtilities(input.width, input.height);
  eff = new Effects();
  
  eff.blur(input, output);
  eff.blur(output, output); // blurs the image twice
  eff.compress(output, output, 2); // compress every color into one of two colors
  imgUtil.copyImage(output, input);
  sprtr = new Seperator(input);
  sprtr.seperateBodies();
}

void draw(){
  
  image(output, 0, 0, width, height, 0, 0, output.width, output.height);
  //image(input, 0, 0, width, height, 0, 0, input.width, input.height);


  //Select the body
  if(selectedBody == null){
    int hoverID = sprtr.bodyID[imgUtil.cartToInd(mouseX, mouseY)];
    ArrayList<Integer> arr = sprtr.getBodyByID(hoverID).edgePxls;
    for(int i = 0; i < arr.size(); i++){
      PVector v = imgUtil.indToCart(arr.get(i));
      set((int)v.x, (int)v.y, color(255, 0, 0));
    }
    
    if(mousePressed){
      selectedBody = sprtr.getBodyByID(hoverID);
      graph = new Grapher(input.width, input.height, selectedBody, 50, 100);
    }  
  }else{
    image(graph.g, 0, 0);
    if(mousePressed){
      graph.construct();
    }
  }
  
  if(keyPressed){
    g.save("/output/image####.png");
  }
  
  
  
}
