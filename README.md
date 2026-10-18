# CAD Designs

Parametric part designs by Baelyn Blackmore, Software Engineer / CAD Designer.
Contact: baelyn.k.blackmore112895@outlook.com

Everything here is designed in OpenSCAD and printed in PLA on FDM printers. The `.scad` files are fully parametric: open one, change the numbers at the top, and press F5 to preview.

## Designs

### 1. USB Drive Case
![USB drive case](images/usb_drive_case.png)

A two piece case for a USB stick. The drive drops into the body and the cap slides over a stepped rim and clicks on two small beads.

* Outside size: 28 x 17 x 63 mm
* Fit numbers (drive length, width, thickness) are parameters at the top of the file. Measure your own drive with calipers.
* Engraved on all faces, with the engraving depth and line width as parameters
* Prints with no supports: body standing on its floor, cap standing on its roof
* Print settings: 3 walls, 0.2 mm layers

Source: [`designs/usb_drive_case/usb_drive_case_v2_2.scad`](designs/usb_drive_case/usb_drive_case_v2_2.scad)

### 2. Aquarium Light Holder
![Aquarium light holder](images/aquarium_light_holder.png)

A printed holder for an aquarium light, with two open truss rails, a framed web between them, and a hook that clamps over the glass. This is the sixth version, redesigned after stress testing a print to failure.

* What failed: one whole rail tore off along a layer line where the cross members meet it
* The fix: four hidden M4 threaded rods run through the cross members, with a nut sunk into each rail face, so steel carries the loads that used to pull the layers apart
* Hardware: 4 x M4 threaded rod cut to 108 mm, 8 x M4 nuts
* Clamp screws moved up and seated in captive nuts, which cuts the bending force on the leg
* Print on its side, one rail flat on the bed, so every loaded member has its layers running along it

Source: [`designs/aquarium_light_holder/light_holder_v6_pentagram_2.scad`](designs/aquarium_light_holder/light_holder_v6_pentagram_2.scad)

### 3. Lattice Basket
![Lattice basket](images/basket.png)

A woven lattice basket with a solid rim and ribbed rings.

* Size: 175 x 175 x 150 mm
* Mesh: 248,540 triangles

Model: [`designs/basket/Basket_final.stl`](designs/basket/Basket_final.stl)

## How to use the files

1. Install [OpenSCAD](https://openscad.org) (free).
2. Open a `.scad` file.
3. Press **F5** to preview, **F6** to render, then **File, Export, Export as STL**.
4. Slice the STL in your slicer and print.

STL files, like the basket, can go straight into a slicer.

## Notes

Extra reference notes are in the [`notes`](notes) folder.

## Repository layout

```
3Ddesigns/
  README.md
  designs/
    usb_drive_case/
    aquarium_light_holder/
    basket/
  images/
  notes/
```
