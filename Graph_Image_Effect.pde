import java.util.LinkedList;

PImage input;
PImage output;

Seperator sprtr;
ImageUtilities imgUtil;
Effects eff;
Body selectedBody;
Grapher graph;

boolean preKey;

void settings(){
  //String url = "assets/deer_figure.jpeg";
  String url = "assets/horse.jpeg";
  
  input = loadImage(url);
  output = loadImage(url);
  
  size(input.width, input.height);
  noSmooth();
}

void setup(){
  frameRate(40);
  preKey = false;
  imgUtil = new ImageUtilities(input.width, input.height);
  eff = new Effects();
  
  eff.blur(input, output);
  eff.blur(output, output); // blurs the image twice
  eff.compress(output, output, 5); // compress every color into one of two colors
  imgUtil.copyImage(output, input);
  sprtr = new Seperator(input);
  long time = millis();
  sprtr.seperateBodies();
  println((millis() - time) / 1000);
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
      graph = new Grapher(input.width, input.height, selectedBody, 3000, 3000);
    }  
  }else{
    image(graph.g, 0, 0);
    //if(mousePressed){
    //  graph.construct();
    //}
  }
  
  if(keyPressed && !preKey){
    saveFrame("./output/image####.png");
  }
  
  preKey = keyPressed;
  
}
