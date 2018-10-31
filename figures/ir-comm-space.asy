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

real w = 3, wgap = 6, ww = w + wgap;
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
draw(space);

pair t = spaceCenter + (unitrand() - 1, unitrand() - 1);
dot(t);

path a = (ww + w/2, rnnEnd.y){N} .. {N}(t - (0, 0.1));
draw(a, arrow=ArcArrow);

label(minipage("\centering \sc \scriptsize textual\\space"), spaceCenter + (0, hgap/2));

// MAPPER
path common = shift(-ww/2, 0) * space;
fill(common, gray(.8));
draw(common);
pair commonCenter = spaceCenter - ww/2;
label(minipage("\centering \sc \scriptsize search space"), commonCenter + (0, space_r*space_s + hgap/2));
label(minipage("\centering \sc \scriptsize common\\space"), commonCenter + (0, hgap/2));

pair m1S = (w + wgap/8 - h/2, spaceStart.y);
pair m1E = m1S + (h, 2*space_r*space_s);
path mapper1 = box(m1S, m1E);

draw(mapper1);
label(rotate(90) * minipage("\centering \sc \scriptsize visual mapper"), (m1S + m1E) / 2);

pair m1V = (m1S.x, (m1S.y + m1E.y) / 2);
pair m1C = (m1E.x, (m1S.y + m1E.y) / 2);

// textual mapper 
pair m2S = (w + 7*wgap/8 - h/2, spaceStart.y);
pair m2E = m2S + (h, 2*space_r*space_s);
path mapper2 = box(m2S, m2E);

draw(mapper2);
label(rotate(90) * minipage("\centering \sc \scriptsize textual mapper"), (m2S + m2E) / 2);

pair m2C = (m2S.x, (m2S.y + m2E.y) / 2);
pair m2T = (m2E.x, (m2S.y + m2E.y) / 2);

// pair t2 = t + 2*(unitrand() - 1);
// dot(t2);
pair c1 = commonCenter + .3*(unitrand() - 1, unitrand() - 1);
pair c2 = c1 + (0.2, -0.03);
dot(c1);
dot(c2);

draw(v{E} .. {E}m1V, arrow=ArcArrow);
draw(m1C{E} .. {E}(c1 - (0.1, 0)), arrow=ArcArrow);

draw(t{W} .. {W}m2T, arrow=ArcArrow);
draw(m2C{W} .. {W}(c2 + (0.1, 0)), arrow=ArcArrow);



