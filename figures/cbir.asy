size(17cm);

import flowchart;

string [] off = {
    "Image Database",
    "Image Represent.",
    "Image Indexing",
    "Database Index"
};

string [] on = {
    "Query Formulation",
    "Query Represent.",
    "Image Scoring",
    "Rank"
};

Label [] offs = new Label[off.length];
Label [] ons = new Label[on.length];

for (int i = 0; i < off.length; ++i)
    offs[i] = minipage('\centering ' + off[i], 70);
for (int i = 0; i < off.length; ++i)
    ons[i] = minipage('\centering ' + on[i], 70);

real h = .6;

block b0 = roundrectangle(offs[0], (0, h));
block b1 = rectangle(offs[1], (1, h));
block b2 = rectangle(offs[2], (2, h));
block b3 = roundrectangle(offs[3], (3, h));

block a0 = roundrectangle(ons[0], (1, 0));
block a1 = rectangle(ons[1], (2, 0));
block a2 = rectangle(ons[2], (3, 0));
block a3 = roundrectangle(ons[3], (4, 0));

draw(a0);
draw(a1);
draw(a2);
draw(a3);

draw(b0);
draw(b1);
draw(b2);
draw(b3);

add(new void(picture pic, transform t) {
    blockconnector operator -- = blockconnector(pic,t);
    b0--Right--Right--Arrow--b1;
    b1--Right--Right--Arrow--b2;
    b2--Right--Right--Arrow--b3;

    b3--Down--Down--Arrow--a2;

    a0--Right--Right--Arrow--a1;
    a1--Right--Right--Arrow--a2;
    a2--Right--Right--Arrow--a3;
});

pair m = min(currentpicture, user=true);
pair M = max(currentpicture, user=true);

// DASHED
real disp = 0.075;
label(Label("\textsc{Off-line}", align=N+W), (M.x, h/2 + disp));
path onoff = (m.x, h/2) -- (M.x, h/2);
draw(onoff, dashed);
label(Label("\textsc{On-line}", align=S+E), (m.x, h/2 - disp));


/*
exit();


real w = 1.5 + sqrt(5), h = 1.5;
real wgap = 0.7, hgap = 2;

void block(string lab="", real cx=0, real cy=0, int adir=0) {
    pair O = (cx * (w + wgap), cy * (h + hgap));
    path border = shift(O) * box((0, 0), (w, h));
    draw(border);
    lab = '\centering ' + lab;

    label(minipage(lab, 70), O + (w/2, h/2));

    if (adir == 0) return;

    path arr;
    if (adir == 1)
        arr = (w, h/2) -- (w + wgap, h/2);
    if (adir == 2)
        arr = (w/2, 0) -- (w/2, -hgap);

    arr = shift(O) * arr;
    draw(arr, arrow=ArcArrow());
}

// OFFLINE
block("Image Database", 0, 1, 1);
block("Features Extractor", 1, 1, 1);
block("Image Indexing", 2, 1, 1);
block("Database Index", 3, 1, 2);

// ONLINE
block("Query Formulation", 1, 0, 1);
block("Feature Extractor", 2, 0, 1);
block("Image Scoring", 3, 0, 1);
block("Ranking", 4, 0);

// DASHED
label(Label("\textsc{Off-line}", align=N+E), (0, h + 0.6 * hgap));
pair m = max(currentpicture, user=true);
path onoff = (0, h + hgap/2) -- (m.x, h + hgap/2);
draw(onoff, dashed);
label(Label("\textsc{On-line}", align=S+E), (0, h + 0.4 * hgap));
*/