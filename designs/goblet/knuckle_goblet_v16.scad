// =====================================================================
// Knuckle goblet v16 (g21). v15 with the boxy cradle blocks rounded into flared collars.
// Knuckle goblet v15 (g20). MINTZ, THREE CLICK-LOCK PIECES.
//   part = "base"     foot + cradle. Print as is, flat on the foot.
//   part = "handle"   Mintz handle, laid flat like the original. One colour.
//   part = "cup"      bowl + cradle, printed UPSIDE DOWN on the rim.
//   part = "assembly" everything in place, for checking only.
// The bottom and top finger loops drop into U-shaped cradles. Two nubs
// on each cradle wall click into dimples on the handle faces.
// Snap tuning (printed mm): fit, nub_out, dimple_d below.
// Knuckle goblet v14 (g19). MINTZ. The stem/handle is the client's Mintz
// knuckle handle, imported exactly as designed (mintz_handle.stl, from
// Mintz.fpp, printed size, stood upright: pinky loop at the bottom, index
// at the top, palm bar on +X). Cup and base as v12/v13.
// Keep mintz_handle.stl next to this file.
// Knuckle goblet v13 (g18). v12 with the ORIGINAL finger holes from the
// Mintz brass knuckle model (FlashPrint project, right hand), measured:
//   pinky 21.0, ring 22.8, middle 24.6, index 24.0 mm
//   centre to centre 24.0, 26.38, 26.96 mm
// Pinky at the bottom, index at the top next to the bowl.
// Stem plate 16 mm thick, same as the original.
// Knuckle goblet v12 (g17). Based on v11.
//   * whole goblet 15% smaller than the g16 print (which was 75% of v11)
//   * finger holes kept at the g16 printed size: 23.4 mm
//   * sturdier: thicker loop walls, thicker stem plate, guard bar, neck,
//     bowl wall, bowl floor and foot
//   * two colours:
//       green  handle (stem, loops, guard bar, spikes) + every marking
//              on the cup and base (letters, skull, marigolds, flags...)
//       white  cup and base + every marking on the handle
//
// All numbers below are in v11 design units. The finished part is
// scaled by k at the end, so printed size = number * k.
// Load both STLs in Bambu Studio as ONE object with parts, 100% scale.
// =====================================================================

use <PirataOne-Regular.ttf>

/* [Output] */
col  = "white";        // [white, green, all]
part = "assembly";     // [base, handle, cup, assembly]
k    = 0.6375;         // 0.75 (g16 print) * 0.85

holes_mm = [21.0, 22.8, 24.6, 24.0];   // pinky, ring, middle, index (printed)
pitch_mm = [24.0, 26.38, 26.96];       // centre to centre (printed)

/* [Bowl] */
rim_d      = 225;
cup_d_low  = 36;
bowl_angle = 43;
lip_h      = 6;
bowl_wall  = 5.65;  // 3.6 mm printed (g16 was 3.3)
bowl_floor = 8;
collar_h   = 10;

/* [Stem] */
rings      = 4;
function hd(i) = holes_mm[i] / k;
function rd(i) = (holes_mm[i] + 12) / k;          // 6 mm loop wall printed
function zc(i) = z_r0 + (i == 0 ? 0 : sum_to(i) / k);
function sum_to(i) = i == 0 ? 0 : pitch_mm[i-1] + sum_to(i-1);
hole_d     = max(holes_mm) / k;      // used for clearances only
ring_d     = (max(holes_mm) + 12) / k;
stem_t     = 16 / k;                 // 16 mm plate, same as the original
bar_gap    = 17;
bar_w      = 7 / k;                  // 7 mm guard bar (g16 was 6)
spike_l    = 14;
spike_r    = 6;
neck_d     = 10 / k;                 // 10 mm: matches the Mintz plate thickness

/* [Foot] */
foot_d     = 168;
foot_h     = 6.3;
foot_cone  = 8;
bead_h     = 3;

/* [Engraving] */
depth      = 2.5;
stroke     = 2.6;
bar_to_foot = true;

/* [Name] */
line_1     = "Casa Laura";
line_2     = "Tacos and Tequila";
text_size  = 16.5;
char_pitch = 17.2;
font       = "Pirata One";
text_bold  = 0.3;
text_z1    = 0.75;
text_z2    = 0.57;

