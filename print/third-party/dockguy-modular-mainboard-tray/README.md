# Mainboard tray (third party): DockGuy, Modular ITX…XL-ATX mainboard frame/tray

These STL files are **not part of this project's design**. They are the unmodified v3.11 files of
[Modular ITX/DTX/mATX/ATX/SSI-EEB/SSI-CEB/EATX/XL-ATX mainboard frame/tray](https://www.printables.com/model/35720)
by **DockGuy**. They are redistributed here under the original **BSD License** (see [`LICENSE`](LICENSE)),
**not** under this repository's CERN-OHL-P licence. Please give the original a like.

## Use in this build

For the SSI-EEB board (ASRock Rack ROMED16QM3, 305 × 330 mm) print the six EATX parts:

| File | Qty | Size (mm) |
|---|---:|---|
| `stl/mainboard-itx-v311.stl` | 1 | 170.3 × 171.6 × 10 |
| `stl/mainboard-dtx-v31.stl` | 1 | 170.3 × 72.2 × 10 |
| `stl/mainboard-atx1-v31.stl` | 1 | 134.5 × 171.6 × 10 |
| `stl/mainboard-atx2-v31.stl` | 1 | 134.5 × 72.2 × 10 |
| `stl/mainboard-eatx1-original-v31.stl` | 1 | 134.5 × 86.4 × 10 |
| `stl/mainboard-eatx2-original-v31.stl` | 1 | 170.3 × 86.4 × 10 |

- **Variant:** `eatx1/eatx2-trimmed` are 1.85 mm shorter, which moves the last standoff row 1.85 mm closer to the joint; the author says some boards need this. Check with a quick low-infill test print against the real board before printing the final parts.
- **Fasteners:** 7 × M4 bolt + nut + 2 washers join the parts (measure the length in your slicer, about M4×20–25). The board sits on 12 × M3×6×6 brass standoffs pressed into the 3.25 mm holes and is held by M3×5 screws.
- **Mounting in this frame:** the tray lies on the board rails, rotated 180° with the I/O edge at the front (Y 20), top face at Z 30. Its M4 holes are at X 39.5 / 170.8 / 209.8 / 295.3 and Y 43.2 / 172.1 / 211.1 / 244.3 / 283.3 / 331.6. Board rails 1, 3 and 4 are positioned to match three of these rows, so 12 × DIN 7984 M4×16 with washers go into the T-nuts. The board sits 6 mm higher than with the printed 8×10 standoffs it replaces.
- **Print:** PETG, flat, top face (with the wider standoff holes) up, at least 3 perimeters, 20–30 % infill.
