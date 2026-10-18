// =====================================================================
// Aquarium light holder, HG 978 style, printed
// v6 TIE ROD. Same look as v5: two open truss rails, a framed web with
// the names on its two bands, a solid panel joining the outer hook legs.
// Insignia on the web disc is a pentagram (was the cog).
//
// WHY v6: the v5 print was brute tested and one whole rail tore off. All
// four cross members (both web bands, the leg panel, the tank side tie)
// let go on the same flat plane, right where they meet that rail. That
// plane is a layer line. Printed on its side, the cross members are the
// only parts whose layers are stacked ACROSS the load, and at 15 % infill
// only two thin walls were holding them.
//
// THE FIX: four hidden M4 threaded rods run the full width, one inside
// each cross member, with a nut at each end sunk into the rail faces.
// Steel now carries every load that used to pull the layers apart, and
// tightening the nuts squeezes the layers together. Nothing shows but
// four small recessed nuts on each side.
//
// HARDWARE: 4 x M4 threaded rod cut to 108 mm, 8 x M4 nuts.
// Hex pockets (captive nut) are on the bed side face, round pockets for
// a 7 mm socket on the other. Snug only: do not crush the plastic.
//
// The web frame is also heavier (16 mm bands, radius 12 window corners).
//
// Built from every earlier file:
//   light_bracket, light_holderv2, light_holder_v3 (hook ties),
//   light_holderv3, v3_1, v3_2, v3_3 (deep web, slot fillets).
//
// Same client fit as v3_3: slot, hook depth, total height, arm length,
// rail gap, 8.5 mm sliding rod and 52 mm of clip travel are unchanged.
//
// What makes it stronger, in order of how much it matters:
//   1. CLAMP SCREWS MOVED UP toward the bridge and seated in captive M4
//      nuts. The lever bending the leg (where the first one broke) drops
//      to under half, and the load goes into the plastic in compression
//      instead of into tapped plastic threads.
//   2. SLOT ROOT: big radius on the leg side corner (the one in tension),
//      small radius on the tank side so the glass still seats flat.
//   3. LEG PANEL: the two outer legs are one plate, foot to rim. They
//      can no longer twist or splay one at a time, and the clamp load
//      is shared. A tie bar does the same job on the tank side.
//   4. TOP CHORD: the rail stays a full square section along the rod line
//      out to the strut tip, then necks to clip size through a radius 8
//      collar. v3_3 stepped to the thin rod with a sharp corner exactly
//      where the free cantilever has its peak moment.
//   5. Every member thicker: rail 14, column 18, leg 16, bridge 18.
//   6. WEB runs the full height to the top of the rails.
//
// Two switches go further but change the look:
//   solid_gusset    = true   fills the strut triangle
//   full_width_hook = true   hook becomes one solid U channel, names move
//                            to its outside face
//
// PRINT IT ON ITS SIDE, one rail flat on the bed (same as the earlier
// prints). Every loaded member then has its layers running along it.
//
// Units: mm.
// =====================================================================

rod_mode    = "printed";   // [printed, socket]

/* [Client dimensions] */
glass_t     = 14;    // slot is oversize on purpose; the screws clamp
slot_clear  = 0.6;
hook_depth  = 30;
total_h     = 91;    // hook bottom to top of rod
arm_len     = 137;   // reach over the water
rail_gap    = 109;   // rail spacing, outside to outside

/* [The rod] */
rod_d       = 8.5;   // sliding section. clip bore minus about 0.4
clip_travel = 52;    // clear sliding length at the tip. same as v3_3
collar_r    = 8;     // radius of the neck down from full size to rod_d
tip_chamfer = 3;
rod_bore_cl = 0.3;   // socket mode only
socket_len  = 40;    // socket mode only

/* [Members] */
rail_t      = 14;    // rail plate thickness, also the top chord size
col_w       = 18;
leg_w       = 18;    // was 16. outer leg and panel 2 mm thicker, outward
bridge_w    = 18;
strut_w     = 12;    // strut width. kept slim so the truss window stays open
fillet      = 7;     // concave fillets on the rail outline
hook_r      = 4;     // outside corner radius of the hook
solid_gusset = true;   // fills the strut triangle

/* [Hook] */
slot_r_out  = 8;     // slot root, leg side. the tension corner
slot_r_in   = 2;     // slot root, tank side. kept small so glass seats
leg_panel   = true;  // solid panel joining the two outer legs
panel_top   = 0;     // top edge of that panel. 0 is rim level, which keeps
                     // the lower name on the web visible from outside