/* [Dia de Muertos] */
skull_h    = 50;
flower_d   = 44;
m          = 0.9;
m_fn       = 24;

$fn    = 64;
big_fn = 128;
eps    = 0.01;

// ==== derived ========================================================
z_foot  = foot_h + foot_cone + bead_h;
z_r0    = z_foot + 3 + rd(0)/2;
z_rN    = zc(rings - 1);
z_stem  = z_rN + rd(rings - 1)/2;
handle_h = 109.81 / k;                 // Mintz handle height, printed 109.81 mm
z_bowl  = z_foot - 1/k + handle_h - 1/k + collar_h;
bar_x   = ring_d/2 + bar_gap + bar_w/2;
cone_h  = (rim_d/2 - cup_d_low/2) / tan(bowl_angle);
bowl_h  = cone_h + lip_h;
total_h = z_bowl + bowl_h;
function r_at(z) = cup_d_low/2 + z * tan(bowl_angle);

echo(str("PRINTED: ", total_h*k, " mm tall, rim ", rim_d*k, ", foot ", foot_d*k,
         ", holes ", holes_mm, ", stem ", stem_t*k));

// ==== 2D motifs ======================================================
module outline(w = stroke) { difference() { children(); offset(delta = -w) children(); } }
module petal_2d(l, w) {
    hull() { translate([0, l - w/2]) circle(d = w, $fn = m_fn); circle(d = 0.3, $fn = 6); }
}
module diamond_2d(s) { rotate(45) square(s, center = true); }
module spiral_2d(r_max, turns, w = stroke) {
    pts = [for (t = [0 : 15 : 360*turns]) (r_max * t / (360*turns)) * [cos(t), sin(t)]];
    for (i = [0 : len(pts) - 2]) hull() {
        translate(pts[i]) circle(d = w, $fn = 10);
        translate(pts[i + 1]) circle(d = w, $fn = 10);
    }
}
module heart_2d(s) {
    for (sx = [-1, 1]) hull() {
        translate([sx*s/4, s/4]) circle(r = s/4, $fn = m_fn);
        translate([0, -s/2]) circle(r = 0.3, $fn = 6);
    }
}
module skull_2d(H) {
    w = stroke;
    outline(w) union() {
        translate([0, 0.10*H]) circle(r = 0.40*H, $fn = 72);
        hull() {
            for (sx = [-1, 1]) translate([sx*0.14*H, -0.38*H]) circle(r = 0.10*H, $fn = 36);
            for (sx = [-1, 1]) translate([sx*0.20*H, -0.10*H]) circle(r = 0.10*H, $fn = 36);
        }
    }
    for (sx = [-1, 1]) translate([sx*0.17*H, 0.10*H]) {
        circle(r = 0.0625*H, $fn = m_fn);
        for (q = [0 : 7]) rotate(q*45) translate([0, 0.1025*H]) circle(r = 0.0275*H, $fn = 12);
    }
    translate([0, -0.09*H]) rotate(180) heart_2d(0.13*H);
    hull() for (sx = [-1, 1]) translate([sx*0.17*H, -0.30*H]) circle(d = w, $fn = 10);
    for (q = [-3 : 3]) hull() for (sy = [-1, 1])
        translate([q*0.05*H, -0.30*H + sy*0.045*H]) circle(d = w, $fn = 10);
    for (q = [-1 : 1]) translate([q*0.08*H, -0.41*H]) circle(r = max(0.02*H, w*0.6), $fn = 12);
    translate([0, 0.34*H]) {
        circle(r = 0.03*H, $fn = 12);
        for (q = [0 : 5]) rotate(q*60) translate([0, 0.07*H]) circle(r = 0.03*H, $fn = 12);
    }
    for (sx = [-1, 1]) translate([sx*0.17*H, -0.15*H]) mirror([sx < 0 ? 1 : 0, 0])
        spiral_2d(0.06*H, 1.1, w);
}
module marigold_2d(d) {
    for (q = [0 : 11]) rotate(q*30) translate([0, d*0.17]) outline() petal_2d(d*0.33, d*0.17);
    for (q = [0 : 7]) rotate(q*45 + 22.5) translate([0, d*0.06]) petal_2d(d*0.11, d*0.07);
    circle(d = d*0.1, $fn = m_fn);
}
module vine_2d(flip = false) {
    mirror([flip ? 1 : 0, 0]) {
        spiral_2d(11*m, 1.5);
        for (a = [20, 150, 265]) rotate(a) translate([0, 13*m]) petal_2d(8*m, 4.5*m);
    }
}
module scallop_2d() {
    r = 8*m;
    difference() { circle(r = r, $fn = 36); circle(r = r - stroke, $fn = 36); translate([-r-1, -2*r]) square([2*r+2, 2*r]); }
    translate([0, 2.2*m]) circle(d = 3.6*m, $fn = 12);
}
module sparkle_2d(sz) {
    for (a = [0, 90]) rotate(a) hull() {
        translate([0,  sz/2]) circle(d = 0.7/k*0.75, $fn = 8);
        translate([0, -sz/2]) circle(d = 0.7/k*0.75, $fn = 8);
        circle(d = sz*0.3, $fn = 12);
    }
}
module cross_2d(sz) {
    w = max(stroke, sz*0.22);
    translate([-w/2, -sz*0.6]) square([w, sz*1.1]);
    translate([-sz*0.35, sz*0.12]) square([sz*0.7, w]);
}
module flag_2d(sz, span) {
    translate([-span/2, -stroke*0.4]) square([span, stroke*0.8]);
    difference() {
        polygon([[-sz/2, 0], [sz/2, 0], [sz/2, -sz*0.85], [0, -sz*1.1], [-sz/2, -sz*0.85]]);
        translate([0, -sz*0.45]) diamond_2d(sz*0.3);
    }
}

