import de.bezier.data.sql.SQLite;
SQLite db;

PImage mapImage;
PImage sakura;

int flag = 0;
int count = 0;

int [] savecount = new int [47];
float [] sakura400 = new float [47];
float [] sakura600 = new float [47];
int [] sakuratiru = new int [47];

int [] arrayX = new int [47];
int [] arrayY = new int [47];

float [][] arrayHighest = new float [47][601];
float [][] arrayAverage = new float [47][601];
int [][] arrayYear = new int [47][601];
int [][] arrayMonth = new int [47][601];
int [][] arrayDay = new int [47][601];

void setup() {
  size( 700, 755 );
  frameRate(4);
  mapImage = loadImage( "japan_map.gif" );
  sakura = loadImage("sakura.png");
  db = new SQLite( this, "data/weather.db" );
  if ( db.connect() ) {
    db.query( "select x, y from prefecture_table;" );    
    int x=0;
    while ( db.next () ) {
      arrayX[x] = db.getInt("x");
      arrayY[x] = db.getInt("y");
      x++;
    }

    db.query( "select prefecture_id, year, month, day, highest, lowest from weather_table where year>=2005 and year<=2009 and month>=2 and month<=5;" );

    for (int i=0; i<47; i++) {
      for (int j=0; j<601; j++) {
        db.next ();
        if (db.getInt("prefecture_id")==i+1) {
          arrayHighest[i][j] = db.getFloat("highest");
          arrayAverage[i][j] = (db.getFloat("highest")+db.getFloat("lowest"))/2;
          arrayYear[i][j] = db.getInt("year");
          arrayMonth[i][j] = db.getInt("month");
          arrayDay[i][j] = db.getInt("day");
        } else {
          break;
        }
      }
    }
  }
}

void draw() {
  //println(arrayYear[46][500]+"/"+arrayMonth[46][500]+"/"+arrayDay[46][500]);
  //println(arrayHighest[46][500]+","+arrayAverage[46][500]);
  image( mapImage, 0, 0 );

  fill(0);
  textSize(20);
  text("Forecast of Flowering Time", 50, 50);
  noFill();
  rect(70, 70, 50, 20);
  rect(125, 70, 50, 20);
  rect(180, 70, 50, 20);
  rect(235, 70, 50, 20);
  rect(290, 70, 50, 20);
  fill(0);
  textSize(11);
  text("2005", 80, 85);
  text("2006", 135, 85);
  text("2007", 190, 85);
  text("2008", 245, 85);
  text("2009", 300, 85);
  textSize(20);
  text(arrayYear[0][count]+"/"+arrayMonth[0][count]+"/"+arrayDay[0][count], 50, 150);
  textSize(11);
  if (flag==0) {
    fill(255, 0, 0);
    rect(70, 70, 50, 20);
    fill(255);
    text("2005", 80, 85);
    if (count>117) {
      for (int i=0; i<47; i++) {
        savecount[i]=0;
        sakura400[i] = 0;
        sakura600[i] = 0;
        sakuratiru[i] = 0;
      }
      count=0;
    }
  } else if (flag==1) {
    fill(255, 0, 0);
    rect(125, 70, 50, 20);
    fill(255);
    text("2006", 135, 85);
    if (count>237) {
      for (int i=0; i<47; i++) {
        savecount[i]=0;
        sakura400[i] = 0;
        sakura600[i] = 0;
        sakuratiru[i] = 0;
      }
      count=118;
    }
  } else if (flag==2) {
    fill(255, 0, 0);
    rect(180, 70, 50, 20);
    fill(255);
    text("2007", 190, 85);
    if (count>357) {
      for (int i=0; i<47; i++) {
        savecount[i]=0;
        sakura400[i] = 0;
        sakura600[i] = 0;
        sakuratiru[i] = 0;
      }
      count=238;
    }
  } else if (flag==3) {
    fill(255, 0, 0);
    rect(235, 70, 50, 20);
    fill(255);
    text("2008", 245, 85);
    if (count>478) {
      for (int i=0; i<47; i++) {
        savecount[i]=0;
        sakura400[i] = 0;
        sakura600[i] = 0;
        sakuratiru[i] = 0;
      }
      count=358;
    }
  } else if (flag==4) {
    fill(255, 0, 0);
    rect(290, 70, 50, 20);
    fill(255);
    text("2009", 300, 85);
    if (count>596) {
      for (int i=0; i<47; i++) {
        savecount[i]=0;
        sakura400[i] = 0;
        sakura600[i] = 0;
        sakuratiru[i] = 0;
      }
      count=479;
    }
  }
  for (int i=0; i<47; i++) {
    sakura400[i] += arrayAverage[i][count];
    sakura600[i] += arrayHighest[i][count];
    if (sakura400[i] >= 400 && sakura600[i] >= 600) {
      sakuratiru[i] += 1;
      if (sakuratiru[i] < 15) {
        image(sakura, arrayX[i]-15, arrayY[i]-15, 25, 25);
      } else {
        fill(222, 56, 56);
        textSize(14);
        text(arrayMonth[0][savecount[i]]+"/"+arrayDay[0][savecount[i]], arrayX[i]-10, arrayY[i]);
      }
    } else {
      savecount[i] ++;
    }
    fill(255, 0, 0);
  }
  count++;


  /*
   fill( 255, 255, 0 );
   for ( int i=0; i<arrayX.length; i++ ) {
   ellipse( arrayX[i], arrayY[i], 20, 20 );
   }
   */
}

void mousePressed() {
  for (int i=0; i<47; i++) {
    savecount[i]=0;
    sakura400[i] = 0;
    sakura600[i] = 0;
    sakuratiru[i] = 0;
  }
  if (mouseX>=70 && mouseX<=120 && mouseY>=70 && mouseY<=90) {
    flag=0;
    count=0;
  } else if (mouseX>=125 && mouseX<=175 && mouseY>=70 && mouseY<=90) {
    flag=1;
    count=118;
  } else if (mouseX>=180 && mouseX<=230 && mouseY>=70 && mouseY<=90) {
    flag=2;
    count=238;
  } else if (mouseX>=235 && mouseX<=285 && mouseY>=70 && mouseY<=90) {
    flag=3;
    count=358;
  } else if (mouseX>=290 && mouseX<=340 && mouseY>=70 && mouseY<=90) {
    flag=4;
    count=479;
  }
}