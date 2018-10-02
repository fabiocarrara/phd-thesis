unitsize(.8cm);
texpreamble("\renewcommand{\rmdefault}{\sfdefault}");
texpreamble("\newcommand{\x}{{\mkern-2mu\times\mkern-2mu}}");
texpreamble("\newcommand{\p}{{\mkern-2mu+\mkern-2mu}}");

real w = .8;
real h = 5;
real wgap = .5;

real full_w = w + wgap;

void layer(string lab="", int l, bool bg=true, bool ar=true) {

    // box start (BL) and end (TR)
    pair start = (l * full_w, 0);
    pair end = start + (w, h);

    // layer label
    // lab = "\textsc{" + lab + "}";
    // lab = replace(lab, "x", "\times");
    // lab = "$" + lab + "$";
    label(rotate(90) * lab, (start + end) / 2);

    // output arrow
    if (ar) {
        pair arrowStart = start + (w, h/2);
        pair arrowEnd = start + (full_w, h/2);
        draw(arrowStart -- arrowEnd, arrow=Arrow(TeXHead));
    }

    if (bg) {
        pen p = gray(0.95);
        if ( (find(lab, "conv") >= 0) || (find(lab, "fc") >= 0) )
            p = mediumgray;
        fill(box(start, end), p);
    }
}

void net(string[] net) {
    int i = 0;
    layer(net[i], 0, false);
    for (i = 1; i < net.length - 1; ++i)
        layer(net[i], i);
    layer(net[i], net.length - 1, false, false);
}

string[] malexnet = new string[] {
    "input $224{\x}224{\x}3$",
    "conv $11{\x}11/4\,(16)$",
    "ReLU",
    "LRN",
    "maxpool $3{\x}3/2$",
    "conv $5{\x}5\,(20)$",
    "ReLU",
    "LRN",
    "maxpool $3{\x}3/2$",
    "conv $3{\x}3\,(30)$",
    "ReLU",
    "maxpool $3{\x}3/2$",
    "fc $(48)$",
    "ReLU",
    "fc $(2)$",
    "softmax",
    "vacant/occupied scores"
};

net(malexnet);

