import graph3;
import grid3;
import palette;

int side = 7;

size(8cm);

currentprojection = orthographic(-9, -side, 5);
limits(O, (side, side, 6));

// LOSS FUNCTION
real c = 0.4;
real loss(pair z) {return c * (z.x+z.y)/(2+cos(z.x)*sin(z.y));}
pair gradLoss(pair z) {
    real gx = c * ( (2 + cos(z.x) * sin(z.y)) + (z.x + z.y) * sin(z.x) * sin(z.y) ) / (2 + cos(z.x) * sin(z.y))^2;
    real gy = c * ( (2 + cos(z.x) * sin(z.y)) - (z.x + z.y) * cos(z.x) * cos(z.y) ) / (2 + cos(z.x) * sin(z.y))^2;
    return (gx, gy);
}

// SURFACE
surface s = surface(loss, (0, 0), (side, side), 20, Spline);

pen[] Palette=Grayscale()[70:];
draw(s ,surfacepen=mean(palette(s.map(zpart),Palette)), meshpen=black + linewidth(.2bp), nolight);

// SGD
void descent(pair w, real lr, real m, int steps=15, pen p=black) {
    pair next, grad = gradLoss(w);
    triple cur3, next3;
    cur3 = (w.x, w.y, loss(w));
    dot(cur3, 2+p);
    for (int i = 0; i < steps; ++i) {
        grad = m * grad + (1 - m) * gradLoss(w);
        next = w - lr * unit(grad);
        next3 = (next.x, next.y, loss(next));
        draw(cur3 .. next3 + 0.1 * (cur3 - next3), p, arrow=ArcArrow3(1));
        w = next;
        cur3 = (w.x, w.y, loss(w));
        dot(cur3, 2+p);
    }
}

descent(w=(5.4, 4.4), lr=0.5, m=0.7, steps=12);
descent(w=(5.7, 3.9), lr=0.5, m=0, steps=7);

// GRID AND AXES
grid3(new grid3routines [] {XYXgrid}, Step=0.5, step=0, pgrid=new pen[] {black}, pGrid=new pen[] {gray(0.4)});
xaxis3(Label("$\mathbf{w}_1$", position=MidPoint, align=SE), Bounds(Min,Min));
yaxis3(Label("$\mathbf{w}_2$", position=MidPoint, align=SW), Bounds(Min,Min));
zaxis3(Label("$\mathcal{L}(\mathbf{X}; \mathbf{w}_1, \mathbf{w}_2)$", position=EndPoint, align=S+E), Bounds(Min, Max), arrow=ArcArrow3);