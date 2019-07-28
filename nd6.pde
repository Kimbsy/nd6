color L_RED = color(255, 0, 0, 50);
color L_BLUE = color(0, 0, 255, 50);
color L_GREEN = color(0, 255, 0, 50);
color L_YELLOW = color(255, 255, 0, 50);
color L_GREY = color(255, 255, 255, 50);

color D_RED = color(255, 0, 0, 100);
color D_BLUE = color(0, 0, 255, 100);
color D_GREEN = color(0, 255, 0, 100);
color D_YELLOW = color(255, 255, 0, 100);
color D_GREY = color(255, 255, 255, 100);

ArrayList<Button> buttons = new ArrayList<Button>();

Button rollButton;

int current_n = 1;
int selected = 4;
int successes = 0;
float deviation = 0;
int[] results = {0, 0, 0, 0, 0, 0};

float top;
float tx0;
float tx1;
float tx2;
float bx0;
float bx1;
float bx2;
float bx3;
float top_w;
float top_h;
float top0;
float top1;
float top2;
float top3;
float top4;
float top5;
float bot_w;
float bot_h;
float bot0;
float bot1;

public void setup() {
  //fullScreen();
  size(400, 800);
  stroke(255);
  strokeWeight(0);
  
  top = (height / 8) * 7;
  
  tx0 = 0;
  tx1 = width / 3;
  tx2 = tx1 * 2;
 
  bx0 = 0;
  bx1 = width / 4;
  bx2 = bx1 * 2;
  bx3 = bx1 * 3;

  top_w = tx1;
  top_h = top / 6;
  top0 = 0;
  top1 = top_h;
  top2 = top_h * 2;
  top3 = top_h * 3;
  top4 = top_h * 4;
  top5 = top_h * 5;
  
  bot_w = width / 4;
  bot_h = height / 16;
  bot0 = top;
  bot1 = bot0 + bot_h;
 
  Button minus5 = new Button(bx0, bot1, bot_w, bot_h, D_RED, "-5");
  Button minus1 = new Button(bx1, bot1, bot_w, bot_h, L_RED, "-1");
  Button add1 = new Button(bx2, bot1, bot_w, bot_h, L_GREEN, "+1");
  Button add5 = new Button(bx3, bot1, bot_w, bot_h, D_GREEN, "+5");
  Button reroll1s = new Button(bx0, bot0, bot_w, bot_h, L_YELLOW, "reroll 1s");
  rollButton = new Button(bx1, bot0, (bot_w * 3), bot_h, L_BLUE, "roll 1 d6");
  buttons.add(minus5);
  buttons.add(minus1);
  buttons.add(add1);
  buttons.add(add5);
  buttons.add(reroll1s);
  buttons.add(rollButton);
  
  Button d6 = new Button(tx0, top0, top_w, top_h, L_GREY, "6");
  Button d5 = new Button(tx0, top1, top_w, top_h, L_GREY, "5");
  Button d4 = new Button(tx0, top2, top_w, top_h, L_GREY, "4");
  Button d3 = new Button(tx0, top3, top_w, top_h, L_GREY, "3");
  Button d2 = new Button(tx0, top4, top_w, top_h, L_GREY, "2");
  Button d1 = new Button(tx0, top5, top_w, top_h, L_GREY, "1");
  buttons.add(d6);
  buttons.add(d5);
  buttons.add(d4);
  buttons.add(d3);
  buttons.add(d2);
  buttons.add(d1);
}

public void draw() {
  background(200);
  drawButtons();
  drawResults();
  drawStats();
  drawSelector();
}

public void drawButtons() {
  for (int i = 0; i < buttons.size(); i++) {
    Button b = buttons.get(i);
    b.display();
  }
}

public void drawResults() {
  fill(L_GREY);
  rect(tx1, top0, top_w, top_h);
  rect(tx1, top1, top_w, top_h);
  rect(tx1, top2, top_w, top_h);
  rect(tx1, top3, top_w, top_h);
  rect(tx1, top4, top_w, top_h);
  rect(tx1, top5, top_w, top_h);
  
  fill(255);
  textAlign(CENTER, CENTER);
  textSize(18);
  text(results[0], tx1 + (top_w / 2), top0 + (top_h / 2));
  text(results[1], tx1 + (top_w / 2), top1 + (top_h / 2));
  text(results[2], tx1 + (top_w / 2), top2 + (top_h / 2));
  text(results[3], tx1 + (top_w / 2), top3 + (top_h / 2));
  text(results[4], tx1 + (top_w / 2), top4 + (top_h / 2));
  text(results[5], tx1 + (top_w / 2), top5 + (top_h / 2));
}

public void drawStats() {
  fill(D_GREY);
  rect(tx2, top0, top_w, top_h);
  //rect(tx2, top1, top_w, top_h);
  
  fill(255);
  textSize(18);
  textAlign(CENTER, CENTER);
  text ("successes:", tx2 + (top_w / 2), top0 + (top_h / 5));
  text (successes, tx2 + (top_w / 2), top0 + ((top_h / 5) * 3));
  //text ("deviation:", tx2 + (top_w / 2), top1 + (top_h / 5));
  //text (deviation, tx2 + (top_w / 2), top1 + ((top_h / 5) * 3));
}

public void drawSelector() {
  strokeWeight(4);
  noFill();
  float h = ((7 - selected) * top_h) - 4; 
  rect(2, 2, top_w - 4, h);
  strokeWeight(0);
}

public void roll() {
  for (int i = 0; i < 6; i++) {
    results[i] = 0;
  }

  for (int i = 0; i < current_n; i++) {
    results[(int) random(6)]++;
  }
}

public void reroll1s() {
  int count = results[5];
  results[5] = 0;
  
  for (int i = 0; i < count; i++) {
    results[(int) random(6)]++;
  }
}

public void updateStats() {
  int total = 0;
  for (int i = 6 - selected; i >= 0; i--) {
    total += results[i];
  }
  successes = total;
}

public void mouseClicked() {
  String text = "NONE";
  
  for (int i = 0; i < buttons.size(); i++) {
    Button b = buttons.get(i);
    if (b.isInBounds(mouseX, mouseY)) {
      text = b.getText();
      break;
    }
  }
    
  switch (text) {
    case "6":
        selected = 6;
        break;
    case "5":
        selected = 5;
        break;
    case "4":
        selected = 4;
        break;
    case "3":
        selected = 3;
        break;
    case "2":
        selected = 2;
        break;
    case "1":
        selected = 1;
        break;
    case "reroll 1s":
        reroll1s();
        break;
    case "-5":
        current_n = max(0, current_n - 5);
        break;
    case "-1":
        current_n = max(0, current_n - 1);
        break;
    case "+1":
        current_n++;
        break;
    case "+5":
        current_n += 5;
        break;
    case "roll":
        roll();
        break;
    
  }
  updateStats();
  rollButton.setText("roll " + current_n + " d6");
}
