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
// fork
// arr(h, H+h, L="$\mathbf{z}$");
path f1 = (0, h + H) -- (0, 2*H);
path f2 = (0, 2*H) -- (- W/2, 2*H) -- (- W/2, hgap + 2*H);
path f3 = (0, 2*H) -- (  W/2, 2*H) -- (  W/2, hgap + 2*H);
draw(f1, L="$\mathbf{z}$");
draw(f2, arrow=ArcArrow);
draw(f3, arrow=ArcArrow);

// fc2
layer("fc [$\mathbf{W}_2, \mathbf{b}_2$]", (-W/2, 2*H + hgap));
arr(h, 3*H, x=-W/2, L="$\mathbf{\tilde{x}}$");

// fc3
layer("fc [$\mathbf{W}_3, \mathbf{b}_3$]", (+W/2, 2*H + hgap));
arr(h, 3*H, x=W/2, L="$\mathbf{y}$");

// Text Loss
real w_tloss_in = -(1.5*wgap + w);
path rec = (-0.1*w, h_c) -- (w_tloss_in, h_c) -- (w_tloss_in, 3*H+h);
draw(rec, arrow=ArcArrow);
layer("$\mathcal{L}_t = \mathcal{L}_\text{MSE}$", ((w_tloss_in - W/2)/2, 3*H+h), (abs(w_tloss_in + W/2) + 4*wgap, h));

// y*
// real w_vloss_in = W + wgap;
real w_vloss_in = - w_tloss_in;
label("$\mathbf{y^\star}$", (w_vloss_in, h_c));
arr(3*H, h, x=w_vloss_in);

// Visual Loss
layer("$\mathcal{L}_v = \mathcal{L}_\text{MSE}$", ((w_vloss_in + W/2)/2, 3*H+h), (w_tloss_in - W/2 + 4*wgap, h));

