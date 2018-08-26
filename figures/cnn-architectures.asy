unitsize(.8cm);
texpreamble("\renewcommand{\rmdefault}{\sfdefault}");

real w = 5;
real h = .8;
real hgap = .5;
real wgap = .8;

real n = 0;

void layer(string lab="", int l, bool residual=false) {

    // box start (BL) and end (TR)
    pair start = (n * (w + wgap), -l * (h + hgap));
    pair end = start + (w, h);

    // layer label
    // lab = replace(lab, "x", "$\times$");
    label(lab, (start + end) / 2);

    // output arrow
    pair arrowStart = start + (w/2, 0);
    pair arrowEnd = start + (w/2, -hgap);
    draw(arrowStart -- arrowEnd, arrow=Arrow(TeXHead));

    if (l > 0)
        fill(box(start, end), mediumgray);

    if (residual) {
        real central_x = w/2;
        real gap_y = h + hgap;
        real gap_x = w + wgap;
        
        pair aStart = (central_x, -hgap / 2 - .1);
        pair aMid = aStart + (w/2 + 0.5*wgap, -hgap/2 - h/2);
        pair aEnd = (central_x, -1.5*hgap - h + .1);

        path res = aStart{right}
                .. {E}(0.7 * (aMid.x - aStart.x) + aStart.x, aStart.y)
                .. aMid
                .. (0.7 * (aMid.x - aEnd.x) + aEnd.x, aEnd.y){W}
                .. {left}aEnd;
                   
        draw(shift(start) * shift(0, gap_y) * res, arrow=Arrow(TeXHead));
    }

    // if find(conv) colour .. etc
}

void net(string[] net, string name="", bool[] residual = new bool[]{}) {
    pair labelpos = (n * (w + wgap) + w / 2, hgap + h);
    name = "\textbf{" + name + "}";
    label(name, labelpos);
    for (int i = 0; i < net.length; ++i) {
        bool res = (residual.length > 0) ? residual[i] : false;
        layer(net[i], i, res);
    }
    
    ++n;
}

string[] alexnet = new string[] {
    "input 224x224x3",
    "conv 11x11/4 (96)",
    "maxpool 3x3/2",
    "conv 5x5+2 (256)",
    "maxpool 3x3/2",
    "conv 3x3+1 (384)",
    "conv 3x3+1 (384)",
    "conv 3x3+1 (256)",
    "maxpool 3x3/2",
    "fc (4096)",
    "fc (4096)",
    "fc (1000)"
};

string[] overfeat = new string[] {
    "input 224x224x3",
    "conv 11x11/4 (96)",
    "maxpool 3x3/2",
    "conv 5x5+2 (256)",
    "maxpool 3x3/2",
    "conv 3x3+1 (384)",
    "conv 3x3+1 (384)",
    "conv 3x3+1 (256)",
    "maxpool 3x3/2",
    "fc (4096)",
    "fc (4096)",
    "fc (1000)"
};

string[] resnet34 = new string[] {
    "input 224x224x3",
    "conv 7x7/2 (64)",
    "maxpool 3x3/2",
    "conv 3x3+1 (64)", // check padding
    "conv 3x3+1 (64)",
    "conv 3x3+1 (64)",
    "conv 3x3+1 (64)",
    "conv 3x3+1 (64)",
    "conv 3x3+1 (64)",
    "conv 3x3+1/2 (128)",
    "conv 3x3+1 (128)",
    "conv 3x3+1 (128)",
    "conv 3x3+1 (128)",
    "conv 3x3+1 (128)",
    "conv 3x3+1 (128)",
    "conv 3x3+1 (128)",
    "conv 3x3+1 (128)",
    "conv 3x3+1/2 (256)",
    "conv 3x3+1 (256)",
    "conv 3x3+1 (256)",
    "conv 3x3+1 (256)",
    "conv 3x3+1 (256)",
    "conv 3x3+1 (256)",
    "conv 3x3+1 (256)",
    "conv 3x3+1 (256)",
    "conv 3x3+1 (256)",
    "conv 3x3+1 (256)",
    "conv 3x3+1 (256)",
    "conv 3x3+1 (256)",
    "conv 3x3+1/2 (512)",
    "conv 3x3+1 (512)",
    "conv 3x3+1 (512)",
    "conv 3x3+1 (512)",
    "conv 3x3+1 (512)",
    "conv 3x3+1 (512)",
    "global avgpool",
    "fc (1000)"
};

bool[] residual = array(resnet34.length, true);
int[] notRes = new int[] {0,1,2,9,17,29,34,35,36};
for (int i: notRes) { residual[i] = false; }


net(alexnet, "AlexNet (2012)");
net(overfeat, "OverFeat ()");
net(resnet34, "ResNet-34 ()", residual=residual);

