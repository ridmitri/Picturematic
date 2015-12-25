/* Build system Processing */
int minutes = 1;
boolean saveIt = false;
/* pictures per second */

String dataName = "matic_";
int dataCount = 200;
int nfIndex = 3;

int alpha;
int _alpha_64;
int _alpha_128;
int _alpha_192;
int _alpha_254;

int index = 1;
int delta;
Boolean trigger = true;

PImage[] playlist = new PImage[dataCount];


void setup() {
	//size(360, 240);
	size(720, 480);
	smooth();
    frameRate( 12 );

    for (int i = 0; i < dataCount; i++ ) {
    	playlist[i] = loadImage(dataName + nf(i + 1, nfIndex) + ".png");
    }
}

void draw() {
	println("index: "+index + "; alpha: " + alpha + "; dataCount - 1: "+(dataCount-1));
	delta = int(random(7, 11));
	alpha+=delta;

	if (alpha > 250) {
		alpha = 0;
		index+=4;

		// loop/exit
		if (index + 4 >= dataCount-1) {
			index = 0;
			if (saveIt) {
				exit();
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
		image(playlist[idx - (dataCount - 1)], 0, 0);	
	} else {
		image(playlist[idx], 0, 0);	
	}
}

void mousePressed() {
	println("mousePressed");
}
