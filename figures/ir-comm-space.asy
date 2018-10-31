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

real wi = 1.2, w = 3.7, h = wi;
real wgap = .6, hgap = .2, H = h + hgap;
pair up = (0, H);
real wm = 2.2, hm = h;

// TEXT & IMG
real cur_w = 0;

path[] txt = shift(cur_w, (h - wi) / 2) * scale(wi) * text();
path[] img = shift(up) * shift(cur_w, (h - wi) / 2) * scale(wi) * pic();

draw(txt, linewidth(1.2));
draw(img);
cur_w += wi;

path a = (cur_w, h/2) -- (cur_w + wgap, h/2);
draw(a, arrow=ArcArrow);
draw(shift(up) * a, arrow=ArcArrow);
cur_w += wgap;

// FEAT EXTRACTORS
pair eS = (cur_w, 0), eE = eS + (w, h);
path extractor = box(eS, eE);
// textual
draw(extractor);
label(minipage("\sc \scriptsize \centering Textual Features\\Extractor"), (eS + eE) / 2);
// visual
draw(shift(up) * extractor);
label(minipage("\sc \scriptsize \centering Visual Features\\Extractor"), up + (eS + eE) / 2);

cur_w += w;

// SPACES
real sR = h/2;
pair sC = (cur_w + wgap/2 + sR, h/2);
path space = circle(sC, sR);

// textual
pair t = sC + 0.2*(2*unitrand() - 1, 2*unitrand() - 1);
path a = (cur_w, h/2){E} .. {E}(t - .1E);
draw(space);
// label("\sc \scriptsize textual space", sC + (sR, - sR/1.2), Align);
draw(a, arrow=ArcArrow);
dot(t);

// visual
pair v = up + sC + 0.2*(2*unitrand() - 1, 2*unitrand() - 1);
path a = (up + (cur_w, h/2)){E} .. {E}(v - .1E);
draw(shift(up) * space);
// label("\sc \scriptsize visual space", up + sC + (sR, sR/1.6), align=Align);
draw(a, arrow=ArcArrow);
dot(v);

cur_w += wgap + 2*sR;

// MAPPER
pair mS = (cur_w, (h-hm)/2), mE = mS + (wm, hm);
pair mI = (cur_w, h/2), mO = mI + (wm, 0);
path mapper = box(mS, mE);
// textual
draw(mapper);
label(minipage("\sc \scriptsize \centering Textual\\Mapper"), (mS + mE) / 2);
draw(t{E} .. {E}mI, arrow=ArcArrow);
// visual
draw(shift(up) * mapper);
label(minipage("\sc \scriptsize \centering Visual\\Mapper"), up + (mS + mE) / 2);
draw(v{E} .. {E}(mI + up), arrow=ArcArrow);

cur_w += wm;

// COMMON
real cR = h/2;
pair cC = (cur_w + wgap + cR, (h+H)/2);
path common = circle(cC, cR);
fill(common, gray(.8));
draw(common);
label(minipage("\centering \sc \scriptsize common\\space", 30), cC + (2.4*sR, 0));

pair ct = cC + .2*(unitrand() - 1.5, 2*unitrand() - 1);
pair cv = ct + .15N;
dot(ct);
dot(cv);

draw(mO{E} .. {N}(ct - .1N), arrow=ArcArrow);
draw((mO + up){E} .. {S}(cv - .1S), arrow=ArcArrow);

