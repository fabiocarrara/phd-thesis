unitsize(.8cm);
texpreamble("\renewcommand{\rmdefault}{\sfdefault}");
texpreamble("\newcommand{\x}{{\mkern-2mu\times\mkern-2mu}}");
texpreamble("\newcommand{\p}{{\mkern-2mu+\mkern-2mu}}");

real w = .8;
real h = 5;
real wgap = .5;
real hgap = 1;

real full_w = w + wgap;
real full_h = h + hgap;

void layer(string lab="", int l, int n, int skip=1, bool bg=true, bool ar=true) {

    // box start (BL) and end (TR)
    pair start = (l * full_w, n * full_h);
    pair end = start + (w, h);

    // layer label
    // lab = "\textsc{" + lab + "}";
    // lab = replace(lab, "x", "\times");
    // lab = "$" + lab + "$";
    label(rotate(90) * lab, (start + end) / 2);

    // output arrow
    if (ar) {
        pair arrowStart = start + (w, h/2);
        pair arrowEnd = start + (skip * full_w, h/2);
        draw(arrowStart -- arrowEnd, arrow=Arrow(TeXHead));
    }

    if (bg) {
        pen p = gray(0.95);
        if ( (find(lab, "conv") >= 0) || (find(lab, "fc") >= 0) )
            p = mediumgray;
        fill(box(start, end), p);
    }
}

void net(string[] net, int n) {
    int i, s;
    layer(net[i], 0, n, 1, false);
    for (i = 1; i < net.length - 1; ++i) {
        if (length(net[i]) == 0) continue;
        s = 1;
        while (length(net[i + s]) == 0) { ++s; }
        layer(net[i], i, n, s);
    }
    layer(net[i], net.length - 1, n, 1, false, false);
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
    "",
    "",
    "",
    "maxpool $3{\x}3/2$",
    "fc $(48)$",
    "ReLU",
    "",
    "",
    "",
    "",
    "fc $(2)$",
    "softmax",
    "vacant/occupied scores"
};

string[] alexnet = new string[] {
    "input $224{\x}224{\x}3$",
    "conv $11{\x}11/4\,(96)$",
    "ReLU",
    "LRN",
    "maxpool $3{\x}3/2$",
    "conv $5{\x}5{\p}2\,(256)$",
    "ReLU",
    "LRN",
    "maxpool $3{\x}3/2$",
    "conv $3{\x}3{\p}1\,(384)$",
    "ReLU",
    "conv $3{\x}3{\p}1\,(384)$",
    "ReLU",
    "conv $3{\x}3{\p}1\,(256)$",
    "maxpool $3{\x}3/2$",
    "fc $(4096)$",
    "ReLU",
    "DropOut $(p=0.5)$",
    "fc $(4096)$",
    "ReLU",
    "DropOut $(p=0.5)$",
    "fc $(1000)$",
    "softmax",
    "1000-class scores"
};

net(alexnet, 1);
net(malexnet, 0);

