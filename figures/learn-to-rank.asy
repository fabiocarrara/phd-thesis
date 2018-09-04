unitsize(6cm);

srand(42);

real m = 0.3;

dot((0,0), L=Label("$\mathbf{x}_a$", align=.5(N+W)));

draw(circle((0,0), m));
draw((0,0) -- m*dir((3, 0)), arrow=Arrows(TeXHead), L=Label("$m$", position=MidPoint));

for (int i = 0; i < 10; ++i) {
    pair p = 0.35(2*unitrand()-1, 2*unitrand()-1);
    dot(p);
    real d = sqrt(p.x*p.x + p.y*p.y);
    if (d > m)
        draw(p -- (p - (d - m + 0.035)*dir(p)), arrow=ArcArrow(2));
}

for (int i = 0; i < 10; ++i) {
    pair p = 0.5(2*unitrand()-1, 2*unitrand()-1);
    dot(p, gray);
    real d = sqrt(p.x*p.x + p.y*p.y);
    if (d < m)
        draw(p -- (p + (m - d + 0.035)*dir(p)), arrow=ArcArrow(2));
}

/*
pair[] p = new pair[] {
    (-1,-1),
    (2, 1),
    (-1, 2)
};

for (pair pp: p) { dot(p); }
*/
