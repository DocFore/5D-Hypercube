class Rotate {
  float angle;

  Rotate(float angle) {
    this.angle = angle;
    initialize();
  }
  
  float[][] XY = {
    {1, 0, 0, 0}, 
    {0, 1, 0, 0}, 
    {0, 0, 1, 0}, 
    {0, 0, 0, 1},
  };

  float[][] ZW = { //matrice de rotation autour des axes Z et W en 4 dimensions
    {1, 0, 0, 0}, 
    {0, 1, 0, 0}, 
    {0, 0, 1, 0}, 
    {0, 0, 0, 1},
  };

  float[][] WU = { //matrice de rotation autour des axes U et Z en 5 dimensions
    {1, 0, 0, 0, 0}, 
    {0, 1, 0, 0, 0}, 
    {0, 0, 1, 0, 0}, 
    {0, 0, 0, 1, 0}, 
    {0, 0, 0, 0, 1}
  };
  void initialize() {
    XY[0][0] = cos(angle);
    XY[1][0] = -sin(angle);
    XY[0][1] = sin(angle);
    XY[1][1] = cos(angle);
    
    ZW[2][2] = cos(angle);
    ZW[3][2] = -sin(angle);
    ZW[2][3] = sin(angle);
    ZW[3][3] = cos(angle);
    
    WU[3][3] = cos(angle);
    WU[4][3] = -sin(angle);
    WU[3][4] = sin(angle);
    WU[4][4] = cos(angle);
    
  }
}
