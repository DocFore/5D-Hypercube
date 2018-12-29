Vector5D[] points = new Vector5D[32];

float angle = PI/720;
int u = 0;
float X = 1;
float Y = 1;
float Z = 1;
float W = sqrt(2)/4;
float U = sqrt(W)/2;

boolean IsFilming = false;
int mouse = 960;

void setup() {
  fullScreen(P3D);
  ortho();
  background(0);

  points[0]  = new Vector5D(-X, -Y, -Z, -W, -U);
  points[1]  = new Vector5D( X, -Y, -Z, -W, -U);
  points[2]  = new Vector5D( X, Y, -Z, -W, -U);
  points[3]  = new Vector5D(-X, Y, -Z, -W, -U);
  points[4]  = new Vector5D(-X, -Y, Z, -W, -U);
  points[5]  = new Vector5D( X, -Y, Z, -W, -U);
  points[6]  = new Vector5D( X, Y, Z, -W, -U);
  points[7]  = new Vector5D(-X, Y, Z, -W, -U);
  points[8]  = new Vector5D(-X, -Y, -Z, W, -U);
  points[9]  = new Vector5D( X, -Y, -Z, W, -U);
  points[10] = new Vector5D( X, Y, -Z, W, -U);
  points[11] = new Vector5D(-X, Y, -Z, W, -U);
  points[12] = new Vector5D(-X, -Y, Z, W, -U);
  points[13] = new Vector5D( X, -Y, Z, W, -U);
  points[14] = new Vector5D( X, Y, Z, W, -U);
  points[15] = new Vector5D(-X, Y, Z, W, -U);
  points[16] = new Vector5D(-X, -Y, -Z, -W, U);
  points[17] = new Vector5D( X, -Y, -Z, -W, U);
  points[18] = new Vector5D( X, Y, -Z, -W, U);
  points[19] = new Vector5D(-X, Y, -Z, -W, U);
  points[20] = new Vector5D(-X, -Y, Z, -W, U);
  points[21] = new Vector5D( X, -Y, Z, -W, U);
  points[22] = new Vector5D( X, Y, Z, -W, U);
  points[23] = new Vector5D(-X, Y, Z, -W, U);
  points[24] = new Vector5D(-X, -Y, -Z, W, U);
  points[25] = new Vector5D( X, -Y, -Z, W, U);
  points[26] = new Vector5D( X, Y, -Z, W, U);
  points[27] = new Vector5D(-X, Y, -Z, W, U);
  points[28] = new Vector5D(-X, -Y, Z, W, U);
  points[29] = new Vector5D( X, -Y, Z, W, U);
  points[30] = new Vector5D( X, Y, Z, W, U);
  points[31] = new Vector5D(-X, Y, Z, W, U);
}

void draw() {
  float Pangle = angle * u;
  u++;
  background(0);
  translate(width/2, height/2);
  float longitude = map(mouseY, 0, height, 0, PI);
  float magnitude = map(mouseX, 0, width, 0, 2*PI);
  rotateX(longitude); //PI/3 or longitude
  rotateZ(magnitude); //-PI/3 or magnitude


  PVector[] projectedPoints = new PVector[32];
  float distance = 2;
  int index = 0;

  for (Vector5D v : points) {
    Rotate rotation = new Rotate(Pangle);
    float[][] VectorIn5D = vec5DToMatrix(v);
    VectorIn5D = matmul(rotation.WU, VectorIn5D); //rotation au tour du 5ème axe

    float u = 1/(distance-VectorIn5D[4][0]);
    float[][] projectionU = {
      {u, 0, 0, 0, 0}, 
      {0, u, 0, 0, 0}, 
      {0, 0, u, 0, 0}, 
      {0, 0, 0, u, 0}
    };

    float[][] VectorIn4D = matmul(projectionU, VectorIn5D); //projection des points en 4d... pfff
    VectorIn4D = matmul(rotation.ZW, VectorIn4D);
    float w = 1/(distance-VectorIn4D[3][0]);

    float[][] projectionW = {
      {w, 0, 0, 0}, 
      {0, w, 0, 0}, 
      {0, 0, w, 0}, 
    };
    float[][] projected3D = matmul(projectionW, VectorIn4D); //projection 3D des points préalablement projetés en 4D... enfin ça devient comprehhénsible pour nous.
    PVector p = matrixTo3DVec(projected3D);
    p.mult(mouse);
    projectedPoints[index] = p;
    index++;
  }
  dessiner(projectedPoints);

  for (int j = 0; j< 4; j++) {
    int off = 8*j;
    for (int i = 0; i < 4; i++) {
      connect(off, i, (i+1) % 4, projectedPoints );
      connect(off, i+4, ((i+1) % 4)+4, projectedPoints);
      connect(off, i, i+4, projectedPoints);
    }
  }
  for (int i = 0; i < 8; i++) {
    connect(0, i, i + 8, projectedPoints);
  }

  for (int i = 0; i < 16; i++) {
    connect(0, i, i + 16, projectedPoints);
  }

  for (int i = 16; i < 24; i++) {
    connect(0, i, i + 8, projectedPoints);
  }
  if (u < 721 && IsFilming) {
    saveFrame("frames/###.png");
  }
}

void dessiner(PVector[] pointArray) {
  for (PVector v : pointArray) {
    stroke(255);
    strokeWeight(16);
    point(v.x, v.y, v.z);
  }
}

void connect(int offset, int i, int j, PVector[] v) {
  PVector a = v[i + offset];
  PVector b = v[j + offset];
  stroke(127);
  strokeWeight(4);
  line(a.x, a.y, a.z, b.x, b.y, b.z);
}

void mouseWheel(MouseEvent event) {
  mouse -= 10*event.getCount();
  println(mouse);
}
