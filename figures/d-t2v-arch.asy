unitsize(.8cm);
usepackage("amsmath");
texpreamble("\renewcommand{\rmdefault}{\sfdefault}");

real w = 3.5, wgap = 1.1, w_c = w/2, W = w + wgap;
real h =  .8, hgap = .5, h_c = h/2, H = h + hgap;

void layer(string s, pair o, pair d=(w, h), bool param=true) {
    pair boxStart = (o.x - d.x/2, o.y);
    pair boxEnd = (o.x + d.x/2, o.y + d.y);
    path b = box(boxStart, boxEnd);
    pen p = param ? mediumgray : gray(0.95);
    fill(b, p);
    label(s, (boxStart + boxEnd)/2);
}

void arr(real length, real height=0, real x=0, Label L="") {
    pair start = (x, height);
    pair end = start + (0, length);
    draw(start -- end, arrow=ArcArrow, L=L);
}

void cell(int t, string i="", string ip1="", real x=0, bool state=true) {
    // string ip1 = "{" + i + "+1}";
    if (length(i) == 0) i = (string) t;
    if (length(ip1) == 0) ip1 = "{" + ((string)(t+1)) + "}";

    arr(hgap, x=x, L=Label("$\mathbf{x}_" + i + "$", position=BeginPoint, align=S)); // x_i
    layer("lookup [$\mathbf{E}$]", (x, hgap));
    arr(h, H, L="$\mathbf{e}_" + i + "$", x=x); // e_i
    // LSTM
    layer("LSTM", (x, H+h), (w, w));
    if (state) {
        arr(h, H + h + w, x=x, L="$\mathbf{o}_" + i + "$"); // o_i

        pair s_i = (x + w/2, H + h + w/2);
        draw(s_i -- (s_i) + (wgap, 0), arrow=ArcArrow, L=Label("$\mathbf{s}_" + i + "$", align=N)); // s_i

        // fc
        layer("fc [$\mathbf{W}_1, \mathbf{b}_1$]", (x, H + 2*h + w));
        real hh = 2*H + 4*h + w - 1.5*hgap;
        draw((x, H + 3*h + w) -- (x, hh), arrow=ArcArrow, L=Label("$\mathbf{\tilde{x}}_" + ip1 + "$")); // ~x_i+1

        draw((x - w/4, H + 3*h + w + 2.05*hgap) -- (x - w/4, hh), arrow=ArcArrow, L=Label("$\mathbf{x}_" + ip1 + "$", position=BeginPoint));
        layer("$\mathcal{L}_t = \mathcal{L}_\text{CE}$", (x, hh), param=false);
    }
}

cell(0);
cell(1, x=W);
real midH = H + h + w/2;
label("\dots", (1.5*W + 1.5*wgap, midH));
real dStartW = 1.5*W + 2.35*wgap;
draw((dStartW, midH) -- (dStartW + wgap, midH), arrow=ArcArrow, L=Label("$\mathbf{s}_{L-2}$", align=N));

cell(2, "{L-1}", "L", x=dStartW + wgap + w/2);
cell(3, "L", x=dStartW + wgap + w/2+W, state=false);

pair sfStart = (dStartW + 2*W, midH);
pair sfEnd = (dStartW + 2*W + w/2, H + 2*h + w);

path s = sfStart -- (sfEnd.x, sfStart.y) -- sfEnd;
draw(s , arrow=ArcArrow, L=Label("$\mathbf{s}_L$", position=BeginPoint, align=N+E)); // s_i
// fc2
layer("fc [$\mathbf{W}_2, \mathbf{b}_2$]", sfEnd);
real hh = 2*H + 4*h + w - 1.5*hgap;
draw((sfEnd.x, H + 3*h + w) -- (sfEnd.x, hh), arrow=ArcArrow, L=Label("$\mathbf{y}$")); // y

draw((sfEnd.x - w/4, H + 3*h + w + 2.44*hgap) -- (sfEnd.x - w/4, hh), arrow=ArcArrow, L=Label("$\mathbf{y}^\star$", position=BeginPoint));
layer("$\mathcal{L}_v = \mathcal{L}_\text{MSE}$", (sfEnd.x, hh), param=false);

