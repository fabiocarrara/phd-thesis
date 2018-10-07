unitsize(.2cm);

real w = 7, wgap = 3, full_w = w + wgap;
real h = 4, hgap = 1, full_h = h + hgap;
int n = 0;

void posting(string elems) {
    pair start = (0, - n * full_h);
    label("$\tau_" + ((string) (n+1)) + "$", start + (.75 * w, h/2));

    path sep = (w, .1*h) -- (w, .9*h);
    path sepArr = (w, h/2) -- (full_w, h/2);
    draw(shift(start) * sep);
    draw(shift(start) * sepArr, arrow=ArcArrow);

    string[] elements = split(elems, ";");
    for (int i = 0, m = elements.length; i <= m; ++i) {
        pair elemStart = (full_w * (i + 1), 0) + start;

        if (i == m)
            label("\dots", elemStart + (.35*w, h/2));
        else {
            path rect = shift(elemStart) * box((0, 0), (w, h));
            draw(rect);
            string elem = elements[i];
            label("$(" + elem + ")$", elemStart + (w/2, h/2));
            draw(shift(elemStart) * sepArr, arrow=ArcArrow);
        }
    }

    ++n;
}

string[] lists = new string[] {
    "o_3,3;o_1,1",
    "o_1,2",
    "o_2,2",
    "o_2,3;o_3,1",
    "o_1,3;o_2,1;o_3,1"
};

for (int i = 0; i < lists.length; ++i)
    posting(lists[i]);

