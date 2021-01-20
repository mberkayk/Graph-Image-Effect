class Effects {
  
  void detectEdges(PImage input, PImage output, int threshold, boolean darkenBg){

    input.loadPixels();
    output.loadPixels();
    
    for(int i = 0; i < input.height-1; i++){
      for(int j = 0; j < input.width-1; j++){
        int index = j + i * input.width;
        if(compareBrightness(input.pixels[index], input.pixels[index + 1]) > threshold 
        || compareBrightness(input.pixels[index], input.pixels[index+input.width]) > threshold){
          output.pixels[index] = color(255);
        }else{
          if(darkenBg) { 
            output.pixels[index] = color(0);
          }
        }
      }
    }
    output.updatePixels();
  }
  
  
  int compareBrightness(color c1, color c2){
    return abs((int)( brightness(c1) - brightness(c2) ));
  }
  
  void compress(PImage input, PImage output, int steps){
    input.loadPixels();
    output.loadPixels();
    for(int i = 0; i < input.pixels.length; i++){
      int c = (int)brightness(input.pixels[i]);
      output.pixels[i] = color((floor(steps*c/255f) * 255f/steps));
    }
    output.updatePixels();
  }
  
  void blur(PImage input, PImage output){
    input.loadPixels();
    output.loadPixels();
    
    for(int i = 1; i < input.height-1; i++){
      for(int j = 1; j < input.width-1; j++){
        int index = j + i * input.width;
        float sum = brightness(color(input.pixels[index + 1])) +
        brightness(color(input.pixels[index - 1])) +
         brightness(color(input.pixels[index+input.width])) +
         brightness(color(input.pixels[index - input.width])) +
         
         brightness(color(input.pixels[index + 1 + input.width])) +
         brightness(color(input.pixels[index - 1 - input.width])) +
         brightness(color(input.pixels[index + input.width - 1])) +
         brightness(color(input.pixels[index - input.width + 1]));
         
         output.pixels[index] = color(sum/9.0);
      }
    }
    output.updatePixels();
  }
  
}
