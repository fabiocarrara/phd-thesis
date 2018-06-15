unitsize(1cm);

label(graphic("img/neuron.png","height=5cm"), (0,0));

pair c = (-1.9, -0.2);
real r = 1.2;
pen pen = black;

// CIRCLE
path ci = circle(c, r);
draw(ci, pen);
path vline = shift(c) * ((r/2, -r) -- (r/2, r));
pair[] i = intersectionpoints(vline, ci);
draw(i[0] -- i[1], pen);

// LABELS
label("$\displaystyle \sum \mathbf{w}_i \mathbf{x}_i $", c-(r/4,0));
label("$\varphi$", c+(3*r/4, 0));

// INPUTS
path d = (-2r,0) -- (-r, 0);
d = shift(c) * d;
for (int i = -60, j = 1; i <= 60; i += 30, ++j) {
    path p = rotate(i, c) * d;
    draw(p, arrow=Arrow, pen);
    label(Label("$\mathbf{x}_" + (string)j +"$", position=BeginPoint), p);
    label(Label("$\mathbf{w}_" + (string)j +"$", position=MidPoint, align=Relative(W)), p);
}

// OUTPUT
path o = (r,0) -- (3.5*r,0);
o = shift(c) * o;
draw(o, arrow=Arrow, L=Label("$\displaystyle \varphi \left ( \sum \mathbf{w}_i \mathbf{x}_i \right )$", position=EndPoint));
