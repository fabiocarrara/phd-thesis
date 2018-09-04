unitsize(3cm);

import flowchart;

real w = .5;
real h = .7;

block x1 = rectangle("$\mathbf{x}_1$", (0, h));
block x2 = rectangle("$\mathbf{x}_2$", (0, 0));

block n1 = rectangle("$f(\cdot)$", (w, h));
block n2 = rectangle("$f(\cdot)$", (w, 0));

block d = rectangle(minipage("\centering Contrastive Loss", 60), (2.5*w, h/2));

draw(x1);
draw(x2);

draw(n1);
draw(n2);

draw(d);

add(new void(picture pic, transform t) {
    blockconnector operator -- = blockconnector(pic,t);
    x1--Right--Right--Arrow--n1;
    x2--Right--Right--Arrow--n2;
    
    n1--Right--Down--Arrow--d;
    n2--Right--Up--Arrow--d;
});

