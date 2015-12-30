/* Build system Processing */
int minutes = 1;
boolean saveIt = false;
/* pictures per second */

String dataName = "matic_";
int dataCount = 32;
int nfIndex = 3;

int alpha;
int index = 1;

boolean trigger = true;
int flow = 1;

PImage[] playlist = new PImage[dataCount];

void setup() {
	// size(360, 240);
	size(720, 480);
	smooth();
    frameRate( 16 );

    for (int i = 0; i < dataCount; i++ ) {
    	playlist[i] = loadImage(dataName + nf(i + 1, nfIndex) + ".png");
    }
}

void draw() {
	println("-------");
	println("index: "+index + "; flow: " + flow + "; dataCount: "+dataCount + "; alpha: " + alpha);
	alpha+=int(random(11, 13));

	if (alpha > 250) {
		alpha = 0;

		if (flow == 1) {
			index+=4;
			if (index + 6 >= dataCount-1) {
				// index = dataCount-1;
				flow = -1;
				if (saveIt) {
					exit();
				}
			}
		} else {
			index-=4;
			
			if (index - 6 < 0) {
				// index = 0;
				flow = 1;
				if (saveIt) {
					exit();
				}
			}		
		}
	}

	if (alpha < 64) {
		layer(alpha + 64 + 64 + 64, index);
		layer(alpha + 64 + 64, index + 1 * flow);
		layer(alpha + 64, index + 2 * flow);
		layer(alpha, index + 3 * flow);		
	}
	else if (alpha >= 64 && alpha < 128) {
		layer(alpha + 64 + 64, index + 1 * flow);		
		layer(alpha + 64, index + 2 * flow);
		layer(alpha, index + 3 * flow);
		layer(alpha - 64, index + 4 * flow);
	}
	else if (alpha >= 128 && alpha < 192) {
		layer(alpha + 64, index + 2 * flow);
		layer(alpha, index + 3 * flow);		
		layer(alpha - 64, index + 4 * flow);
		layer(alpha - 64 - 64, index + 5 * flow);
	}
	else if (alpha >= 192 && alpha < 250) {
		layer(alpha, index + 3 * flow);
		layer(alpha - 64, index + 4 * flow);
		layer(alpha - 64 - 64, index + 5 * flow);
		layer(alpha - 64 - 64 - 64, index + 6 * flow);
	}

	if (saveIt) {
		println("frameRate * 60 * minutes: "+frameRate * 60 * minutes);
		save("frames/matic_" + nf(frameCount, 5) + ".png");
	}
}

void layer(int a, int idx) {
	println("idx: "+idx + "; a: " + a + "; idx - dataCount: " + (idx - dataCount));
	tint(255, a); // 127
	image(playlist[idx], 0, 0);
	// if (idx >= dataCount - 1) {
	// 	println("OverIndex: "+idx);
	// 	image(playlist[dataCount - 1], 0, 0);	
	// } else if (idx < 0) {
	// 	println("LowIndex: "+idx);
	// 	image(playlist[0], 0, 0);
	// } else {
	// 	image(playlist[idx], 0, 0);
	// }
}

void mousePressed() {
	println("mousePressed");
}