// ==== bowl ===========================================================
module bowl_outline_2d(x_min = 0, top = 0) {
    polygon([[x_min, 0], [cup_d_low/2, 0], [rim_d/2, cone_h],
             [rim_d/2, bowl_h + top], [x_min, bowl_h + top]]);
}
module bowl_wall_2d() {
    intersection() {
        difference() {
            bowl_outline_2d();
            intersection() {
                offset(delta = -bowl_wall) bowl_outline_2d(-16, 16);
                translate([-35, bowl_floor]) square([400, 400]);
            }
        }
        square([400, 400]);
    }
}
module skin_2d() {
    intersection() {
        difference() {
            offset(delta = 1.5) bowl_outline_2d();
            offset(delta = -depth) bowl_outline_2d(-16, 16);
        }
        translate([cup_d_low/2 + 2, 2]) square([400, cone_h - 2.5]);
    }
}
module on_bowl(ang, z, half) {
    rotate([0, 0, ang]) intersection() {
        rotate([0, 0, -90 - half]) rotate_extrude(angle = 2*half, $fn = big_fn) skin_2d();
        translate([0, -r_at(z), z]) rotate([bowl_angle, 0, 0]) rotate([90, 0, 0])
            linear_extrude(height = 2*depth + 8, center = true) children();
    }
}
function half_at(w, z) = w / r_at(z) * 180 / PI + 1.5;
module wrap_text(t, z) {
    kk = r_at(z) / (rim_d/2 - 3);
    s = text_size * kk;
    step = char_pitch * kk / r_at(z) * 180 / PI;
    for (i = [0 : len(t) - 1]) if (t[i] != " ")
        on_bowl((i - (len(t) - 1)/2) * step, z, half_at(s * 0.7, z))
            offset(r = text_bold) text(t[i], size = s, font = font, halign = "center", valign = "baseline");
}
module bowl_marks() {
    wrap_text(line_1, cone_h * text_z1);
    wrap_text(line_2, cone_h * text_z2);
    z_rim = cone_h - 6; z_dots = cone_h - 13; z_mid = cone_h * 0.60;
    z_low = cone_h * 0.29; z_bot = cone_h * 0.15; z_flag = cone_h * 0.47;
    for (q = [0 : 35]) on_bowl(q*10, z_rim, half_at(8.5*m, z_rim)) scallop_2d();
    for (q = [0 : 47]) on_bowl(q*7.5 + 3.75, z_dots, half_at(2.5*m, z_dots)) circle(d = 4*m, $fn = 12);
    for (q = [0 : 7]) on_bowl(q*45, z_low, half_at(4*m, z_low)) translate([0, -7*m]) petal_2d(14*m, 7*m);
    for (q = [0 : 7]) on_bowl(q*45 + 22.5, z_low, half_at(4*m, z_low)) diamond_2d(5.5*m);
    for (q = [0 : 11]) on_bowl(q*30 + 15, z_bot, half_at(3*m, z_bot)) circle(d = 4.5*m, $fn = 12);
    on_bowl(180, z_mid, half_at(skull_h * 0.45, z_mid)) skull_2d(skull_h);
    for (s = [-1, 1]) {
        on_bowl(s*112, z_mid + 4, half_at(flower_d/2, z_mid + 4)) marigold_2d(flower_d);
        on_bowl(s*145, z_mid, half_at(16*m, z_mid)) vine_2d(s > 0);
    }
    // former white set, now also green on the white cup
    for (q = [0 : 35]) on_bowl(q*10 + 5, z_rim + 2*m, half_at(3, z_rim)) sparkle_2d(5*m);
    for (q = [0 : 15]) on_bowl(q*22.5 + 11.25, z_low, half_at(3, z_low)) sparkle_2d(6*m);
    for (q = [0 : 11]) on_bowl(q*30, z_bot, half_at(3, z_bot)) cross_2d(6*m);
    step = 12;
    span = r_at(z_flag) * step * PI / 180;
    for (a = [-72 : step : 72]) on_bowl(a, z_flag, half_at(span/2 + 1, z_flag)) flag_2d(9*m, span);
}
module bowl_blank() {
    rotate_extrude($fn = big_fn) bowl_wall_2d();
    translate([0, 0, -collar_h - eps])
        cylinder(d1 = neck_d, d2 = cup_d_low, h = collar_h + 2*eps, $fn = big_fn);
}