hook_ties   = true;  // tie bar across the rail gap on the tank side
                     // (and on the leg side if leg_panel is off)
tie_h       = 12;
full_width_hook = false;

/* [Clamp screws] */
clamp_screw = true;
clamp_dy    = 20;    // screw height above the bottom of the leg
nut_trap    = true;  // captive M4 hex nut on the slot face of the leg
screw_clear = 4.4;   // M4 clearance, used with the nut trap
screw_pilot = 3.4;   // tap M4 into the plastic, used without it
nut_af      = 7.3;   // M4 nut across flats plus clearance
nut_h       = 3.6;

/* [Name plate] */
name_1      = "OSzity";
name_2      = "OSlith";
name_font   = "DejaVu Sans:style=Bold";
name_size   = 9;
engrave_d   = 7.0;   // etch depth. was 0.6

/* [Crossmember] */
web_t       = 18;    // depth along the arm. flush with the column so the truss window stays visible
web_edge    = 16;    // frame width around the window
web_windows = 1;     // 1 matches the printed one. more adds mullions
web_mullion = 8;
web_r       = 12;

/* [Insignia: pentagram on a disc] */
insignia     = true;
ins_d        = 26;    // pentagram ring diameter
ins_disc_d   = 34;
ins_disc_t   = 7;
ins_depth    = 3.0;   // engraving depth
ins_line     = 2.0;   // line width of the ring and the star
ins_point_up = true;  // false turns it point down

/* [Etched markings] */
// Shallow etch only, so no member loses real section. Everything is kept
// clear of the tie rod pockets, the clamp screws, the slot and the rods.
marks        = true;
mark_d       = 0.6;    // etch depth
mark_line    = 1.2;    // line width of the small symbols
mark_up      = false;  // small pentagrams point down. true turns them up
mark_text    = "AVE SATANAS";   // along each top chord
mark_num     = "666";           // centre of the leg panel

/* [Tie rods] */
// Steel through the cross members, along the print Z. This is what stops
// a rail tearing off along a layer line.
tie_rods    = true;
tie_bore    = 4.5;   // M4 threaded rod clearance
tie_nut_af  = 7.3;   // M4 nut across flats plus clearance
tie_nut_h   = 3.6;   // pocket depth, nut sits flush
tie_sock_d  = 10.5;  // round pocket for a 7 mm socket
tie_round_both = true;  // round pockets on both faces. false puts the
                        // captive hex pockets back on the bed side

$fn = 96;
eps = 0.01;


// ==== derived ========================================================
slot_w      = glass_t + slot_clear;
rod_top     = total_h - hook_depth;
rod_cy      = rod_top - rail_t/2;
foot_y      = -hook_depth;
col_cx      = col_w/2;
x_out       = -(slot_w + leg_w);          // outside face of the leg
r_big       = rail_t/2;
r_clip      = rod_d/2;
slide_start = arm_len - clip_travel;      // clip can come back this far
collar_ang  = acos(1 - (r_big - r_clip)/collar_r);
collar_len  = collar_r * sin(collar_ang);
collar_x0   = slide_start - collar_len;   // full size chord ends here
tip_x       = collar_x0 - r_big;          // centre of the strut tip
free_span   = arm_len - collar_x0;
zc          = [rail_t/2, rail_gap - rail_t/2];   // rail centre planes
web_x0      = col_cx - web_t/2;           // outside face of the web

// Tie rod centres in the rail profile plane: [x, y].
//   web top band, on the top chord centreline (its neutral axis)
//   web bottom band
//   leg panel, below the clamp screws
//   tank side tie bar
tie_pts = [[col_cx,            rod_cy],
           [col_cx,            1 + web_edge/2],
           [x_out + leg_w/2,   foot_y + 8],
           [col_cx,            foot_y + 7]];

assert(r_big - r_clip <= collar_r, "collar_r too small for this rail_t");
assert(slot_r_out + slot_r_in < slot_w, "slot fillets do not fit the slot");

echo(str("Rod at clip: ", rod_d, " mm. Top chord: ", rail_t, " mm"));
echo(str("Clip travel: ", clip_travel, " mm, from x = ", slide_start));
echo(str("Free cantilever past the collar: ", round(free_span), " mm"));
if (tie_rods)
    echo(str("HARDWARE: ", len(tie_pts), " x M4 threaded rod cut to ",
             rail_gap - 1, " mm, ", 2*len(tie_pts), " x M4 nuts"));
