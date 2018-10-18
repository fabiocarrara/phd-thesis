unitsize(.8cm);

// box sizes
pair t = (5, 3.5), f = (4.5, 3.5), p = (2.8, 3.8), m = (6, 5);
// arrow lengths
real t2f = 1.5, f2p = 1.5, p2m = 1.5, m_gap = .5;

// middle height (central vertical alignment)
real middle = max(new real[] {t.y, f.y, p.y, m.y}) / 2;

// starting points
pair tS = (0, middle - t.y/2);
pair fS = (tS.x + t.x + t2f, middle - f.y/2);
pair pS = (fS.x + f.x + f2p, middle - p.y/2);
pair mS = (pS.x + p.x + p2m, middle - m.y/2);

path b;

// WEB SOURCE
pair tE = tS + t;
draw(box(tS, tE));
label(minipage("\centering \Large Web Source\\ {\scriptsize (Random 5\% of Twitter)}", 100), (tS + tE) / 2);

// -->
draw((tE.x, middle) -- (fS.x, middle), arrow=ArcArrow);

// FILTERING
pair fE = fS + f;
draw(box(fS, fE));
// label(minipage("\centering Filtering\\ {\tiny (5+ words, 1+ images, english only)}", 100), (fS + fE) / 2);
label(minipage("\centering \Large Filtering \scriptsize \begin{itemize} \setlength\itemsep{-.5em} \item 5+ words \item 1+ images \item english only \end{itemize}", 90), (fS + fE) / 2);

real d = .2;
// -->
draw((fE.x, middle) -- (pS.x - d, middle), arrow=ArcArrow);

// POSTS
pair pE = pS + p;
path backPost = (d, 0) -- (0, 0) -- (0, p.y) -- p -- (p.x, p.y - d);
backPost = shift(pS) * backPost;

draw(backPost);
draw(shift(-d, d) * backPost);
draw(shift(d, -d) * box(pS, pE));

// POST CONTENTS
//  - PIC
path[] pic() {
    path p = (0, .2) -- (0, 0) -- (1, 0) -- (1, .4) --
             (.7, .6) -- (.4, .3) -- (.3, .4) -- (0, .2) --
             (0, 1) -- (1, 1) -- (1, .4);
    path c = circle((.3, .75), .1);
    return new path[] {p, c};
}

pair tpS = shift(d, -d) * pS;
pair tpE = shift(d, -d) * pE;
path[] img = pic();
real s = .2;
real imgSide = (1 - s) * p.x;
real imgPad = .5 * s * p.x;
img = scale(imgSide) * img;
pair imgS = tpS +  imgPad * (1, 1);
pair imgE = imgS + imgSide * (1, 1);
img = shift(imgS) * img;
draw(img);

//  - TEXT LINES
real linePad = 1.2*imgPad;
pair lineS = imgS + (0, imgSide + linePad);
pair lineE = tpE - (imgPad, linePad);
int nLines = 4;
real spacing = (lineE.y - lineS.y) / (nLines - 1);
for (int i = nLines - 1; i > 0 ; --i)
    draw((lineS.x, lineS.y + i*spacing) -- (lineE.x, lineS.y + i*spacing), linewidth(1));
// truncated last line
draw(lineS -- (lineE.x - .4 imgSide, lineS.y), linewidth(1));

// Text Bracket
real b = linePad/2;
path textBracket = (imgE.x - b, imgE.y + linePad / 2) -- (imgE.x + imgPad / 2, imgE.y + linePad / 2) --
                   (imgE.x + imgPad / 2, lineE.y + linePad / 2) -- (imgE.x - b, lineE.y + linePad / 2);
draw(textBracket);

// MODELS
pair mE = mS + m;
pair mm = (m.x, (m.y - m_gap) / 2);
pair mtS = mS + (0, mm.y + m_gap), mtE = mtS + mm;
pair mvS = mS, mvE = mvS + mm;

// Text Arrow
pair taS = (imgE.x + imgPad / 2, (lineE.y + imgE.y + linePad) / 2);
pair taE = (taS.x + imgPad / 2 - d + p2m, mtS.y + mm.y / 2);
draw(taS{E} .. {E}taE, arrow=ArcArrow);

// Image Arrow
pair iaS = imgE - (0, imgSide / 2);
pair iaE = (iaS.x + imgPad - d + p2m, mvS.y + mm.y / 2);
draw(iaS{E} .. {E}iaE, arrow=ArcArrow);


// Text model
draw(box(mtS, mtE));
label(minipage("\centering \small \textbf{Textual}\\ Sentiment Classifier\\ {\scriptsize (LSTM-SVM, \emph{Teacher})}", 100), (mtS + mtE) / 2);

// Visual model
draw(box(mvS, mvE));
label(minipage("\centering \small \textbf{Visual}\\ Sentiment Classifier\\ {\scriptsize (CNN, \emph{Student})}", 100), (mvS + mvE) / 2);

// SUPERVISION
real pad = .7;
pair sS = taE + (mm.x, 0);
pair sE = iaE + (mm.x, 0);

path supervis = sS -- (sS.x + pad, sS.y) -- (sS.x + pad, sE.y) -- sE;
draw(supervis, arrow=ArcArrow, L=rotate(-90)* Label("\footnotesize supervision", align=E));

