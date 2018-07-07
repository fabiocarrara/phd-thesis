unitsize(1cm);
import three;

// defaultpen(fontsize(8pt));
currentprojection = oblique;

triple wO = (4,2,2);
triple yO = (7,1,1);

real[][] x = {{0,0,0,0,0},
              {0,3,1,3,0},
              {0,1,0,1,0},
              {0,3,1,3,0},
              {0,0,0,0,0}};

real[][] w = {{0,1,0},
              {1,0,0},
              {2,1,0}};

real[][] conv2d(real[][] x, real[][] w) {
    int ySize = x.length - w.length + 1;
    real[][] y = new real[ySize][ySize];
    for (int u = 0; u < ySize; ++u)
        for (int v = 0; v < ySize; ++v) {
            y[u][v] = 0;
            for (int i = 0; i < 3; ++i)
                for (int j = 0; j < 3; ++j)
                    y[u][v] += x[i+u][j+v] * w[i][j];
        }

    return y;
}

real[][] y = conv2d(x, w);

void drawPlane(real[][] map, triple origin=O) {
    triple txt_xyz=(0,.5,.5); // (0, 0.68, 0.93);

    for (int n = 0; n <= map.length; ++n) {
        draw(shift(origin) * shift(0,n,0) * zscale3(map.length) * (O--Z));
        draw(shift(origin) * shift(0,0,n) * yscale3(map.length) * (O--Y));
    }

    for (int c = 0; c < map.length; ++c) {
        for (int r = 0; r < map.length; ++r) {
            triple pos = r*Z + c*Y + txt_xyz + origin;
            string str = "$" + ((string) map[r][c]) + "$";
            label(str, pos);
        }
    }
}

// DIMENSION LABELS
void dimLabel(triple s, triple e, triple o, string l, triple disp, triple txtdisp, triple N) {
    s += disp;
    e += disp;
    path3 p = shift(o + disp) * (s -- e);
    draw(p, arrow=Arrows3(TeXHead2(normal=N), emissive(black)));
    // triple m = 0.5 (s+e) + txtdisp;
    label(Label(l, position=MidPoint, align=txtdisp), p);
}

// INPUT PLANE
draw(shift(0,2,2) * scale(1, w.length, w.length) * surface(O--Y--(Z+Y)--Z--cycle), surfacepen=emissive(gray(0.7)));
drawPlane(x);
dimLabel(O, x.length*Z, O, "$W$", -0.15Y, -2Y-Z, X); // W
dimLabel(x.length*Z, x.length*(Y+Z), O, "$H$", -0.12X, -X, Z); // H

// WEIGHTS PLANE
draw(shift(wO) * scale(1, w.length, w.length) * surface(O--Y--(Z+Y)--Z--cycle), surfacepen=emissive(gray(0.6)));
drawPlane(w, wO);
dimLabel(O, w.length*Z, wO, "$K_2$", -0.15Y, -2Y-Z, X); // K_2
dimLabel(w.length*Z, w.length*(Y+Z), wO, "$K_1$", -0.12X, -X+Y, Z); // K_1


// OUTPUT PLANE
draw(shift(yO) * scale(1, y.length, y.length) * surface(O--Y--(Z+Y)--Z--cycle), surfacepen=emissive(white));
drawPlane(y, yO);
dimLabel(O, y.length*Z, yO, "$W'$", -0.15Y, -2Y-Z, X); // W'
dimLabel(y.length*Z, y.length*(Y+Z), yO, "$H'$", -0.12X, -X, Z); // H'

// DASHED LINES
draw(2Z+2Y--      wO--2Z+2Y+yO, dashed); // bottom-right
draw(5Z+2Y--   3Z+wO--3Z+2Y+yO, dashed); // bottom-left
draw(2Z+5Y--   3Y+wO--2Z+3Y+yO, dashed); // top-right
draw(5Z+5Y--3Z+3Y+wO--3Z+3Y+yO, dashed); // top-left

// PLANE LABELS
label("$\mathbf{x}$", (0, x.length + 1, (x.length / 2)));
label("$\mathbf{w}$", (0, w.length + 1.5, (w.length / 2)) + wO);
label("$\mathbf{y}$", (0, y.length + 1.5, (y.length / 2)) + yO);

