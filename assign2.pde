final int GAME_START = 1 , GAME_RUN = 2 , GAME_LOSE = 3;
int gameState;


int soldierX,soldierY,soldierSpeed;
int groundhogX,groundhogY,groundhogSpeed;
int cabbageX,cabbageY;

PImage bg ,life ,robot ,soil ,soldier ,cabbage ;
PImage groundhogIdle ,groundhogDown ,groundhogLeft, groundhogRight;
PImage gameover,title,restartHovered,restartNormal,startHovered,startNormal;

boolean upPressed = false;
boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;
boolean noPressed = true;

boolean cabbageTouched = false;

int TOTAL_LIFE = 2;
  



void setup() {
	size(640, 480, P2D);
	bg = loadImage("img/bg.jpg");
  title = loadImage("img/title.jpg");
  gameover = loadImage("img/gameover.jpg");
  groundhogIdle = loadImage("img/groundhogIdle.png");
  groundhogDown = loadImage("img/groundhogDown.png");
  groundhogLeft = loadImage("img/groundhogLeft.png");
  groundhogRight = loadImage("img/groundhogRight.png");
  groundhogX = 320;
  groundhogY = 80;
  groundhogSpeed = 80;
  life = loadImage("img/life.png");
  soil = loadImage("img/soil.png");
  
  startHovered = loadImage("img/startHovered.png");
  startNormal = loadImage("img/startNormal.png");
  restartHovered = loadImage("img/restartHovered.png");
  restartNormal = loadImage("img/restartNormal.png");
  
  soldier = loadImage("img/soldier.png");
  //set soldier's coordinate
  soldierX = -80;
  soldierY = floor(random(2,6))*80;
  
  cabbage = loadImage("img/cabbage.png");
  cabbageX = floor(random(1,8))*80;
  cabbageY = floor(random(2,6))*80;

  gameState = GAME_START;


}

void draw() {
  background(255); 
  
	// Switch Game State
  switch (gameState){
    
    // Game Start
    case GAME_START:
    image(title,0,0);
    image(startNormal,248,370);
    //mouse action
    if(mouseX > 248 && mouseX < 392 && mouseY >370 && mouseY < 430 ){
      if(mousePressed){
        //click
        gameState = GAME_RUN;

      }else{
        //change buttom color
        image(startHovered,248,370);
      }
    }
    break;
    
  case GAME_RUN:

		// Game Run
    //set sky
    image(bg,0,0);
    //grass
    noStroke();
    fill(124, 204, 25);
    rect(0, 145, 640, 480);
    //sun
    fill(255, 255, 0);
    ellipse(590,50,130,130);
    fill(253, 184, 19);
    ellipse(590,50,120,120);
    //ground
    image(soil,0,160);
    
    //life icon
    if (TOTAL_LIFE == 1){
    image(life,10,10);
    }
    else if (TOTAL_LIFE == 2){
    image(life,10,10);
    image(life,80,10);
    }
    else if (TOTAL_LIFE > 2){
    image(life,10,10);
    image(life,80,10);
    image(life,150,10);
    }
    
    //set soldier
    image(soldier,soldierX,soldierY);
    //let the soldier move 
    soldierSpeed = 2;
    soldierX += soldierSpeed;
    soldierX %= 640; 
    
    //set cabbage
    if(cabbageTouched == false){
      image(cabbage,cabbageX,cabbageY);
    }
    
    //set groundhog 
    
    if(downPressed == true){
    image(groundhogDown,groundhogX,groundhogY);
    }
    
    if(rightPressed == true){
    image(groundhogRight,groundhogX,groundhogY);
    }
    
    if(leftPressed == true){
    image(groundhogLeft,groundhogX,groundhogY);
    }
    
    if(noPressed == true){
    image(groundhogIdle,groundhogX,groundhogY);
    }
    
    
    //boundary detection
    if(groundhogX > 560){
      groundhogX = 560; 
    }
    if(groundhogX < 0){
      groundhogX = 0; 
    }
    if(groundhogY < 80){
      groundhogY = 80; 
    }
    if(groundhogY > 400){
      groundhogY = 400; 
    }
    
    //don' touch soldier
    if(groundhogX >= soldierX && groundhogX < soldierX+80 && groundhogY >= soldierY && groundhogY < soldierY+80){
      groundhogX = 320; 
      groundhogY = 80; 
      TOTAL_LIFE -= 1;
    }

    //eat cabbage
    if(groundhogX >= cabbageX && groundhogX < cabbageX+80 && groundhogY >= cabbageY && groundhogY < cabbageY+80 && cabbageTouched == false){
    cabbageTouched = true;
    TOTAL_LIFE += 1 ;
    
    }

    if (TOTAL_LIFE < 1){
      gameState = GAME_LOSE;
    }
break;   
  
		// Game Lose
    case GAME_LOSE:
    image(gameover,0,0); 
    image(restartNormal,248,370);
    
    //mouse action
    if(mouseX > 248 && mouseX < 392 && mouseY >370 && mouseY < 430 ){
      if(mousePressed){
        //click
        TOTAL_LIFE = 2 ;
        gameState = GAME_RUN;
        cabbageTouched = false;
        soldier = loadImage("img/soldier.png");
        soldierX = -80;
        soldierY = floor(random(2,6))*80;
  
        cabbage = loadImage("img/cabbage.png");
        cabbageX = floor(random(1,8))*80;
        cabbageY = floor(random(2,6))*80;
        if(cabbageTouched == false){
            image(cabbage,cabbageX,cabbageY);
        }
    
      }else{
        //change buttom color
        image(restartHovered,248,370);
      }
    }
break;  
}

}

void keyPressed(){
  if (key == CODED){
    switch (keyCode){

      case DOWN:
        downPressed = true;
        noPressed = false;
        groundhogY += groundhogSpeed;
        
        break;
      case RIGHT:
        rightPressed = true;
        noPressed = false;
         groundhogX += groundhogSpeed;
        break;
      case LEFT :
        leftPressed = true;
        noPressed = false;
        groundhogX -= groundhogSpeed;
        break;
    }
  }
}


void keyReleased(){
    if (key == CODED){
    switch (keyCode){

      case DOWN:
        downPressed = false;
        noPressed = true;
        break;
      case RIGHT:
        rightPressed = false;
        noPressed = true;
        break;
      case LEFT :
        leftPressed = false;
        noPressed = true;
        break;
    }
  }
}
