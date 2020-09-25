class Shooter{
  int x,y,size;
  float coolDown,vel;
  boolean right,left,up,down,space,life;
  Shooter(){
    size = 50;
    x = width/2;
    y = height-size;
    coolDown =10;
    vel =3;
    
  }
  void display(){
    fill(0, 255, 0);
    stroke(0);
    ellipseMode(CENTER);
    ellipse(x, y, size, size);
  }
  void move(){
    if(right){x+=vel;}    
    if(left){x-=vel;}
    if(up){y-=vel;}
    if(down){y+=vel;}
    if(x<0){x =0;}
    if(x>width){x = width;}
    if(y<0){y =0;}
    if(y>height){ y = height;}
    }
  
  void update(){
    move();
    if(space && coolDown >=10){
      sBullet.add(new Bullet(s));
      coolDown = 0;
    }
    coolDown += .5;
  }
}
class Bullet{
  int x,y;
  int velocity,maxSpeed;
  boolean firing;
  
  
  Bullet(Shooter s){
    x = s.x;
    y = s.y - s.size/2;
    velocity = -5;
    firing = true;
  }
  
  void display(){
    noStroke();
    fill(255,255,0);
    rectMode(CENTER);
    rect(x, y,2,10);
    
  }
  
  void update(){
    y += velocity;
    
    if(x>width || x<0 || y>height || y<0){
      firing = false;
    }
    
  }
 
}

class Zombie{
  float x,y,size,vel;
  int life;
  
  Zombie(){
    size = 50;
    x = width/2;
    y = 0;
    vel = 2;
    life = 3;
  }
  
  void display(){
    fill(255, 0, 0);
    stroke(0);
    ellipseMode(CENTER);
    ellipse(x, y, size, size);
  }
  
  void update(){
    for(Bullet bullet:sBullet){
      if((x-size/2 <= bullet.x && bullet.x<= x+size/2) && (y-size/2<=bullet.y && bullet.y <= y+size/2)){
        life-=1;
        fill(255,250,250);
        stroke(0);
        ellipseMode(CENTER);
        ellipse(x, y, size, size);
        bullet.firing = false;
      }
    }
    if(dist(s.x,s.y,x,y) > 50){
      x += (s.x-x)*.005;
      y += (s.y-y)*.005;
    } 
  }              
}

Shooter s;
Zombie zom;
ArrayList<Bullet> sBullet = new ArrayList<Bullet>();
ArrayList<Zombie> zombie = new ArrayList<Zombie>();

void setup(){
  size(600, 600);
  s = new Shooter();
  zombie.add(new Zombie());
}
void draw(){
  background(50);
  s.display();
  s.update();

  for(Zombie zom:zombie){
    zom.display();
  }
  for(Bullet bullet : sBullet){
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
  
  ArrayList<Zombie> tempZom = new ArrayList<Zombie>();
  for(Zombie zom : zombie){
    zom.update();
    if(zom.life > 0){
      tempZom.add(zom);
    }
  }
  zombie = tempZom;
  if(random(1) < 0.007){
    zombie.add(new Zombie());
  }
  
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
