/* Build system Processing */

import java.io.File;

int minutes = 1;
boolean saveIt = false;
/* pictures per second */

String dataName = "matic_";
int dataCount = 13;
int nfIndex = 3;

int alpha;
int index = 1;

boolean trigger = true;
int flow = 1;

int layerCount = 4;

PImage[] playlist = new PImage[dataCount];

void setup() {
	size(480, 360);
	smooth();
	frameRate( 24 );

	for (int i = 0; i < playlist.length; i++ ) {
		playlist[i] = loadImage(dataName + nf(i + 1, nfIndex) + ".png");
	}
}

void draw() {
	alpha += int(random(11, 13));

	if (alpha > 255) {
		alpha = 0;

		index += 4;
		if (index + 6 >= dataCount - 1) {
			// index = dataCount-1;
			if (saveIt) {
				exit();
			}
		}
	}

	int peak = int(255 / 4);
	int cycle = cycle(alpha, peak);
	
	layer(alpha + peak * (0 - (2 + cycle)), index + cycle); // 192 | 255 - cycle
	layer(alpha + peak * (1 - (2 + cycle)), index + cycle + 1); // 128
	layer(alpha + peak * (3 - (2 + cycle)), index + cycle + 2); // 64
	layer(alpha + peak * (3 - (3 + cycle)), index + cycle + 3); // 0

	if (saveIt) {
		println("frameRate * 60 * minutes: " + frameRate * 60 * minutes);
		save("frames/matic_" + nf(frameCount, 5) + ".png");
	}
}

void layerZ(int alpha, int index, int z, int count) {
	int max = 255;
	int peak = int(max / count);
	int cycle = cycle(alpha, peak);

	if (z == 0) {
		
	}
}

int cycle(int alpha, int peak) {
	return (alpha - (alpha % peak)) / peak;
}

void layer(int a, int idx) {
	println("idx: " + idx + "; a: " + a + "; idx - dataCount: " + (idx - dataCount));
	tint(255, a); // 127
	image(playlist[idx], 0, 0);

	if (idx >= dataCount - 1) {
		println("OverIndex: " + idx);
		image(playlist[dataCount - 1], 0, 0);
	} else if (idx < 0) {
		println("LowIndex: " + idx);
		image(playlist[0], 0, 0);
	} else {
		image(playlist[idx], 0, 0);
	}
}

void mousePressed() {
	println("mousePressed");
}
