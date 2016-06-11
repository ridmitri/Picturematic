/* Build system Processing */
/* 300 pictures 1280x720 24fps Finished in 559.2s -> 46 sec movie */

boolean saveIt = true;

String dataName = "matic_";

// set manually the number of pictures loading from ./data
int dataCount = 300;
int nfIndex = 3;

// opacity rate
int delta = 8;
int alpha = 0;
int index = 0;

PImage[] playlist = new PImage[dataCount];

void setup() {
	size(1280, 720);
	smooth();
	frameRate(24);

	for (int i = 0; i < playlist.length; i++ ) {
		playlist[i] = loadImage(dataName + nf(i + 1, nfIndex) + ".png");
	}
}

void draw() {
	alpha += delta;

	// set peak value depending on number of layers to print
	int peak = int(255 / 8);
	int cycle = cycle(alpha, peak);

	// printing
	layer(alpha + peak * (7 - cycle), index + cycle + 0);
	layer(alpha + peak * (6 - cycle), index + cycle + 1);
	layer(alpha + peak * (5 - cycle), index + cycle + 2);
	layer(alpha + peak * (4 - cycle), index + cycle + 3);		
	layer(alpha + peak * (3 - cycle), index + cycle + 4);
	layer(alpha + peak * (2 - cycle), index + cycle + 5);
	layer(alpha + peak * (1 - cycle), index + cycle + 6);
	layer(alpha + peak * (0 - cycle), index + cycle + 7);		

	// prepare the next cycle
	if (alpha > 255 - delta) {
		println("NEXT-INDEX: "+ index + "; ALPHA: " + alpha);
		alpha = delta;
		index += 8;
		if (index + 8 - dataCount >= 0) {
			println("FINAL-INDEX: "+ index + "; ALPHA: " + alpha);
			index = 0;
			if (saveIt) {
				exit();
			}
		}
	}
	
	if (saveIt) {
		save("generated/picturematic_" + nf(frameCount, 5) + ".png");
	}
}

// counts number of cycle depending on peak threshold
int cycle(int alpha, int peak) {
	return (alpha - (alpha % peak)) / peak;
}

// prints layer with alpha image
void layer(int a, int idx) {
	tint(255, a);

	if (idx - dataCount < 0) {
		println("idx: " + idx + "; a: " + a + "; idx - dataCount: " + (idx - dataCount));
		image(playlist[idx], 0, 0);
	}
}
