/* Build system Processing */
int minutes = 1;
boolean saveIt = false;
/* pictures per second */
int delay = 0;
int drama = 0;

int period = 255;

String dataName = "matic_";
int dataCount = 41;
int nfIndex = 3;

PImage[] playlist = new PImage[dataCount];
int index = 0;

void setup() {
	size(720, 480);
	smooth();
    frameRate( 24 );

    for (int i = 0; i < dataCount; i++ ) {
    	playlist[i] = loadImage(dataName + nf(i + 1, nfIndex) + ".png");
    }
}

void draw() {

	if (frameCount == 1) {
		delay = millis();
	}

	drama = millis() - delay;
	index = int((drama/period) % dataCount);
	image(playlist[index], 0, 0);
	
	println("index: "+index);	
	println("255 - int( (millis() % period )): "+ (255 - int( (millis() % period ))));
	if (index + 1 == dataCount) {
		exit();
	}
	tint(255, 255 - int( (millis() % period )));
	image(playlist[index], 0, 0);
	

	if (saveIt && frameCount < frameRate * 60 * minutes) {
		println("frameRate * 60 * minutes: "+frameRate * 60 * minutes);
		save("frames/matic_" + nf(frameCount, 5) + ".png");
	}
}

void mousePressed() {
	println("mousePressed");
}