echo(str("Leg root section vs v3_3: ",
         round(((full_width_hook ? rail_gap : 2*rail_t) * pow(leg_w, 2))
               / (2 * 13 * pow(14, 2)) * 100), " %"));
echo(str("Screw lever on the leg vs v3_3: ",
         round((hook_depth - clamp_dy - slot_r_out) / (15 - 3.5) * 100),
         " %"));


// ==== helpers ========================================================
module bar(p1, p2, w1, w2 = undef) {
    w2r = is_undef(w2) ? w1 : w2;
    hull() { translate(p1) circle(d = w1); translate(p2) circle(d = w2r); }
}

module rrect(x1, y1, x2, y2, r) {
    hull() for (p = [[x1+r,y1+r],[x2-r,y1+r],[x1+r,y2-r],[x2-r,y2-r]])
        translate(p) circle(r = r);
}


// ==== hook ===========================================================
// Outer leg, bridge over the rim, inner foot of the column.
module hook_block_2d() {
    rrect(x_out, foot_y, col_w, bridge_w, hook_r);
}

// Slot for the glass. The leg side root gets the big radius because the
// clamp screws bend the leg outward and that corner goes into tension.
// The tank side root stays small: the glass is pushed against that face,
// and a big radius there would wedge the rim instead of seating it.
module slot_cut_2d() {
    ri = slot_r_in;
    ro = slot_r_out;
    polygon(concat(
        [[-slot_w - 1.6, foot_y - 1],
         [1.6,           foot_y - 1],
         [0,             foot_y + 4],
         [0,             -ri]],
        [for (t = [0 : 6 : 90])   [-ri + ri*cos(t), -ri + ri*sin(t)]],
        [for (t = [90 : 6 : 180]) [-slot_w + ro + ro*cos(t), -ro + ro*sin(t)]],
        [[-slot_w, foot_y + 4]]));
}


// ==== one side rail ==================================================
// Open truss like the printed one: column, strut, top chord. The top
// chord is the square continuation of the rod and carries on to tip_x.
module rail_2d() {
    difference() {
        offset(r = -fillet) offset(r = fillet)
        union() {
            hook_block_2d();
            rrect(0, foot_y, col_w, rod_top, hook_r);
            // top chord
            bar([col_cx, rod_cy], [tip_x, rod_cy], rail_t);
            // strut, from just above the rim so load goes into the bridge
            bar([col_cx, bridge_w/2 + 2], [tip_x, rod_cy], strut_w);
            if (solid_gusset)
                hull() {
                    translate([col_cx, bridge_w/2 + 2]) circle(d = strut_w);
                    translate([col_cx, rod_top - col_w/2]) circle(d = col_w);
                    translate([tip_x, rod_cy]) circle(d = rail_t);
                }
        }
        slot_cut_2d();
    }
}


// ==== the rod ========================================================
// Revolved profile. Full size inside the top chord, then a concave
// radius down to clip size, then the sliding length.
module rod_profile() {
    s0 = collar_x0   - col_cx;
    s1 = slide_start - col_cx;
    L  = arm_len     - col_cx;
    if (rod_mode == "socket")
        polygon([[0, 0], [r_big, 0], [r_big, s0], [0, s0]]);
    else
        polygon(concat(
            [[0, 0], [r_big, 0]],
            [for (t = [collar_ang : -3 : 0])
                [r_clip + collar_r*(1 - cos(t)), s1 - collar_r*sin(t)]],
            [[r_clip, s1],
             [r_clip, L - tip_chamfer],
             [r_clip - 1.25, L],
             [0, L]]));
}

module rod(z) {
    translate([col_cx, rod_cy, z])
        rotate([0, 90, 0]) rotate_extrude() rod_profile();
}

module rail(z) {
    translate([0, 0, z - rail_t/2]) linear_extrude(height = rail_t) rail_2d();
    rod(z);
}


// ==== across the rail gap ============================================
// Members below the rim that run the whole rail gap. xa..xb picks the leg
// side, the tank side or both. h is the height above the foot.
// Without these the four hook legs are unbraced cantilevers.
module hook_cross(h, xa = x_out - 1, xb = col_w + 1) {
    linear_extrude(height = rail_gap)
        difference() {
            intersection() {
                hook_block_2d();
                translate([xa, foot_y - 1]) square([xb - xa, h + 1]);
            }
            slot_cut_2d();
        }
}

