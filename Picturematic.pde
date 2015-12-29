/* Build system Processing */
int minutes = 1;
boolean saveIt = false;
/* pictures per second */

String dataName = "matic_";
int dataCount = 16;
int nfIndex = 3;

int alpha;
int index = 1;

Boolean trigger = true;
Boolean rewind = false;

PImage[] playlist = new PImage[dataCount];

void setup() {
	size(360, 240);
	//size(720, 480);
	smooth();
    frameRate( 8 );

    for (int i = 0; i < dataCount; i++ ) {
    	playlist[i] = loadImage(dataName + nf(i + 1, nfIndex) + ".png");
    }
}

void draw() {
	println("-------");
	println("index: "+index + "; alpha: " + alpha + "; dataCount - 1: "+(dataCount-1));
	alpha+=int(random(11, 13));

	if (alpha > 250) {
		alpha = 0;
		if (!rewind) {
			index+=4;	
			if (index + 6 >= dataCount-1) {
				index = dataCount-1;
				rewind = true;
				if (saveIt) {
					exit();
				}
			}
		} else {
			index-=4;
			if (index - 6 < 0) {
				index = 0;
				rewind = false;
				if (saveIt) {
					exit();
				}
			}			
		}
	}

	if (alpha < 64) {
		layer(alpha + 64 + 64 + 64, index);
		layer(alpha + 64 + 64, index + 1);
		layer(alpha + 64, index + 2);
		layer(alpha, index + 3);		
	}
	else if (alpha >= 64 && alpha < 128) {
		layer(alpha + 64 + 64, index + 1);		
		layer(alpha + 64, index + 2);
		layer(alpha, index + 3);
		layer(alpha - 64, index + 4);
	}
	else if (alpha >= 128 && alpha < 192) {
		layer(alpha + 64, index + 2);
		layer(alpha, index + 3);		
		layer(alpha - 64, index + 4);
		layer(alpha - 64 - 64, index + 5);
	} 
	else if (alpha >= 192 && alpha < 255) {
		layer(alpha, index + 3);
		layer(alpha - 64, index + 4);
		layer(alpha - 64 - 64, index + 5);
		layer(alpha - 64 - 64 - 64, index + 6);
	}

	if (saveIt) {
		println("frameRate * 60 * minutes: "+frameRate * 60 * minutes);
		save("frames/matic_" + nf(frameCount, 5) + ".png");
	}
}

void layer(int a, int idx) {
	println("idx: "+idx + "; a: " + a + "; idx - dataCount: " + (idx - dataCount));
	tint(255, a); // 127
	
	if (idx >= dataCount - 1) {
		image(playlist[dataCount - 1], 0, 0);	
	} else if (idx < 0) {
		image(playlist[0], 0, 0);
	} else {
		image(playlist[idx], 0, 0);
	}
}

void mousePressed() {
	println("mousePressed");
}
