unitsize(0.75cm);
settings.render = 16; // TODO render 0 not showing box lines..
import three;

currentprojection = oblique;

triple xO = O;
triple wO = (9,-0.5,3);
triple yO = (16,0,0);

int xSize = 5; int xDepth = 3;
int wSize = 2; int wDepth = 3;
int ySize = xSize - wSize + 1; int yDepth = 4;

triple x2O = (0, xSize - wSize, xSize - wSize);
triple w2O = wO + (0,6,0);
triple y2O = yO + (0, ySize - 1, ySize - 1);

triple x = (xDepth, xSize, xSize);
triple w = (wDepth, wSize, wSize);
triple y = (yDepth, ySize, ySize);
triple y2 = (yDepth, 1, 1);

void volume(triple origin, triple sizes, material pen) {
    draw(box(origin, origin + sizes));
    draw(shift(origin) * scale(sizes.x, sizes.y, sizes.z) * unitcube, surfacepen=pen);
}

// INPUT VOLUMES
volume(O + x2O, w, emissive(gray(0.6)));
volume(O, x, emissive(gray(0.7)));

// WEIGHTS VOLUMES
volume(wO, w, emissive(gray(0.6))); // bottom
volume(w2O, w, emissive(gray(0.6))); // top

// OUTPUT VOLUME
volume(yO, y, emissive(white));
volume(y2O, y2, emissive(white));

// DASHED LINES
// X -> W bottom
pen conn = dashed + gray;
draw(x2O + (xDepth,     0,     0) -- wO, conn); // bottom-right
draw(x2O + (xDepth, wSize,     0) -- wO + (0, wSize,     0), conn); // top-right
draw(x2O + (xDepth,     0, wSize) -- wO + (0,     0, wSize), conn); // bottom-left
draw(x2O + (xDepth, wSize, wSize) -- wO + (0, wSize, wSize), conn); // top-right
// X -> W top
draw(x2O + (xDepth,     0,     0) -- w2O, conn); // bottom-right
draw(x2O + (xDepth, wSize,     0) -- w2O + (0, wSize,     0), conn); // top-right
draw(x2O + (xDepth,     0, wSize) -- w2O + (0,     0, wSize), conn); // bottom-left
draw(x2O + (xDepth, wSize, wSize) -- w2O + (0, wSize, wSize), conn); // top-right
// W bottom -> Y
draw(wO + (wDepth,     0,     0) -- y2O + (0, 0, 0), conn); // bottom-right
draw(wO + (wDepth, wSize,     0) -- y2O + (0, 1, 0), conn); // top-right
draw(wO + (wDepth,     0, wSize) -- y2O + (0, 0, 1), conn); // bottom-left
draw(wO + (wDepth, wSize, wSize) -- y2O + (0, 1, 1), conn); // top-right
// W top -> Y
draw(w2O + (wDepth,     0,     0) -- y2O + (yDepth, 0, 0), conn); // bottom-right
draw(w2O + (wDepth, wSize,     0) -- y2O + (yDepth, 1, 0), conn); // top-right
draw(w2O + (wDepth,     0, wSize) -- y2O + (yDepth, 0, 1), conn); // bottom-left
draw(w2O + (wDepth, wSize, wSize) -- y2O + (yDepth, 1, 1), conn); // top-right

// DOTS
dot((wO.x + wDepth/2, (w2O.y * 0.25 + (wO.y + wSize) * (1 - 0.25)), 4));
dot((wO.x + wDepth/2, (w2O.y * 0.45 + (wO.y + wSize) * (1 - 0.45)), 4));
dot((wO.x + wDepth/2, (w2O.y * 0.65 + (wO.y + wSize) * (1 - 0.65)), 4));

// VOLUME LABELS
label("$\mathbf{x}$", ((xDepth / 2), xSize + 3, (xSize / 2)));
label("$\mathbf{w}$", ((wDepth / 2), wSize + 1.5, (wSize / 2)) + w2O);
label("$\mathbf{y}$", ((yDepth / 2), ySize + 3.5, (ySize / 2)) + yO);

// FILTER LABELS
label("filter $1$", ((wDepth / 2) + 0.2, (wSize / 2), wSize + 1) + w2O);
label("filter $K$", ((wDepth / 2) + 0.3, (wSize / 2), wSize + 1) + wO);

// DIMENSION LABELS
void dimLabel(triple s, triple e, triple o, string l, triple disp, triple txtdisp, triple N) {
    s += disp;
    e += disp;
    path3 p = shift(o + disp) * (s -- e);
    draw(p, arrow=Arrows3(TeXHead2(normal=N), emissive(black)));
    // triple m = 0.5 (s+e) + txtdisp;
    label(Label(l, position=MidPoint), p);
}

// INPUT LABELS
dimLabel((0, 0, xSize), (xDepth, 0, xSize), O, "$C$", -0.3Y, -0.5Y, Z);
dimLabel((xDepth, 0, xSize), (xDepth, 0, 0), O, "$W$", (0.2, -0.2, 0), X, X+Y);
// dimLabel((0, 0, xSize), (0, xSize, xSize), O, "$H$", -0.3X, -0.6X, Z);
dimLabel((xDepth, 0, 0), (xDepth, xSize, 0), O, "$H$", 0.3X, 0.6X, Z);

// FILTER LABELS
dimLabel((0, 0, wSize), (wDepth, 0, wSize), w2O, "$C$", -0.3Y, -0.5Y, Z);
dimLabel((wDepth, 0, wSize), (wDepth, 0, 0), w2O, "$K_2$", (0.2, -0.2, 0), X, X+Y);
dimLabel((wDepth, 0, 0), (wDepth, wSize, 0), w2O, "$K_1$", 0.3X, 0.6X, Z);

// OUTPUT LABELS
dimLabel((0, 0, ySize), (yDepth, 0, ySize), yO, "$K$", -0.3Y, -0.5Y, Z);
dimLabel((yDepth, 0, ySize), (yDepth, 0, 0), yO, "$W'$", (0.2, -0.2, 0), X, X+Y);
dimLabel((yDepth, 0, 0), (yDepth, ySize, 0), yO, "$H'$", 0.3X, 0.6X, Z);