unitsize(0.5cm);
import graph;

// defaultpen(fontsize(12pt));

typedef real func(real);

real relu(real x) {
    return max(x, 0);
}

real sigmoid(real x) {
    return 1 / (1+ exp(-x));
}

int xLen = 3;
int yLen = 3;

void drawAct(func a, string yLabel, pair o=(0,0), pen p=black, int[] asym={}) {
    path xax = (-xLen,0) -- (xLen,0);
    path yax = (0,-2) -- (0,yLen);

    draw(shift(o) * xax, arrow=Arrow(TeXHead), L=Label("$x$", position=EndPoint, align=S+W));
    draw(shift(o) * yax, arrow=Arrow(TeXHead), L=Label("$\varphi(x)=" + yLabel + "$", position=EndPoint));

    real n = 1;
    draw(shift(o) * xscale(1/n) * graph(a, -n*xLen, n*xLen), p + linewidth(2pt));

    for (int i = 0; i < asym.length; ++i) {
        int ya = asym[i];
        path as = (-xLen, ya) -- (xLen, ya);
        as = shift(o) * as;
        draw(as, dashed);
        pair align = (ya > 0) ? (N+W) : (S+W);
        Label L = Label("$" + ((string) ya) + "$", align=align);
        dot(shift(o) * (0, ya), L=L);
    }
}

drawAct(relu, "\max(x,0)");
drawAct(sigmoid, "\displaystyle \frac{1}{1+e^{-x}}", o=(10, 0), asym=new int[] {1});
drawAct(tanh, "\tanh(x)", o=(20, 0), asym=new int[] {1, -1});
