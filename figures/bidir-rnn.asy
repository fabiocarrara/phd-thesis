unitsize(1cm);

real w = 1;
real h = 1;
real a = 0.5;

void drawCell(pair o=(0,0), string t="t", string hl="\mathbf{h}", string f="f", bool recur=false, bool rev=false, bool last=false) {

    path p = shift(o) * box((0,0), (w,h));
    draw(p);

    label("$"+ f +"$", shift(o) * (w/2, h/2));

    string hLabel = "$" + hl + "_" + t +"$";
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
        r = (rev) ? reverse(r) : r;
        Label l;
        if (last)
            l = Label(hLabel, position=(rev) ? BeginPoint : EndPoint);
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

    path x;
    for (int i = 1; i <= n; ++i)
    {
        drawCell(o=start, t=(string)i, rev=false, last=i==n);

        x = (w/2, 0) -- (w/2, w-2.5);
        x = shift(start) * x;

        draw(x, arrow=ArcArrows());
        fill(shift(start) * shift((w-0.5)/2, (w-2.5-0.5)/2) * scale(0.5) * unitsquare, white);
        label("$\mathbf{x}_" + (string)i +"$", start + (w/2, (w-2.5)/2));

        start += (w+1.5*a, 0);

    }

    start = (3.5*w, -2.5);
    r = (-a, h/2) -- (0, h/2);
    r = shift(start) * reverse(r);
    draw(r, arrow=ArcArrow(), L=Label("$\mathbf{h}'_0$", position=EndPoint));

    for (int i = 1; i <= n; ++i)
    {
        drawCell(o=start, t=(string)i, hl="\mathbf{h}'", f="f'", rev=true, last=i==n);
        start += (w+1.5*a, 0);
    }
}

drawUnrolledCells(5);
