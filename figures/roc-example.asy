size(16cm);

// BEST CLASSIFIER
path s = (0,0) -- (0,1) -- (1,1);
draw(s, linewidth(1), L=Label("\textsc{\small best}", position=Relative(0.5), align=N+E));
dot((0, 1));

// GOOD CLASSIFIER
path s = (0,0){up} .. {up}(0.05, 0.8)  .. (0.4, 0.95){right+0.2up} .. {right}(1,1);
fill(s -- (1,0) -- cycle, gray);
draw(s, linewidth(1), L=rotate(45) * Label("{\small $\mathcal{C}_2$}", position=Relative(0.44)));

// CLASSIFIER
path q = (0,0){up} .. (0.1, 0.5) .. (0.4, 0.8) .. {right}(1,1);
fill(q -- (1,0) -- cycle, gray(0.6));
draw(q, linewidth(1), L=rotate(45) * Label("{\small $\mathcal{C}_1$}", position=Relative(0.46)));

// RANDOM CLASSIFIER
fill((0, 0) -- (1, 1) -- (1,0) -- cycle, mediumgray);
draw((0, 0) -- (1, 1), linewidth(1), L=rotate(45) * Label("\textsc{\small random}", position=Relative(0.38)));

pair c2eer = point((1, 0) -- (0, 1), intersect((1, 0) -- (0, 1), s)[0]);
pair c1eer = point((1, 0) -- (0, 1), intersect((1, 0) -- (0, 1), q)[0]);
pair rceer = (0.5,0.5);
dot(c2eer);
dot(c1eer);
dot(rceer);

// EER
path p = (0,1) -- (1, 0);
draw(p, L=rotate(-45) * Label("\textsc{\scriptsize fpr=fnr (eer)}", align=N, position=Relative(0.87)), dashed);

pair eO = (-0.35, c1eer.y);
draw(eO .. {right} (c2eer - 0.03E), arrow=ArcArrow(2));
draw(eO .. {right} (c1eer - 0.03E), arrow=ArcArrow(2), L=Label(minipage("\centering \textsc{\small eer \\[-1ex] settings}", 50), position=BeginPoint));
draw(eO .. {right} (rceer - 0.03E), arrow=ArcArrow(2));


// AUCS
pair bO = (1.3, 0.95);
pair bsize = (0.2, 0.1);
pair space = (0, 0.1);
pair bcO = bO + (bsize.x/2, 0);

label(Label("AUC"), (bcO.x, 1.14));

path baseb = scale(bsize.x, bsize.y) * unitsquare;

real rel25 = (bsize.x + 0.5*bsize.y)/(2*(bsize.x + bsize.y));

label(Label("$1$"), bcO);

label(rotate(90) * Label("$<$"), bcO - space);
path b = shift(bO - 2*space - (0, bsize.y/2)) * baseb;
label(Label("$\mathcal{C}_2$", position=Relative(rel25)), b);
fill(b, gray);
draw(bO + -2*space .. (0.33, 0.86), arrow=ArcArrow(2));

label(rotate(90) * Label("$<$"), bcO -3*space);
path b = shift(bO - 4*space - (0, bsize.y/2)) * baseb;
label(Label("$\mathcal{C}_1$", position=Relative(rel25)), b);
draw(bO - 4*space .. (0.53, 0.7), arrow=ArcArrow(2));
fill(b, gray(0.6));

label(rotate(90) * Label("$<$"), bcO - 5*space);
path b = shift(bO - 6*space - (0, bsize.y/2)) * baseb;
label(Label("\textsc{\small random}", position=Relative(rel25)), b);
draw(bO - 6*space .. (0.83, 0.4), arrow=ArcArrow(2));
fill(b, mediumgray);

label(rotate(90) * Label("$=$"), bcO - 7*space);
label(Label("$0.5$"), bcO - 8*space);

// AXES
arrowbar axisarrow = Arrow(TeXHead);
Label xlabel = Label("FPR", position=EndPoint);
draw((0, 0) -- (1.1, 0), arrow=axisarrow, L=xlabel);

Label ylabel = Label("TPR", position=EndPoint);
draw((0, 0) -- (0, 1.1), arrow = axisarrow, L=ylabel);

path p = (0,1) -- (1, 1) -- (1, 0);
draw(p, dashed);
label(Label("$1$", position=BeginPoint), p);
label(Label("$1$", position=EndPoint), p);