// Framed panel standing in the gap/height plane between the rails.
module web_2d() {
    lo = (full_width_hook ? bridge_w + 4 : 1 + web_edge);
    hi = rod_top - web_edge;
    n  = web_windows;
    w  = (n > 0) ? (rail_gap - 2*web_edge - (n - 1)*web_mullion) / n : 0;
    difference() {
        rrect(-rail_gap, 1, 0, rod_top, 4);
        if (n > 0)
            for (i = [0 : n - 1])
                rrect(-rail_gap + web_edge + i*(w + web_mullion), lo,
                      -rail_gap + web_edge + i*(w + web_mullion) + w, hi,
                      min(web_r, w/2 - 0.5, (hi - lo)/2 - 0.5));
    }
}

module web() {
    translate([web_x0, 0, 0])
        rotate([0, 90, 0])
            linear_extrude(height = web_t) web_2d();
}


// ==== insignia: pentagram ============================================
// Ring plus five point star, on a disc bridging the web window.
function _ins_lo() = (full_width_hook ? bridge_w + 4 : 1 + web_edge);
function _ins_hi() = rod_top - web_edge;
function _ins_pos() = [-rail_gap/2, (_ins_lo() + _ins_hi())/2];

module pentagram_2d(d, w, up = ins_point_up) {
    rc  = d/2 - w/2;
    a0  = up ? 90 : -90;
    pts = [for (k = [0:4]) rc * [cos(a0 + 72*k), sin(a0 + 72*k)]];
    difference() { circle(r = d/2); circle(r = d/2 - w); }
    for (k = [0:4]) bar(pts[k], pts[(k + 2) % 5], w);
}

module insignia_disc() {
    translate([web_x0, 0, 0]) rotate([0, 90, 0])
        linear_extrude(height = ins_disc_t)
            translate(_ins_pos()) circle(d = ins_disc_d);
}

module insignia_cut() {
    translate([web_x0, 0, 0]) rotate([0, 90, 0])
        translate([0, 0, -eps])
            linear_extrude(height = ins_depth + eps)
                translate(_ins_pos()) pentagram_2d(ins_d, ins_line);
}


// ==== cuts ===========================================================
// Names etched into the two bands either side of the web window, reading
// correctly from outside the tank. With the full width hook they move to
// its outside face, because the lower web band is buried.
module name_cut() {
    face = full_width_hook ? x_out : web_x0;
    y1   = full_width_hook ? 4   : rod_top - web_edge/2;
    y2   = full_width_hook ? -14 : 1 + web_edge/2;
    translate([face, 0, 0])
        rotate([0, 90, 0])
            translate([0, 0, -eps])
                linear_extrude(height = engrave_d + eps)
                    for (b = [[name_1, y1], [name_2, y2]])
                        translate([-rail_gap/2, b[1]]) mirror([1, 0, 0])
                            text(b[0], size = name_size, font = name_font,
                                 halign = "center", valign = "center");
}

// Clamp screws through the leg. With nut_trap the nut drops into a hex
// pocket on the slot face, so tightening the screw pulls the nut into
// solid plastic. Hex points face the print Z so the pocket roof is self
// supporting when printed on its side.
module clamp_cut() {
    y = foot_y + clamp_dy;
    for (z = zc) {
        translate([x_out - 1, y, z]) rotate([0, 90, 0])
            cylinder(d = nut_trap ? screw_clear : screw_pilot,
                     h = leg_w + 2);
        if (nut_trap)
            translate([-slot_w - nut_h, y, z]) rotate([0, 90, 0])
                cylinder(d = nut_af / cos(30), h = nut_h + 1, $fn = 6);
    }
}

// Tie rod bores, full width, with a nut pocket in each outside rail face.
// z = 0 is the bed side when printed on its side: hex pockets there hold
// the nuts captive. The far face gets round pockets a socket fits into.
module tie_cut() {
    for (p = tie_pts) translate([p[0], p[1], 0]) {
        translate([0, 0, -1]) cylinder(d = tie_bore, h = rail_gap + 2);
        // bed side: round socket pocket, or the old captive hex
        translate([0, 0, -eps])
            if (tie_round_both)
                cylinder(d = tie_sock_d, h = tie_nut_h + eps);
            else
                cylinder(d = tie_nut_af / cos(30), h = tie_nut_h + eps, $fn = 6);
        translate([0, 0, rail_gap - tie_nut_h])
            cylinder(d = tie_sock_d, h = tie_nut_h + eps);
    }
}

