# Sheet-metal variant (untested)

> [!WARNING]
> **Untested and early stage.** These plates have not been cut or fitted yet. Check the points below against your real hardware before ordering.

Flat plates as an alternative to some of the inner aluminium extrusions. The outer extrusion frame stays as it is. All parts are **flat cuts only (no bending)** from **AlMg3 / EN AW-5754, 3 mm**, so any laser, waterjet or CNC milling service can make them.

| File | Part | Qty | Size | Weight |
|---|---|---:|---|---|
| `base-plate_AlMg3_3mm.*` | **Base plate** for mainboard and both PSUs. It sits on the base frame and replaces 4 inner extrusions, the printed PSU holders and the printed board standoffs. | 1 | 430 × 500 mm | ~1.6 kg |
| `fan-panel-120_AlMg3_3mm.*` | **Fan panel** for 3 × 120 mm fans. It screws to the corner posts only, so panels **stack on a 120 mm grid**: two panels fill the GPU level (6 fans). Instead of round openings it has a **honeycomb field** (5 mm hexagons, 2 mm web, 685 cells) inside the rectangle of the outer fan screw holes, plus paired cable-tie slots. | 2 | 430 × 120 mm | ~0.18 kg |

Each part comes as:

- `.dxf` for cutting
- `.svg` preview
- `_holes.csv` hole table with the purpose of each hole
- `.step` 3D file

## Notes for the cutting service

- **DXF:** R12 (AC1009), mm, 1:1, origin bottom left; closed contours; circles as CIRCLE, arcs as ARC.
- **Layers:** `CUT` (everything to cut) and `ENGRAVE` (part label, optional).
- **Inside corners:** R3, OK for cutters up to Ø6 mm.
- **Holes:**
  - Ø4.5 for M4 (frame, fans)
  - Ø3.4 for M3 (mainboard)
  - Ø4.0 for #6-32 (PSU)
  - slots 20 × 3.4 mm (M.2 riser)
  - cable-tie slots 3 × 8 mm in pairs, 12 mm apart
- **Honeycomb (fan panel):** the 2 mm web is thinner than the 3 mm sheet. Ask your cutting service whether that works; otherwise widen the web to 3 mm (`honeycomb(..., w=3.0)` for the fan panel in the generator) or cut the fan panel from 2 mm sheet.
- **Tolerance and finish:** ±0.2 mm is fine. Deburr; anodising is optional.

## How it changes the build (vs. the current extrusion-only version)

- **Extrusions and brackets:** −5 × 390 mm extrusions (board rails 1/2/4 and both front fan rails) and −10 corner brackets. The base plate carries board and PSUs on its own support rails (see next point), so the board and PSU rail positions of the main design don't apply here.
- **Support rails:** the two remaining support rails under the base plate move to Y 180 and Y 370, so all screws from below stay reachable.
- **Printed parts:** no mainboard tray and no PSU feet; the 4 printed M.2-riser standoffs are replaced by brass standoffs too. The 6th-GPU holder shrinks to a small bracket stop.
- **Standoffs:** +16 M3 × 10 mm brass standoffs (female/female) with M3×6 screws from below.
- **Panels to frame:** +30 M4×8 (DIN 7984) with T-nuts: 22 for the base plate, 4 per fan panel.
- **Fans:** fans are mounted to the panels with M4×35 + nut.
- **Top-front brackets:** the two front corner brackets of the top frame move from below the front member into the horizontal top-frame corner (front member to side member), so they don't block the upper fan row. Mainboard, PSUs and the 6th GPU sit 3 mm higher; all cable routes are re-checked.
- **PSUs:** screwed from below through the base plate with their own #6-32 screws. The large cut-out under each PSU lets the exhaust out (the ZEUS blows out of its ATX rear face, which points down) and leaves room for the power plug.
- **Not yet carried over:** the PSU-fan fix from the main design (rear rails moved above the PSUs) is not applied to this variant yet.

**Assembly order (new build only):** the one-piece base plate has to go onto the base frame **before** the posts, mid frame and top frame are joined. It does not fit through the mid-frame opening.

## Check before cutting

- **Mainboard holes:** the 12 hole positions are taken from the board layout image (±3 mm). Verify them against the real ASRock ROMED16QM3 or its drawing.
- **ATX PSU hole pattern:** taken from an unofficial source (138 mm top span, asymmetric bottom holes) and drilled mirrored as well. Measure your PSU.
- **M.2 riser and 6th-GPU riser holes:** placeholders.
- **Fan panels:** there are exactly 240 mm between the mid frame and the top frame for two fan rows, which leaves no margin. If your frame comes out a little short, use one panel or raise the top frame by 1–2 mm.
