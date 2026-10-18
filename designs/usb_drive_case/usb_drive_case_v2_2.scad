// =====================================================================
// USB drive case v2. Same two piece case as v1, now engraved all round.
//
// FRONT:  inverted pentagram, name_front under it.
// BACK:   Leviathan cross (the Satanic cross), name_back under it.
// EDGES:  a column of inverted crosses on each narrow side.
// CAP TOP: small inverted pentagram.
//
// Sized for the white Gigastone 256GB stick WITH ITS OWN CAP ON.
// The drive drops into the body, the case cap slides over the stepped
// rim and clicks on two small beads.
//
// MEASURE THE DRIVE WITH CALIPERS BEFORE PRINTING. The three numbers
// below are estimated from photos, not measured.
//
// PRINT AS MODELLED: body standing on its floor, cap standing on its
// roof, open ends up. No supports. 3 walls, 0.2 mm layers.
// The engraving is 0.6 mm deep. A 0.4 nozzle holds it. Rub paint or
// wax into it and wipe the face to make it stand out.
//
// Coordinates: X across the drive width, Y its thickness, Z its length.
// Units: mm.
// =====================================================================

/* [Fit: measure these] */
drive_l    = 58;    // total length, drive cap on
drive_w    = 21;    // width
drive_t    = 10;    // thickness

/* [Engraving] */
engrave    = true;
name_front = "OSzity";   // under the pentagram
name_back  = "OSlith";   // under the cross
back_mark  = "leviathan";   // [leviathan, inverted]
text_size  = 3.6;
font       = "Liberation Sans:style=Bold";
depth      = 0.6;   // engraving depth
stroke     = 1.1;   // line width of the symbols

/* [Clearance] */
clear      = 0.5;   // gap round the drive, per side
end_clear  = 1.0;   // spare length. room for a foam dot at each end
fit        = 0.2;   // gap between the rim and the case cap, per side

/* [Shell] */
wall       = 3.0;   // side wall
floor_t    = 2.0;   // body floor and cap roof
spig_t     = 1.4;   // thickness of the stepped rim
lap        = 6;     // how far the cap slides over the rim
grab       = 12;    // how much drive sticks out of the body to grab
r_in       = 1.5;   // cavity corner radius. keep at or under the drive's

/* [Snap beads] */
snap       = true;
bead_r     = 1.0;
bead_h     = 0.45;  // how far each bead stands proud. lower = looser

/* [Output] */
show       = "plate";   // [plate, assembled, body, cap]

$fn = 64;
eps = 0.01;

// ==== derived ========================================================
iw       = drive_w + 2*clear;          // cavity
it       = drive_t + 2*clear;
il       = drive_l + end_clear;
ow       = iw + 2*wall;                // outside
ot       = it + 2*wall;
r_out    = r_in + wall;
z_top    = floor_t + il - grab;        // top of the rim
z_sh     = z_top - lap;                // shoulder the cap lands on
cap_len  = floor_t + il + floor_t - z_sh;
total_l  = z_sh + cap_len;
skirt_t  = wall - spig_t - fit;
bead_len = iw - 6;
bead_y   = it/2 + spig_t - (bead_r - bead_h);

// engraving layout
face_w   = ow - 2*r_out;               // flat width of a wide face
edge_w   = ot - 2*r_out;               // flat width of a narrow side
name_z   = 4 + text_size/2;            // name centre height
sym_lo   = name_z + text_size/2 + 2.5; // symbol zone
sym_hi   = z_sh - 3.5;
sym_h    = sym_hi - sym_lo;
sym_c    = (sym_lo + sym_hi)/2;
pent_r   = min(face_w, sym_h)/2;

assert(spig_t >= 1.2, "rim too thin");
assert(skirt_t >= 1.0, "cap skirt too thin: raise wall");
assert(z_sh > floor_t + 10, "grab or lap too big for this drive");
assert(r_in < min(iw, it)/2, "r_in too big");
assert(depth <= wall - 1.6, "engraving too deep for this wall");
assert(depth <= floor_t - 1.0, "engraving too deep for the cap roof");

echo(str("Case outside: ", ow, " x ", ot, " x ", total_l, " mm"));
echo(str("Cavity: ", iw, " x ", it, " x ", il, " mm"));
echo(str("Flat face width for engraving: ", face_w, " mm. Pentagram ",
         2*pent_r, " mm across"));

// ==== helpers ========================================================
module prof(w, t, r) {
    hull() for (sx = [-1, 1], sy = [-1, 1])
        translate([sx*(w/2 - r), sy*(t/2 - r)]) circle(r = r);
}

module seg(a, b, w = stroke) {
    hull() { translate(a) circle(d = w, $fn = 16); translate(b) circle(d = w, $fn = 16); }
}

