unitsize(.8cm);
// texpreamble("\renewcommand{\rmdefault}{\sfdefault}");

path[] pic() {
    path p = (0, .2) -- (0, 0) -- (1, 0) -- (1, .4) --
             (.7, .6) -- (.4, .3) -- (.3, .4) -- (0, .2) --
             (0, 1) -- (1, 1) -- (1, .4);
    path c = circle((.3, .75), .1);
    return new path[] {p, c};
}

path[] text() {
    int nrows = 8;
    real margin = .2;
    path r = (margin, 0) -- (1 - margin, 0);
    path[] rows = new path[] {};
    for (int i = 0; i < nrows; ++i) {
        real disp = 1. / (nrows + 1);
        path row = r;
        if (i == 0)
            row = (margin, 0) -- (.85 - margin, 0);
        row = shift(0, (i+1) * disp) * row;
        rows.push(row);
    }
    
    return rows;
}

real w = 3, wgap = 1.5, ww = w + wgap;
real h = 1.5, hgap = .8;

// IMG
path[] img = scale(w) * pic();
draw(img);
path a = (w/2, w) -- (w/2, w + hgap);
draw(a, arrow=ArcArrow);
pair cnnStart = (0, w + hgap), cnnEnd = cnnStart + (w, h);
path cnn = box(cnnStart, cnnEnd);
draw(cnn);
label(minipage("\sc \scriptsize \centering Visual\\Features\\Extraction"), (cnnStart + cnnEnd) / 2);

// VISUAL SPACE
real space_r = w / 2.5, space_s = 1.3;
pair spaceStart = (w/2, cnnEnd.y + hgap);
pair spaceEnd = spaceStart + (0, 2*space_r*space_s);
pair spaceCenter = spaceStart + (0, space_r * space_s);
path space = shift(spaceCenter) * scale(1, space_s) * circle((0,0), space_r);
draw(space);
pair v = spaceCenter + (unitrand()-1, unitrand()-1);
dot(v);

path a = (w/2, cnnEnd.y){N} .. {N}(v - (0, 0.1));
draw(a, arrow=ArcArrow);


label(minipage("\centering \sc \scriptsize visual\\space"), spaceCenter + (0, hgap/2));

// TEXT
path[] txt = shift(w+wgap) * scale(w) * text();
draw(txt, linewidth(1.2));
path a = (ww + w/2, w) -- (ww + w/2, w+hgap);
draw(a, arrow=ArcArrow);
pair rnnStart = (ww, w+hgap), rnnEnd = rnnStart + (w,h);
path rnn = box(rnnStart, rnnEnd);
draw(rnn);
label(minipage("\sc \scriptsize \centering Textual\\Features\\Extraction"), (rnnStart + rnnEnd) / 2);

// TEXTUAL SPACE
pair spaceStart = (ww + w/2, rnnEnd.y + hgap);
pair spaceEnd = spaceStart + (0, 2*space_r*space_s);
// real space_r = w / 2, space_s = .7;
pair spaceCenter = spaceStart + (0, space_r * space_s);
path space = shift(spaceCenter) * scale(1, space_s) * circle((0,0), space_r);
fill(space, gray(.8));
draw(space);

pair t = spaceCenter + (unitrand() - 1, unitrand() - 1);
pair t2 = t + (0.12, -0.12);
dot(t);
dot(t2);

path a = (ww + w/2, rnnEnd.y){N} .. {N}(t2 - (0, 0.1));
draw(a, arrow=ArcArrow);


label(minipage("\centering \sc \scriptsize search space"), spaceEnd + (0, hgap/2));
label(minipage("\centering \sc \scriptsize textual\\space"), spaceCenter + (0, hgap/2));

// MAPPER
pair mS = (w + wgap/2 - h/2, spaceStart.y);
pair mE = mS + (h, 2*space_r*space_s);
path mapper = box(mS, mE);
draw(mapper);
label(rotate(90) * Label("\sc mapper"), (mS + mE) / 2);

pair mV = (mS.x, (mS.y + mE.y) / 2);
pair mT = (mE.x, (mS.y + mE.y) / 2);

// pair t2 = t + 2*(unitrand() - 1);
// dot(t2);

draw(v{E} .. {E}mV, arrow=ArcArrow);
draw(mT{E} .. {E}(t - (0.1, 0)), arrow=ArcArrow);


