unitsize(3cm);

import flowchart;

real w = .5;
real h = .4;

block x1 = rectangle("$\mathbf{x}_a$", (0, 2*h));
block x2 = rectangle("$\mathbf{x}_p$", (0, h));
block x3 = rectangle("$\mathbf{x}_n$", (0, 0));

block n1 = rectangle("$f(\cdot)$", (w, 2*h));
block n2 = rectangle("$f(\cdot)$", (w, h));
block n3 = rectangle("$f(\cdot)$", (w, 0));

block d = rectangle(minipage("\centering Triplet Loss", 60), (2.5*w, h));

draw(x1);
draw(x2);
draw(x3);

draw(n1);
draw(n2);
draw(n3);

draw(d);

add(new void(picture pic, transform t) {
    blockconnector operator -- = blockconnector(pic,t);
    x1--Right--Right--Arrow--n1;
    x2--Right--Right--Arrow--n2;
    x3--Right--Right--Arrow--n3;
    
    n1--Right--Down--Arrow--d;
    n2--Right--Right--Arrow--d;
    n3--Right--Up--Arrow--d;
});

