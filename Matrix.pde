//this code has been writen by Daniel Shiffman

float[][] vec4DToMatrix (Vector4D v) {
  float[][] m = new float[4][1];
  m[0][0] = v.x;
  m[1][0] = v.y;
  m[2][0] = v.z;
  m[3][0] = v.w;
  return m;
}

float[][] vec5DToMatrix (Vector5D v) {
  float[][] m = new float[5][1];
  m[0][0] = v.x;
  m[1][0] = v.y;
  m[2][0] = v.z;
  m[3][0] = v.w;
  m[4][0] = v.u;
  return m;
}

PVector matrixTo3DVec(float[][] m)
{
  PVector v = new PVector();
  v.x = m[0][0];
  v.y = m[1][0];
  v.z = m[2][0];
  return v;
}

float[][] matmul(float[][] a, Vector4D v){
  float[][] b = vec4DToMatrix(v);
  return matmul(a,b);
}

float[][] matmul(float[][] a, float[][] b) {
  int columnsA = a[0].length;
  int rowsA = a.length;
  int columnsB = b[0].length;
  int rowsB = b.length;

  if (columnsA != rowsB) {
    println(columnsA + "!=" + rowsB);
  }

  float[][] result = new float[rowsA][columnsB];

  for (int i = 0; i <rowsA; i++) {
    for (int j = 0; j < columnsB; j++) {
      
      float sum = 0;

      for (int k = 0; k < columnsA; k++) {
        sum += a[i][k] * b[k][j];
      }
      result[i][j] = sum;
    }
  }
  return result;
}

void logMatrix(float[][] m) {
  int cols = m[0].length;
  int rows = m.length;
  println(rows + "x" + cols);
  println("----------------");
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      print(m[i][j] + " ");
    }
    println();
  }
  println();
}
