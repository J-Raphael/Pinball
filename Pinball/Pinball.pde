// Variáveis Globais:
   float r, m, raio;
   int z = 1, pontuacao = 0, i = 10, j =0;
   PVector position, velocidade, move, pontosPosition;
   boolean pause = true;
   
// Funções:
   // Setup:
      void setup(){  
           size(640, 370);
           noStroke();
           ball( 300, 150, 15);
           base( 0, 10);
      }   
    // Ball:
       void ball(float x, float y, float z){
            position = new PVector( x, y);
            velocidade = PVector.random2D();
            velocidade.mult(3);
            r = z;
      }
    // Base:
       void base(float x, float y){
            move = new PVector( x, y);
       }
    // Udaptade:
       void udaptade(){
            position.add(velocidade);
       }
    // Display:
       void dysplay(){
            fill(255);
            ellipse( position.x, position.y, r*2, r*2);
            rect( move.x, move.y, 10, 60);
            rect( move.x + 630, move.y, 10, 60);
       }
    // Game Over:
       void gameOver(){
            noLoop();
            background(255);
            textSize(40);
            fill(0);
            text( "GAME OVER!", 220, 150);
       }
    // Check Base:
       void checkBase(){
            if( move.y > 310){
                move.y = 310; 
            }
            else if (move.y < 0 + 40){
                move.y = 0 + 40;
            }
        }
    // Check Colisão:
       void checkColisao(){
            if (position.x >= 620) {
              if ((position.y < move.y) || ( position.y > move.y + 60)){
                   z = 0;
              }
              else{
                  position.x = 620;
                  velocidade.x *= -1;
              }
            } 
            else if (position.x < 20) {
              if ((position.y < move.y) || ( position.y > move.y + 60)){
                   z = 0;
              }
              else{
                  position.x = 20;
                  velocidade.x *= -1;
              }
            } 
            else if (position.y > height-r) {
              position.y = height-r;
              velocidade.y *= -1;
            } 
            else if (position.y < r + 40) {
              position.y = r + 40 ;
              velocidade.y *= -1;
            }  
        }
     // Key Pressed:
        void keyPressed(){
            if(z==2){
                if(key == 'p'){ pause = !pause;}
                if(pause){
                   if((key == 's') || ( key == 'S' ) || ( key == 65535 && keyCode == 40)){
                      move.y = move.y + i;
                      i++;
                      checkBase();
                    }
                   if((key == 'w') || ( key == 'W' ) || ( key == 65535 && keyCode == 38)){
                    move.y = move.y - i;
                    i--;
                    checkBase();
                  }
                }
            }
            if(z==0){
              if ( key == 10 ) { 
                  z = 1; 
                  pontuacao = 0;
                  ball( 300, 150, 15);
                  base( 0, 10);
              }
              else { z = -1; }
            }
        } 
     // Continuar:
        void continuar(){
             fill(0);
             background(255);
             textSize(25);
             text("A sua pontuação foi de: " + pontuacao, 130, 100 );
             text("(Pressione 'enter' para jogar novamente)", 100, 200);            
          }
          
    // Pontuação extra:
       void pontos(){
            float x, y, z = 10;
            do{
              x = random(640);
              y = random(370);
            }while(250<x && x<615 && 45<y && y<365);
            pontosPosition = new PVector( x, y);
            raio = z;
            
       }
          
    // Draw:
       void  draw(){
            if ( z > 0){
                 if( z == 1 ){
                     background(255);
                     textSize(40);
                     fill(0);
                     text( "PINBALL", 240, 120);
                     textSize(25);
                     text( "(Pressione qualquer tecla pra começar)", 100, 170);
                     if(keyPressed){ z =2;}
                 }                 
                 if( z == 2){
                     if(pause){
                         background(0);
                         fill(255, 0, 0);
                         rect(0, 0, 640, 40);
                         fill(0, 0, 0);
                         rect(570, 10, 50, 20);
                         textSize(15);
                         text("Pontuacao: ", 480, 25);
                         fill(255);
                         text(pontuacao, 570, 25);
                         udaptade();
                         dysplay();
                         checkColisao();
                         j+= 1;
                         if( (j % 30) == 0){
                             pontuacao += 1;
                         }
                         if( (pontuacao % 50 ) == 0){
                            pontos();
                            ellipse(pontosPosition.x, pontosPosition.y, raio*2, raio*2);
                         }
                   }
                 }
            }
            else if( z == 0){
                 continuar();
            }
            else{
                 gameOver(); 
            }
       }
     
      