// ==== etched markings ================================================
// Inverted cross, centred on the origin. h tall, w wide.
module inv_cross_2d(h, w, t = mark_line) {
    translate([-t/2, -h/2]) square([t, h]);
    translate([-w/2, -h/2 + 0.22*h]) square([w, t]);
}

// Leviathan cross: double barred cross standing on an infinity loop.
module leviathan_2d(h, w, t = mark_line) {
    r  = w/4;
    cy = -h/2 + r;
    for (s = [-1, 1]) translate([s*(r - t/2), cy])
        difference() { circle(r = r); circle(r = r - t); }
    translate([-t/2, cy]) square([t, h/2 - cy]);
    translate([-0.30*w, h/2 - 0.18*h - t/2]) square([0.60*w, t]);
    translate([-0.50*w, h/2 - 0.40*h - t/2]) square([w, t]);
}

// Puts a 2D drawing on a face that looks away from the tank (normal -x).
// Child coordinates are [z, y] and read correctly from outside.
module out_face(fx, d) {
    translate([fx, 0, 0]) rotate([0, 90, 0]) translate([0, 0, -eps])
        linear_extrude(height = d + eps) mirror([1, 0, 0]) children();
}

// Front of the part: a row along the leg panel, and a Leviathan cross up
// each side band of the web, above the bridge fillet.
module face_mark_cut() {
    zm = rail_gap/2;
    if (leg_panel && !full_width_hook)
        out_face(x_out, mark_d) translate([zm, (foot_y + panel_top)/2 + 1]) {
            text(mark_num, size = 6, font = name_font,
                 halign = "center", valign = "center");
            for (s = [-1, 1]) {
                translate([s*18, 0]) pentagram_2d(14, mark_line, mark_up);
                translate([s*33, 0]) inv_cross_2d(18, 9);
            }
        }
    out_face(web_x0, mark_d)
        for (z = [web_edge/2, rail_gap - web_edge/2])
            translate([z, rod_top - 23]) leviathan_2d(20, 9);
}

// Outside face of each rail, coordinates [x, y]. flip mirrors the text so
// it reads correctly on the bed side face too.
module rail_marks_2d(flip) {
    if (solid_gusset)
        translate([col_cx + 15, rod_cy - 16])
            pentagram_2d(28, 1.6, mark_up);
    translate([(col_cx + tip_x)/2 + 7, rod_cy + 1.5])
        mirror([flip ? 1 : 0, 0, 0])
            text(mark_text, size = 4, font = name_font,
                 halign = "center", valign = "center");
    translate([col_cx, -7]) inv_cross_2d(13, 7);             // column foot
    translate([x_out + leg_w/2, -2]) inv_cross_2d(16, 8);    // outer leg
}

module rail_mark_cut() {
    translate([0, 0, rail_gap - mark_d])
        linear_extrude(height = mark_d + eps) rail_marks_2d(false);
    translate([0, 0, -eps])
        linear_extrude(height = mark_d + eps) rail_marks_2d(true);
}

module socket_cut() {
    for (z = zc)
        translate([collar_x0 + eps, rod_cy, z]) rotate([0, -90, 0])
            cylinder(d = rod_d + rod_bore_cl, h = socket_len);
}


// ==== whole part =====================================================
module holder() {
    difference() {
        union() {
            for (z = zc) rail(z);
            web();
            if (insignia) insignia_disc();
            if (full_width_hook) hook_cross(hook_depth + bridge_w);
            else {
                // leg side: full panel, or a tie bar if the panel is off
                if (leg_panel)
                    hook_cross(panel_top - foot_y, x_out - 1, -slot_w);
                else if (hook_ties)
                    hook_cross(tie_h, x_out - 1, -slot_w);
                // tank side tie bar
                if (hook_ties) hook_cross(tie_h, 0, col_w + 1);
            }
        }
        name_cut();
        if (insignia) insignia_cut();
        if (marks) { face_mark_cut(); rail_mark_cut(); }
        if (clamp_screw) clamp_cut();
        if (tie_rods) tie_cut();
        if (rod_mode == "socket") socket_cut();
    }
}

holder();
