unitsize(.8cm);
// texpreamble("\renewcommand{\rmdefault}{\sfdefault}");

path[] pic() {
    // path bbox = box((0, 0), (10, 10));
    // path mountains = 
    path p = (0,2) -- (0,0) -- (10,0) -- (10,4) --
             (7,6) -- (4,3) -- (3,4) -- (0,2) --
             (0,10) -- (10,10) -- (10,4);
    path c = circle((3, 7.5), 1);
    return new path[] {p, c};
}

real w = .8, wgap = .5;
real h = 5., hgap = 1.;

real full_w = w + wgap;
real full_h = h + hgap;

void layer(string lab="", int l, bool bg=true, bool ar=true) {

    // box start (BL) and end (TR)
    pair start = (l * full_w, 0);
    pair end = start + (w, h);

    // layer label
    // lab = "\textsc{" + lab + "}";
    // lab = replace(lab, "x", "\times");
    // lab = "$" + lab + "$";
    // label(rotate(90) * lab, (start + end) / 2);

    // output arrow
    if (ar) {
        pair arrowStart = start + (w, h/2);
        pair arrowEnd = start + (full_w, h/2);
        draw(arrowStart -- arrowEnd, arrow=Arrow(TeXHead));
    }

    if (bg) {
        pen p = gray(0.93);
        if ( (find(lab, "conv") >= 0) || (find(lab, "fc") >= 0) )
            p = mediumgray;
        fill(box(start, end), p);
    }
}

void net(string[] net) {
    for (int i = 0; i < net.length - 1; ++i) {
        layer(net[i], i);
    }
    layer(net[net.length - 1], net.length - 1, true, false);
}

string[] overfeat = new string[] {
    "conv $11{\x}11/4\,(96)$",
    "maxpool $2{\x}2/2$",
    "conv $5{\x}5/1\,(256)$",
    "maxpool $2{\x}2/2$",
    "conv $3{\x}3{\p}1\,(512)$",
    "conv $3{\x}3{\p}1\,(1024)$",
    "conv $3{\x}3{\p}1\,(1024)$",
    "maxpool $2{\x}2/2$",
    "fc $(3072)$",
    "fc $(4096)$",
    "fc $(1000)$"
};

// INPUT

real s = .7;
path[] img = shift(-s * (full_h + full_w), (1-s) * h/2) * scale(s * h / 10) * pic();
draw(img);
path imgAr = (-s * (full_h - h + full_w), h/2) -- (0, h/2);
draw(imgAr, arrow=ArcArrow);

// NET
net(overfeat);
real d = .5*w, nL = overfeat.length;
path bracket = (-d, h-d) -- (-d, h+d) -- (full_w * nL + d - wgap, h+d) -- (full_w * nL + d - wgap, h-d);
draw(bracket, L=Label("\sc CNN Classifier", align=N));

real netEndW = full_w * nL - wgap;

path netAr = (netEndW, h/2) -- (netEndW + 2*full_w, h/2);
draw(netAr, arrow=ArcArrow, L=Label(minipage("\centering predicted\\ class", 50), align=N));

path featAr = (full_w*8 - wgap/2, h/2) -- (full_w*8 - wgap/2, -wgap/2) -- (netEndW + full_w, -wgap/2) -- (netEndW + full_w, h/4) -- (netEndW + 2*full_w, h/4);
draw(featAr, arrow=ArcArrow);

// Detection
real detStartW = netEndW + 2*full_w;
real detW = 3*full_w;
real detEndW = detStartW + detW;

path bbox = box((detStartW, 0), (detStartW+detW, h));
label(minipage("\centering \sc kNN\\Scoring"), (detStartW + detW/2, .82*h));
draw(bbox);
// cylinder
real ch = .35*h;
real cw = .27;
path top = circle((0, ch), cw);
path left = (-cw, ch) -- (-cw, 0);
path right = (cw, ch) -- (cw, 0);
path bottom = arc((0, 0), cw, 0, -180);

path[] cyl = new path[] {top, left, right, bottom};
cyl = shift(detStartW + detW/2, .15*h) * xscale(5) * cyl;
draw(cyl);
label(minipage("\centering \sc Train\\Set"), (detStartW + detW/2, .28*h));

path detAr = (detEndW, h/2) -- (detEndW + w, h/2);
draw(detAr, arrow=ArcArrow, L=Label("score", position=EndPoint));

