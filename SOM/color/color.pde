final int MAP_WIDTH = 30;
final int MAP_HEIGHT = 30;
final int T = 5000;

int[][][] unitArray = new int[MAP_WIDTH][MAP_HEIGHT][3];
int t = 1;

void setup(){
  size(500, 500);
  
  int randR, randG, randB;
  
  // set random vectors
  for(int i=0; i<MAP_WIDTH; i++){
    for(int j=0; j<MAP_HEIGHT; j++){
      
      randR = int(random(256));
      randG = int(random(256));
      randB = int(random(256));
      
      unitArray[i][j][0] = randR;
      unitArray[i][j][1] = randG;
      unitArray[i][j][2] = randB;
      
      fill(randR, randG, randB);
      rect(i*100, j*100, 100, 100);
      
    }
  }
}

void draw(){
 
    // set input vector
  int[] inputArray = {int(random(256)), int(random(256)), int(random(256))};
  
  // find Best Maching Unit
  int BMUi=0, BMUj=0;
  float tempDistance;
  float minDistance = Float.MAX_VALUE;
  
  for(int i=0; i<MAP_WIDTH; i++){
    for(int j=0; j<MAP_HEIGHT; j++){
      tempDistance = calculateDistance(unitArray[i][j], inputArray);
      
      if(minDistance > tempDistance){
        minDistance = tempDistance;
        BMUi = i;
        BMUj = j;
      }
    }
  }
  
  updateUnits(BMUi, BMUj, inputArray);
  
  if(t%100 == 1){
  for(int i=0; i<MAP_WIDTH; i++){
    for(int j=0; j<MAP_HEIGHT; j++){
      fill(unitArray[i][j][0], unitArray[i][j][1], unitArray[i][j][2]);
      rect(i*500/MAP_WIDTH, j*500/MAP_HEIGHT, 500/MAP_WIDTH, 500/MAP_HEIGHT); 
    }
  }
  }
  t++;
  
  println(t);
  
  if(t > T){
    noLoop();
  }
}

// calculate distance
float calculateDistance(int[] unitArray1, int[] unitArray2){
  float distance;
  
  distance = sqrt(sq(unitArray1[0] - unitArray2[0]) + sq(unitArray1[1] - unitArray2[1]) + sq(unitArray1[2] - unitArray2[2]));
  
  return distance;
}

// update unit
void updateUnits(int i, int j, int[] inputArray){
  // update weight vector
  for(int ti=0; ti<MAP_WIDTH; ti++){
    for(int tj=0; tj<MAP_HEIGHT; tj++){
      for(int l=0; l<3; l++){
        unitArray[ti][tj][l] = int(unitArray[ti][tj][l] + h(sqrt(sq(i-ti)+sq(j-tj)), t) * (inputArray[l] - unitArray[ti][tj][l]));
      }
    }
  }
}

// h
float h(float d, int t){
  float sigma = 1 - t/T;
  return 1 * exp(-sq(d)/(2 * sq(sigma)));
}