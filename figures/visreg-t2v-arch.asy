unitsize(.8cm);
usepackage("amsmath");
texpreamble("\renewcommand{\rmdefault}{\sfdefault}");

// TODO tune w,h
real w = 4.0, wgap = .45, w_c = w/2, W = w + wgap;
real h =  .8, hgap = .5 , h_c = h/2, H = h + hgap;

void layer(string s, pair o, pair d=(w, h)) {
    pair boxStart = (o.x - d.x/2, o.y);
    pair boxEnd = (o.x + d.x/2, o.y + d.y);
    path b = box(boxStart, boxEnd);
    fill(b, mediumgray);
    label(s, (boxStart + boxEnd)/2);
}

void arr(real length, real height=0, real x=0, Label L="") {
    pair start = (x, height);
    pair end = start + (0, length);
    draw(start -- end, arrow=ArcArrow, L=L);
}

// x
label("$\mathbf{x}$", (0, h_c));
arr(hgap, h);

// fc1
layer("fc [$\mathbf{W}_1, \mathbf{b}_1$]", (0, H));
arr(h, H+h, L="$\mathbf{z}$");

// fc2
layer("fc [$\mathbf{W}_2, \mathbf{b}_2$]", (0, H + 2*h));
arr(h, H+3*h, L="$\mathbf{y}$");

real w_loss_in = w/2 + 2*wgap;
// Loss
layer("$\mathcal{L}_\text{MSE}$", (w_loss_in/2, H+4*h), (w_loss_in + 4*wgap, h));

// y*
label("$\mathbf{y^\star}$", (w_loss_in, h_c));
arr(H+3*h, h, x=w_loss_in);


