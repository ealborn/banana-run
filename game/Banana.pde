class Banana {
  PImage[] animation;
  PImage idle;
  PVector position;
  
  int keyCode;
  float index = 0;
  float speed;
  float increase;
  float increment;
  float initIncrease;
  
  /*
  * Constructor, here we set initial values, such as starting position and speed
  */
  Banana(int x, int y, int key) {
    PImage runSheet = loadImage("assets/mario_running.png");
    
    this.idle = loadImage("assets/mario_idle.png");
    
    this.animation = this.setAnimation(runSheet);
    this.position = new PVector(x, y);
    
    this.speed = 0;
    this.increase = 0.005;
    this.initIncrease = this.increase;
    this.increment = 0.001;
    this.keyCode = key;
  }
  
  /*
  * Here we send in a spritesheet and split it into an array of sprites
  *
  * @params PImage sheet
  * @return PImage[]
  */
  PImage[] setAnimation(PImage sheet) {
    int spriteWidth = 17;
    PImage[] anim = new PImage[sheet.width / spriteWidth];
    
    for(int i = 0; i < sheet.width / spriteWidth; i++) {
      int x = i * spriteWidth;
      anim[i] = sheet.get(x, 0, spriteWidth, sheet.height);
    }
    return anim;
  }
  
  /*
  * Show idle image at current position
  */
  void idle() {
    image(this.idle, this.position.x, this.position.y);
  }
  
  /*
  * Loop through animation array and display the image at current position
  * The math sets which sprite to show depending on speed
  * 
  * @params float speed
  */
  void run() {
    position.sub(new PVector(this.speed * 2, 0));
    image(this.animation[floor(this.index) % this.animation.length], this.position.x, this.position.y);
    index += this.speed;
  }
  
  /*
  * Increases the speed exponentially
  */
  void increaseSpeed() {
    this.speed = sqrt(this.increase);
    this.increase += this.increment;
  }
  
  /*
  * Decreases speed so that banana stops running if you stop hitting the button/banana
  * If the speed goes under 0, it resets speed and increase to their initial values
  */
  void decreaseSpeed() {
    this.speed -= this.increase / 5;
    if (this.speed < 0) {
      this.speed = 0;
      this.increase = this.initIncrease;
    }
  }
}