// ==== stem (handle) ==================================================
module stem_2d() {
    difference() {
        union() {
            for (i = [0 : rings - 1]) translate([0, zc(i)]) circle(d = rd(i), $fn = 96);
            hull() for (z = [z_r0 - 6, z_rN + 6]) translate([bar_x, z]) circle(d = bar_w);
            if (bar_to_foot) translate([bar_x - bar_w/2, foot_h - 1]) square([bar_w, z_r0 - 6 - foot_h + 1]);
            for (z = [z_r0, z_rN]) hull() {
                translate([0, z]) circle(d = bar_w + 3);
                translate([bar_x, z + sign(z - (z_r0 + z_rN)/2) * 4]) circle(d = bar_w);
            }
            // extra bridge to the guard bar at the middle loops: sturdier
            for (i = [1 : rings - 2]) hull() {
                translate([rd(i)/2 - 4, zc(i)]) circle(d = bar_w);
                translate([bar_x, zc(i)]) circle(d = bar_w);
            }
            translate([-neck_d/2, z_foot - 1]) square([neck_d, z_r0 - z_foot + 1]);
            translate([-neck_d/2, z_rN])       square([neck_d, z_stem - z_rN + 1]);
        }
        for (i = [0 : rings - 1]) translate([0, zc(i)]) circle(d = hd(i), $fn = 96);
    }
}
module stem_pattern_2d() {
    for (i = [0 : rings - 1]) translate([0, zc(i)])
        for (side = [90, 270], a = [-36, -18, 0, 18, 36])
            rotate(side + a) translate([0, hd(i)/2 + 1.5])
                petal_2d((rd(i) - hd(i))/2 - 3, max(3, 4.5*m*1.2));
    n = floor((z_rN - z_r0) / 12);
    for (q = [0 : n]) translate([bar_x, z_r0 + q * (z_rN - z_r0) / n]) diamond_2d(bar_w * 0.55);
    // sparkles below the pinky loop and above the index loop only:
    // the webs between the original holes are too thin for markings
    translate([0, z_r0 - hd(0)/2 - (rd(0) - hd(0))/4]) sparkle_2d(6);
    translate([0, z_rN + hd(rings-1)/2 + (rd(rings-1) - hd(rings-1))/4]) sparkle_2d(6);
}
module stem_marks() {
    for (s = [-1, 1])
        translate([0, s * (stem_t/2 + 1), 0]) rotate([90, 0, 0])
            translate([0, 0, s > 0 ? 0 : -(depth + 1)]) linear_extrude(height = depth + 1) stem_pattern_2d();
}
module stem_blank() {
    rotate([90, 0, 0]) linear_extrude(height = stem_t, center = true) stem_2d();
    for (i = [0 : rings - 1]) translate([-rd(i)/2 + 1, 0, zc(i)])
        rotate([0, -90, 0]) cylinder(r1 = spike_r, r2 = 0, h = spike_l, $fn = 4);
}

