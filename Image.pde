
class ImageUtilities {
  
  int width, height;
  
  public ImageUtilities(int w, int h){
    width = w;
    height = h;
  }
  
  void copyImage(PImage src, PImage dest){
    dest.loadPixels();
    src.loadPixels();
    for(int i = 0; i < src.pixels.length; i++){
      dest.pixels[i] = src.pixels[i];
    }
  }
  
  int cartToInd(int x, int y){
    return width*y + x;
  }
  
  PVector indToCart(int i){
    return new PVector((i%this.width),(i/this.width));
  }
  
  void clearImage(PImage img){
    img.loadPixels();
    for(int i = 0; i < img.pixels.length; i++){
      img.pixels[i] = color(0);
    }
    img.updatePixels();
  }
}
