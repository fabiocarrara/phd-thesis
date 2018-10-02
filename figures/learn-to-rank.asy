unitsize(6cm);

srand(42);

real m = 0.3;
pen s = 4 + currentpen;

dot((0,0), L=Label("$\mathbf{x}_a$", align=.5(N+W)));

draw(circle((0,0), m));
draw((0.017 ,0) -- (m - 0.008)*dir((3, 0)), arrow=Arrows(TeXHead), L=Label("$m$", position=MidPoint, align=N));

// SIMILAR POINTS
for (int i = 0; i < 10; ++i) {
    pair p = 0.35(2*unitrand()-1, 2*unitrand()-1);
    dot(p, s);
    real d = sqrt(p.x*p.x + p.y*p.y);
    if (d > m)
        draw(p -- (p - (d - m + 0.035)*dir(p)), arrow=ArcArrow(2));
}

// DISSIMILAR POINTS
for (int i = 0; i < 10; ++i) {
    pair p = 0.5(2*unitrand()-1, 2*unitrand()-1);
    dot(p, s + gray);
    real d = sqrt(p.x*p.x + p.y*p.y);
    if (d < m)
        draw((p + 0.009dir(p))  -- (p + (m - d + 0.035)*dir(p)), arrow=ArcArrow(2));
}
