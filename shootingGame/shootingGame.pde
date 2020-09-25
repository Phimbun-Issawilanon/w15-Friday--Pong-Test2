class Shooter{
  int x,y,size;
  float coolDown;
  boolean right,left,up,down,space,life;
  Shooter(){
    size = 50;
    x = width/2;
    y = height-size;
    coolDown =10;
    
  }
  void draw(){
    fill(0, 255, 0);
    stroke(0);
    ellipseMode(CENTER);
    ellipse(x, y, size, size);
  }
  void move(){
    if(right){x+=3;}    
    if(left){x-=3;}
    if(up){y-=3;}
    if(down){y+=3;}
    if(x<0){x =0;}
    if(x>width){x = width;}
    if(y<0){y =0;}
    if(y>height){ y = height;}
    }
  
  void update(){
    move();
    println(coolDown);
    if(space && coolDown >=10){
      sBullet.add(new Bullet());
      coolDown = 0;
    }
    coolDown += .5;
  }
}
ArrayList<Bullet> sBullet = new ArrayList<Bullet>();
class Bullet{
  int x,y;
  int velocity,maxSpeed;
  boolean firing;
  
  
  Bullet(){
    velocity = 5;
    maxSpeed = 10;  
    firing = false;
  }
  
  void setStartLocation(int startX,int startY){
    if(firing == false){
      x = startX;
      y = startY;
      firing = true;
    }
  }
  
  void display(){
    noStroke();
    fill(255,255,0);
    rectMode(CENTER);
    rect(x, y,5,10);
    
  }
  
  void update(){
    if(firing == true){
      if(velocity<maxSpeed){velocity += 1;}
      y -= velocity;
      if(x>width || x<0 || y>height || y<0){
        velocity = 0;
        firing = false;
      }
    }
  }
}

Shooter s;

void setup(){
  size(600, 600);
  s = new Shooter();
}
void draw(){
  background(255);
  s.draw();
  s.update();
  
  for(Bullet bullet : sBullet){
    bullet.setStartLocation(s.x,s.y-30);
    bullet.display();
  }
  ArrayList<Bullet> tempBullet = new ArrayList<Bullet>();
  for(Bullet bullet : sBullet){
    bullet.update();
    if(bullet.firing){
      tempBullet.add(bullet);
    }
  }
  sBullet = tempBullet;
  
}
void keyPressed(){
  if(key== CODED){
    if(keyCode == UP){s.up = true;}
    if(keyCode == DOWN){s.down = true;}
    if(keyCode == LEFT){s.left = true;}
    if(keyCode == RIGHT){s.right = true;}
  }
  if(key == ' '){s.space = true;}
}
void keyReleased(){
  if(key== CODED){
    if(keyCode == UP){s.up = false;}
    if(keyCode == DOWN){s.down = false;}
    if(keyCode == LEFT){s.left = false;}
    if(keyCode == RIGHT){s.right = false;}
  }
  if(key == ' '){s.space = false;}
}
