unitsize(.8cm);
texpreamble("\renewcommand{\rmdefault}{\sfdefault}");
texpreamble("\newcommand{\x}{{\mkern-2mu\times\mkern-2mu}}");
texpreamble("\newcommand{\p}{{\mkern-2mu+\mkern-2mu}}");

real w = 5;
real h = .8;
real hgap = .5;
real wgap = .8;

real n = 0;

void layer(string lab="", int l, bool residual=false, int repeat=1) {

    // box start (BL) and end (TR)
    pair start = (n * (w + wgap), -l * (h + hgap));
    pair end = start + (w, h);

    // layer label
    // lab = "\textsc{" + lab + "}";
    // lab = replace(lab, "x", "\times");
    // lab = "$" + lab + "$";
    label(lab, (start + end) / 2);

    // output arrow
    pair arrowStart = start + (w/2, 0);
    pair arrowEnd = start + (w/2, -hgap);
    draw(arrowStart -- arrowEnd, arrow=Arrow(TeXHead));

    if (l > 0) {
        pen p = gray(0.95);
        if ( (find(lab, "conv") >= 0) || (find(lab, "fc") >= 0) )
            p = mediumgray;
        fill(box(start, end), p);
    }

    real central_x = w / 2;
    real gap_y = h + hgap;
    real gap_x = w + wgap;

    if (residual) {

        pair aStart = (central_x, -hgap / 2 - .1);
        pair aMid = aStart + (w/2 + 0.4*wgap, -hgap/2 - h/2) - (0, gap_y);
        pair aEnd = (central_x, -1.5*hgap - h + .1) - (0, 2*gap_y);

        path res = aStart{right}
                .. {E}(0.75 * (aMid.x - aStart.x) + aStart.x, aStart.y)
                .. aMid
                .. (0.75 * (aMid.x - aEnd.x) + aEnd.x, aEnd.y){W}
                .. {left}aEnd;

        draw(shift(start) * shift(0, gap_y) * res, arrow=Arrow(TeXHead));
    }

    if (repeat > 1) {
        pair b0 = (w + 0.45 * wgap, -hgap / 2 + .1) - (0, 2*gap_y);
        pair b1 = (w + 0.75 * wgap, -hgap / 2 + .1) - (0, 2*gap_y);
        pair b2 = (w + 0.75 * wgap, -1.5*hgap - h - .1) + (0, 2*gap_y);
        pair b3 = (w + 0.45 * wgap, -1.5*hgap - h - .1) + (0, 2*gap_y);
        path bracket = b0 -- b1 -- b2 -- b3;
        string lab = "$\times" + ((string) repeat) + "$";
        draw(shift(start) * shift(0, gap_y) * bracket, L=Label(lab, position=MidPoint, align=E));
    }
}

void net(string[] net, string name="", bool[] residual = new bool[]{}, int[] repeats = new int[]{}) {
    pair labelpos = (n * (w + wgap) + w / 2, hgap + h);
    name = "\textbf{" + name + "}";
    label(name, labelpos);
    for (int i = 0; i < net.length; ++i) {
        bool res = (residual.length > 0) ? residual[i] : false;
        int rep = (repeats.length > 0) ? repeats[i] : 1;
        layer(net[i], i, res, rep);
    }

    ++n;
}

string[] alexnet = new string[] {
    "input $224{\x}224{\x}3$",
    "conv $11{\x}11/4\,(96)$",
    "maxpool $3{\x}3/2$",
    "conv $5{\x}5{\p}2\,(256)$",
    "maxpool $3{\x}3/2$",
    "conv $3{\x}3{\p}1\,(384)$",
    "conv $3{\x}3{\p}1\,(384)$",
    "conv $3{\x}3{\p}1\,(256)$",
    "maxpool $3{\x}3/2$",
    "fc $(4096)$",
    "fc $(4096)$",
    "fc $(1000)$"
};

string[] overfeat = new string[] {
    "input $231{\x}231{\x}3$",
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

string[] vgg19 = new string[] {
    "input $224{\x}224{\x}3$",
    "conv $3{\x}3{\p}1\,(64)$",
    "conv $3{\x}3{\p}1\,(64)$",
    "maxpool $3{\x}3/2$",
    "conv $3{\x}3{\p}1\,(128)$",
    "conv $3{\x}3{\p}1\,(128)$",
    "maxpool $3{\x}3/2$",
    "conv $3{\x}3{\p}1\,(256)$",
    "conv $3{\x}3{\p}1\,(256)$",
    "conv $3{\x}3{\p}1\,(256)$",
    "conv $3{\x}3{\p}1\,(256)$",
    "maxpool $3{\x}3/2$",
    "conv $3{\x}3{\p}1\,(512)$",
    "conv $3{\x}3{\p}1\,(512)$",
    "conv $3{\x}3{\p}1\,(512)$",
    "conv $3{\x}3{\p}1\,(512)$",
    "maxpool $3{\x}3/2$",
    "conv $3{\x}3{\p}1\,(512)$",
    "conv $3{\x}3{\p}1\,(512)$",
    "conv $3{\x}3{\p}1\,(512)$",
    "conv $3{\x}3{\p}1\,(512)$",
    "maxpool $3{\x}3/2$",
    "fc $(4096)$",
    "fc $(4096)$",
    "fc $(1000)$"
};

string[] resnet34 = new string[] {
    "input $224{\x}224{\x}3$",
    "conv $7{\x}7/2\,(64)$",
    "maxpool $3{\x}3/2$",
    "conv $3{\x}3{\p}1\,(64)$", // x6
    "conv $3{\x}3{\p}1/2\,(128)$",
    "conv $3{\x}3{\p}1\,(128)$", // x7
    "conv $3{\x}3{\p}1/2\,(256)$",
    "conv $3{\x}3{\p}1\,(256)$", // x11
    "conv $3{\x}3{\p}1/2\,(512)$",
    "conv $3{\x}3{\p}1\,(512)$", // x5
    "global avgpool",
    "fc $(1000)$"
};

string[] resnet50 = new string[] {
    "input $224{\x}224{\x}3$",
    "conv $7{\x}7/2\,(64)$",
    "maxpool $3{\x}3/2$",
    "conv $1{\x}1\,(64)$",       //
    "conv $3{\x}3{\p}1\,(64)$",  // x3
    "conv $1{\x}1\,(256)$",      //

    "conv $1{\x}1\,(128)$",      //
    "conv $3{\x}3{\p}1\,(128)$", // x4
    "conv $1{\x}1\,(512)$",      //

    "conv $1{\x}1\,(256)$",      //
    "conv $3{\x}3{\p}1\,(256)$", // x6
    "conv $1{\x}1\,(1024)$",     //

    "conv $1{\x}1\,(512)$",      //
    "conv $3{\x}3{\p}1\,(512)$", // x3
    "conv $1{\x}1\,(2048)$",     //

    "global avgpool",
    "fc $(1000)$"
};

bool[] residual = array(resnet50.length, false);
int[] res = new int[] {3, 6, 9, 12};
for (int i: res) { residual[i] = true; }

int[] repeats = array(resnet50.length, 1);
repeats[4] = 3;
repeats[7] = 4;
repeats[10] = 6;
repeats[13] = 3;

net(alexnet, "AlexNet (2012)");
net(overfeat, "OverFeat (2013)");
net(vgg19, "VGG-19 (2014)");
// net(resnet34, "ResNet-34 ()", residual=residual);
net(resnet50, "ResNet-50 (2015)", residual=residual, repeats=repeats);