module ring(r, w = stroke) {
    difference() { circle(r = r); circle(r = r - w); }
}

// ==== marks, all 2D, centred on the origin ===========================
// Inverted pentagram in a ring. r = outside radius.
module pentagram_2d(r, w = stroke) {
    ri = r - w/2;
    p = [for (k = [0 : 4]) ri * [cos(270 + 72*k), sin(270 + 72*k)]];
    ring(r, w);
    for (k = [0 : 4]) seg(p[k], p[(k + 2) % 5], w);
}

// Leviathan cross: double cross standing on an infinity sign. h = height.
module leviathan_2d(h, w = stroke) {
    lr = min(h * 0.15, face_w/4 - 0.2);      // loop radius
    y0 = -h/2;
    for (s = [-1, 1]) translate([s*(lr - w/2), y0 + lr]) ring(lr, w);
    seg([0, y0 + 2*lr - w/2], [0, h/2 - w/2], w);
    seg([-h*0.29, y0 + h*0.56], [h*0.29, y0 + h*0.56], w);
    seg([-h*0.20, y0 + h*0.76], [h*0.20, y0 + h*0.76], w);
}

// Inverted cross. h = height.
module inv_cross_2d(h, w = stroke) {
    seg([0, -h/2 + w/2], [0, h/2 - w/2], w);
    seg([-h*0.28, -h*0.18], [h*0.28, -h*0.18], w);
}

module name_2d(t) {
    text(t, size = text_size, font = font, halign = "center", valign = "center");
}

// Cut a 2D mark into a side wall. ang 0 = front, 180 = back, 90 and
// 270 = the narrow sides. The 2D origin lands at height z, on centre.
module on_wall(ang, z) {
    dist = (ang % 180 == 0) ? ot/2 : ow/2;
    rotate([0, 0, ang]) translate([0, -dist + depth, z]) rotate([90, 0, 0])
        linear_extrude(height = depth + 1) children();
}

// ==== engraving sets =================================================
module body_marks() {
    // front
    on_wall(0, sym_c) pentagram_2d(pent_r);
    on_wall(0, name_z) name_2d(name_front);
    // back
    on_wall(180, sym_c)
        if (back_mark == "inverted") inv_cross_2d(sym_h);
        else leviathan_2d(sym_h);
    on_wall(180, name_z) name_2d(name_back);
    // narrow sides: three inverted crosses each
    ch = min(9, edge_w / 0.56 - 1);
    for (a = [90, 270], i = [0 : 2])
        on_wall(a, 4 + ch/2 + i * (z_sh - 8 - ch) / 2) inv_cross_2d(ch, 1.0);
}

// In cap coordinates: z = 0 on the shoulder.
module cap_marks() {
    // roof
    translate([0, 0, cap_len - depth]) linear_extrude(height = depth + 1)
        pentagram_2d(min(face_w, ot - 4)/2, 1.0);
}

// ==== parts ==========================================================
module body() {
    difference() {
        union() {
            linear_extrude(height = z_sh) prof(ow, ot, r_out);
            translate([0, 0, z_sh - eps]) linear_extrude(height = lap + eps)
                prof(iw + 2*spig_t, it + 2*spig_t, r_in + spig_t);
            if (snap) for (s = [-1, 1])
                translate([0, s*bead_y, z_sh + lap/2]) rotate([0, 90, 0])
                    cylinder(r = bead_r, h = bead_len, center = true, $fn = 32);
        }
        translate([0, 0, floor_t]) linear_extrude(height = il + 1)
            prof(iw, it, r_in);
        if (engrave) body_marks();
    }
}

// Modelled open end down, z = 0 on the shoulder.
module cap() {
    difference() {
        linear_extrude(height = cap_len) prof(ow, ot, r_out);
        // bore that slides over the rim
        translate([0, 0, -eps]) linear_extrude(height = lap + 0.3 + eps)
            prof(iw + 2*(spig_t + fit), it + 2*(spig_t + fit),
                 r_in + spig_t + fit);
        // rest of the cavity
        translate([0, 0, -eps]) linear_extrude(height = cap_len - floor_t + eps)
            prof(iw, it, r_in);
        // grooves the beads click into
        if (snap) for (s = [-1, 1])
            translate([0, s*bead_y, lap/2]) rotate([0, 90, 0])
                cylinder(r = bead_r + 0.1, h = bead_len + 1, center = true, $fn = 32);
        if (engrave) cap_marks();
    }
}

// ==== output =========================================================
if (show == "body") body();
else if (show == "cap") translate([0, 0, cap_len]) rotate([180, 0, 0]) cap();
else if (show == "assembled") {
    body();
    translate([0, 0, z_sh]) cap();
}
else {
    body();
    translate([ow + 8, 0, cap_len]) rotate([180, 0, 0]) cap();
}