// ==== foot ===========================================================
module foot_profile_2d(x_min = 0) {
    polygon([[x_min, 0], [foot_d/2, 0], [foot_d/2, foot_h],
             [neck_d/2 + 11, foot_h + foot_cone], [x_min, foot_h + foot_cone]]);
}
module foot_blank() {
    rotate_extrude($fn = big_fn) foot_profile_2d();
    translate([0, 0, foot_h + foot_cone - eps])
        cylinder(d1 = neck_d + 22, d2 = neck_d + 8, h = bead_h, $fn = big_fn);
}
module foot_marks() {
    r_in = neck_d/2 + 13; r_out = foot_d/2 - 5;
    intersection() {
        rotate_extrude($fn = big_fn) intersection() {
            difference() { offset(delta = 1) foot_profile_2d(); offset(delta = -depth) foot_profile_2d(-10); }
            translate([r_in - 2, foot_h * 0.5]) square([r_out - r_in + 4, 40]);
        }
        linear_extrude(height = 40) {
            for (q = [0 : 15]) rotate(q*22.5) {
                translate([0, r_in + (r_out - r_in)*0.42]) outline() petal_2d((r_out - r_in)*0.58, 10*m*1.5);
                translate([0, r_in]) petal_2d((r_out - r_in)*0.38, 6*m*1.5);
            }
            for (q = [0 : 15]) rotate(q*22.5 + 11.25) translate([0, r_out - 5]) circle(d = 3.5, $fn = 16);
            for (q = [0 : 15]) rotate(q*22.5 + 11.25) translate([0, r_in + (r_out - r_in)*0.62]) sparkle_2d(7*m);
        }
    }
}

// ==== three piece click lock (all printed mm) ==========================
fit      = 0.2;     // gap each side between handle and cradle
wall     = 3.2;     // cradle wall thickness
cradle_h = 8;       // how far the loop sits down in each cradle
floor_t  = 2;       // cradle floor under the loop
nub_out  = 0.45;    // how far each nub sticks out of the wall
nub_d    = 2.4;
dimple_d = 2.8;     // dimple in the handle face, a little bigger than the nub
plate_y0 = -4.9;    // handle plate faces (from the Mintz mesh)
plate_y1 = 4.72;
r_bot    = 16.5;    // pinky loop outer radius, centre 16.5 above handle bottom
r_top    = 18.0;    // index loop outer radius, centre 18.0 below handle top
H        = 109.81;  // Mintz handle height
nub_x    = 6;       // nubs at x = +-6, nub_z above the loop bottom / below loop top
nub_z    = 4.5;
flare    = 5;       // collar flare where it meets the foot / cup
flare_h  = 5;       // height of that flare

y_mid = (plate_y0 + plate_y1) / 2;
slot  = plate_y1 - plate_y0 + 2*fit;
z_ft  = z_foot * k;            // top of the foot
z_hb  = z_ft + floor_t;        // handle bottom
z_ht  = z_hb + H;              // handle top
z_cb  = z_ht + floor_t;        // top of the cup cradle block
z_bw  = z_cb + collar_h * k;   // bowl bottom
echo(str("PRINTED: assembled height ", z_bw + bowl_h*k));

