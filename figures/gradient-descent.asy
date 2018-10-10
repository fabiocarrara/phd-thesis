import graph3;
import grid3;
import palette;

int side = 7;
real dotsize = 3.5;
real arrowsize = 5 ;

size(15cm);

currentprojection = orthographic(-9, -side, 5);
limits(O, (side, side, 2));

// LOSS FUNCTION
real c = 0.25;
real loss(pair z) {return c * (z.x+z.y)/(2+cos(z.x)*sin(z.y));}
pair gradLoss(pair z) {
    real gx = c * ( (2 + cos(z.x) * sin(z.y)) + (z.x + z.y) * sin(z.x) * sin(z.y) ) / (2 + cos(z.x) * sin(z.y))^2;
    real gy = c * ( (2 + cos(z.x) * sin(z.y)) - (z.x + z.y) * cos(z.x) * cos(z.y) ) / (2 + cos(z.x) * sin(z.y))^2;
    return (gx, gy);
}

// SURFACE
surface s = surface(loss, (0, 0), (side, side), 20, Spline);

pen[] cmap = Grayscale()[70:];
draw(s, surfacepen=mean(palette(s.map(zpart), cmap)), meshpen=gray(0.25)+linewidth(.2bp), nolight);

// SGD
void descent(pair w, real lr, real m, int steps=15, pen p=black, bool gradLabel=false) {
    pair next, grad = gradLoss(w);
    triple cur3, next3;
    cur3 = (w.x, w.y, loss(w));
    if (gradLabel) { dot("$\Theta$", cur3, dotsize + p); }
    else { dot(cur3, dotsize + p); }

    for (int i = 0; i < steps; ++i) {
        grad = m * grad + (1 - m) * gradLoss(w);
        next = w - lr * unit(grad);
        next3 = (next.x, next.y, loss(next));
        string lab = (i == 0 && gradLabel) ? "$-\lambda\nabla\mathcal{L}(\mathbf{X};\Theta)$": "";
        draw(cur3 .. next3 + 0.15 * (cur3 - next3), p, arrow=Arrow3(arrowsize), L=lab);
        w = next;
        cur3 = (w.x, w.y, loss(w));
        if (i == 0 & gradLabel) { dot("$\Theta^\star$", cur3, dotsize + p); }
        else { dot(cur3, dotsize + p); }
    }
}

descent(w=(5.4, 4.4), lr=0.5, m=0.7, steps=12, gradLabel=true);
descent(w=(5.7, 3.9), lr=0.5, m=0, steps=7);

// GRID AND AXES
grid3(new grid3routines [] {XYXgrid}, Step=0.5, step=0, pgrid=new pen[] {black}, pGrid=new pen[] {gray(0.4)});
xaxis3(Label("$\mathbf{w}_1$", position=MidPoint, align=SE), Bounds(Min,Min));
yaxis3(Label("$\mathbf{w}_2$", position=MidPoint, align=SW), Bounds(Min,Min));
zaxis3(Label("$\mathcal{L}(\mathbf{X}; \mathbf{w}_1, \mathbf{w}_2)$", position=EndPoint, align=N+E), Bounds(Min, Max), arrow=ArcArrow3);