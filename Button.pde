class Button {
  float x, y, w, h;
  color c;
  String text;
  
  public Button(float x, float y, float w, float h, color c, String text) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.c = c;
    this.text = text;
  }
  
  public void setText(String text) {
    this.text = text;
  }
  
  public String getText() {
    if (match(this.text, "roll \\d+ d6") != null) {
      return "roll";
    }
    return this.text;
  }
  
  public boolean isInBounds(float clickx, float clicky) {
    return clickx > this.x &&
           clicky > this.y &&
           clickx < (this.x + this.w) &&
           clicky < (this.y + this.h);
  }
  
  public void display() {
    fill(c);
    rect(x, y, w, h);
    
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(18);
    text(text, x + (w / 2), y + (h / 2));
  }
}
