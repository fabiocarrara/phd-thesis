/*unitsize(5cm);
import three;
import graph3;

currentprojection=perspective(6,-10,8);

real gaussian(pair z, pair c=(0,0), pair d=(1,1)) {return exp(-abs(scale(d.x, d.y) * (z - c))^2);}

real f(pair w) {
    return  0.35 - 0.5 * gaussian(w, c=(0.5, 0.5), d=(0.7, 0.7)) + // general valley
            -0.08 * gaussian(w, c=(1.10, 0.50), d=(1, 3.5)) + // base slope
            0.3 * gaussian(w, c=(0.25, 0.90), d=(5, 7))   + // highest peak
            0.3 * gaussian(w, c=(0.90, 1.20), d=(4, 2))   + // lateral peak
            0.3 * gaussian(w, c=(-0.10, 0.25), d=(2, 3))   + // lateral peak
            0.2 * gaussian(w, c=(0.75, 0.15), d=(3.5, 1));   // secondary peak
}

draw((0,0,0)--(1,0,0)--(1,1,0)--(0,1,0)--cycle);

surface s=surface(f,(0,0),(1,1),nx=20,Spline);

xaxis3(Label("$x$"),red,Arrow3);
yaxis3(Label("$y$"),red,Arrow3);
zaxis3(XYZero(extend=false),red,Arrow3);

draw(s,lightgray,meshpen=gray(0.5),nolight,render(merge=true));

label("$O$",O,-Z+Y,red);*/

import graph3;
import contour;
import grid3;
import palette;

size(8cm,IgnoreAspect);

currentprojection=orthographic(-10,-10,8);
limits((0,0,0),(5,10,12));

real f(pair z) {return 0.65 * (z.x+z.y)/(2+cos(z.x)*sin(z.y));}

surface s=surface(f,(0,0),(5,10),20,Spline);

pen[] Palette=Grayscale();
draw(s,surfacepen=mean(palette(s.map(zpart),Palette))
      ,meshpen=black + linewidth(.2bp),nolight);

grid3(new grid3routines [] {XYXgrid},
      Step=0.5,
      step=0,
      pgrid=new pen[] {black},
      pGrid=new pen[] {gray(0.4)}
      );
xaxis3(Label("$x$",position=MidPoint,align=SE),
       Bounds(Min,Min)); //, OutTicks());
yaxis3(Label("$y$",position=MidPoint,align=SW),
       Bounds(Min,Min)); //, OutTicks(Step=2));
// zaxis3(Bounds(Max,Min));
// zaxis3(Label("$z$",position=EndPoint,align=N+W), Bounds(Min,12)); //, InTicks(beginlabel=false,endlabel=false,Label(align=Y)), arrow=Arrow3);