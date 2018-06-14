unitsize(1cm);

real w = 1;
real h = 1;
real a = 0.5;

void drawCell(pair o=(0,0), string t="t", bool recur=false, bool last=false) {

    path p = shift(o) * box((0,0), (w,h));
    draw(p);

    label("$f$", shift(o) * (w/2, h/2));

    // input
    path i = (w/2, -a) -- (w/2, 0);
    i = shift(o) * i;
    draw(i, arrow=ArcArrow(), L=Label("$\mathbf{x}_" + t +"$", position=BeginPoint));

    string hLabel = "$\mathbf{h}_" + t +"$";
    if (recur) {
        // recurrent connection
        path r = (w/2, h + a/3) -- (-w/4, h + a/3) -- (-w/4, h/2) -- (0, h/2);
        r = shift(o) * r;
        draw(r, arrow=ArcArrow());
        // output
        path u = (w/2, h) -- (w/2 , h + a);
        u = shift(o) * u;
        draw(u, arrow=ArcArrow(), L=Label(hLabel, position=EndPoint));
    } else {
        path r = (w, h/2) -- (w+1.5*a, h/2);
        r = shift(o) * r;
        Label l;
        if (last)
            l = Label(hLabel, position=EndPoint);
        else
            l = Label(hLabel, position=MidPoint, align=N);

        draw(r, arrow=ArcArrow(), L=l);
    }
}

void drawUnrolledCells(int n) {

    pair start = (3.5*w, 0);
    pair disp = (0.5, 0);

    path r = (-a, h/2) -- (0, h/2);
    r = shift(start) * r;
    draw(r, arrow=ArcArrow(), L=Label("$\mathbf{h}_0$", position=BeginPoint));

    for (int i = 1; i <= n; ++i)
    {
        drawCell(o=start, t=(string)i, last=i==n);
        start += (w+1.5*a, 0);
    }

}

drawCell(recur=true);

drawUnrolledCells(5);