module rbox(x0, x1, y0, y1, z0, z1, r = 3) {
    hull() for (x = [x0 + r, x1 - r], y = [y0 + r, y1 - r])
        translate([x, y, z0]) cylinder(r = r, h = z1 - z0, $fn = 32);
}
// U cradle: block minus the loop shape (+fit), open on top (dir = 1) or bottom (dir = -1)
module cradle(zc, r, z_floor, dir) {
    xw = r + wall;
    z0 = dir > 0 ? z_floor - floor_t : z_floor - cradle_h;
    z1 = dir > 0 ? z_floor + cradle_h : z_floor + floor_t;
    yw0 = y_mid - slot/2 - wall; yw1 = y_mid + slot/2 + wall;
    za  = dir > 0 ? z0 : z1;              // end that joins the foot / cup
    zf  = dir > 0 ? z1 : z0;              // free end, where the handle enters
    difference() {
        // rounded collar: flares out where it meets the foot / cup,
        // soft rounded rim where the handle goes in
        hull() {
            rbox(-xw - flare, xw + flare, yw0 - flare, yw1 + flare,
                 min(za, za + dir*1), max(za, za + dir*1), r = 6);
            rbox(-xw, xw, yw0, yw1,
                 min(za + dir*flare_h, zf - dir*2), max(za + dir*flare_h, zf - dir*2), r = 4);
            rbox(-xw + 1.5, xw - 1.5, yw0 + 1.5, yw1 - 1.5,
                 min(zf, zf - dir*2), max(zf, zf - dir*2), r = 3);
        }
        // loop pocket
        translate([0, y_mid, zc]) rotate([90, 0, 0])
            cylinder(r = r + fit, h = slot, center = true, $fn = 128);
        // open slot above / below the loop so it can drop in
        translate([-r - fit, y_mid - slot/2, dir > 0 ? zc : zc - 50]) cube([2*(r + fit), slot, 50]);
    }
    // nubs on both walls
    for (sx = [-1, 1], sy = [-1, 1])
        translate([sx*nub_x, y_mid + sy*(slot/2 + nub_d/2 - nub_out), z_floor + dir*nub_z])
            sphere(d = nub_d, $fn = 24);
}
module base_body() {
    scale(k) foot_blank();
    cradle(z_hb + r_bot, r_bot, z_hb, 1);
}
module cup_body() {
    translate([0, 0, z_bw]) scale(k) bowl_blank_shifted();
    cradle(z_ht - r_top, r_top, z_ht, -1);
}
module bowl_blank_shifted() {   // bowl with collar, local z = 0 at bowl bottom
    rotate_extrude($fn = big_fn) bowl_wall_2d();
    translate([0, 0, -collar_h - eps])
        cylinder(d1 = (slot + 2*wall) / k, d2 = cup_d_low, h = collar_h + 2*eps, $fn = big_fn);
}
module handle_body() {
    difference() {
        translate([0, 0, z_hb]) import("mintz_handle.stl", convexity = 10);
        for (sx = [-1, 1], y = [plate_y0, plate_y1], z = [z_hb + nub_z, z_ht - nub_z])
            translate([sx*nub_x, y, z]) sphere(d = dimple_d, $fn = 24);
    }
}
module foot_marks_mm() { scale(k) foot_marks(); }
module bowl_marks_mm() { translate([0, 0, z_bw]) scale(k) bowl_marks(); }

module base_piece(c) {
    if (c == "white" || c == "all") difference() { base_body(); if (c == "white") foot_marks_mm(); }
    if (c == "green") intersection() { scale(k) foot_blank(); foot_marks_mm(); }
}
module cup_piece(c) {
    if (c == "white" || c == "all") difference() { cup_body(); if (c == "white") bowl_marks_mm(); }
    if (c == "green") intersection() { translate([0, 0, z_bw]) scale(k) bowl_blank_shifted(); bowl_marks_mm(); }
}

if (part == "base")   base_piece(col);
if (part == "cup")    // upside down on the rim
    translate([0, 0, z_bw + bowl_h*k]) rotate([180, 0, 0]) cup_piece(col);
if (part == "handle") // laid flat on its plate face, palm bar up, like the original
    translate([0, 0, -plate_y0]) rotate([90, 0, 0]) translate([0, 0, -z_hb]) handle_body();
if (part == "assembly") { base_piece("all"); cup_piece("all"); handle_body(); }
