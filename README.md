# DIY AI GPU Server – open 19" frame for 5–6 consumer GPUs (RTX 4090)

An open-hardware **DIY AI / LLM server case** for people who want to run **multiple consumer graphics cards** (RTX 4090 and similar 3-slot cards) in a homelab or a 19" rack. It is built from standard **20×20 aluminium extrusion**, a few 3D-printed parts and **PCIe risers on SlimSAS cables**. Every GPU gets a full x16/x8 link and a clean airflow path, and the whole thing fits into **14U**.

> [!WARNING]
> **Very early stage.** This design has not been built yet. The first physical build and test assembly will happen over the coming weeks, so expect changes to dimensions, parts and cable routes. Please don't order parts based on this version unless you're happy to adapt things yourself.

![Complete build](images/r01-complete-iso-front-left.png)

| | |
|---|---|
| ![Frame only](images/r11-frame-iso-front-left.png) | ![6-GPU option](images/r06-complete-6gpu-iso-front-right.png) |
| Frame with printed parts | Optional 6th GPU on the board level |

## Key specs

- **GPUs:** 5 × RTX 4090 (305 × 61 × 125 mm, 3-slot) above the board, all facing the same way for consistent airflow, 16.8 mm intake gap in front of every card; **optional 6th GPU** on the board level.
- **Connection:** C-Payne PCIe device adapters (x8/x16 BOTTOM rev. 2) and 500 mm round SlimSAS 8i cables. Every route is checked for length (max. 460 mm) and bend radius (≥ 25 mm).
- **Mainboard:** ASRock Rack ROMED16QM3 (AMD EPYC SP3, SSI-EEB), Noctua NH-U14S TR4-SP3, 8 × RDIMM.
- **Power:** 2 × Silverstone ZEUS 1650R, upright, with all 12V-2x6 / EPS / 24-pin routes checked against the stock cable lengths.
- **Frame:** 20×20 I-type slot 5 extrusion. The cut list is only three lengths: 4 × 621, 21 × 390 and 8 × 460 mm. 58 corner brackets.
- **Size:** 430 × 500 × 621 mm (W × D × H, incl. 50 mm feet) = **19", 14U**. It stands on rails or a shelf; printed rack ears are optional.
- **Parametric:** all main dimensions are parameters (`cad/parameters.csv`), so the design adapts to other cards, boards and PSUs.

## Repository layout

| Folder | Content | Open with |
|---|---|---|
| `cad/assembly/` | Full assembly as **STEP AP242** (`diy-ai-gpu-server.step`), frame + printed parts only (`frame-and-printed-parts.step`), **3MF**, **OBJ + MTL with colours** (zipped) | STEP: FreeCAD, Fusion 360, Onshape, SolidWorks, Inventor, Creo, Solid Edge, Rhino, KiCad (3D viewer) · 3MF: PrusaSlicer, Bambu Studio, OrcaSlicer, Cura, Windows 3D Viewer · OBJ: Blender, MeshLab, any 3D viewer |
| `cad/parts/` | Extrusions (390 / 460 / 621 mm) and the corner bracket as STEP | any CAD |
| `cad/parameters.csv` | All driving dimensions (names + expressions) | spreadsheet |
| `cad/source/` | Native, fully parametric source (`.solidcraft`, SolidCraft) | SolidCraft |
| `print/stl`, `print/3mf`, `print/step` | Every printed part, one file per part type | slicer / CAD |
| `drawings/dxf`, `drawings/svg` | 2D views (front, left, top, iso) of the assembly and the frame | DXF: LibreCAD, QCAD, AutoCAD, DraftSight, FreeCAD · SVG: browser, Inkscape |
| `bom/` | Bill of materials, cut list, frame hardware, T-nuts per extrusion (CSV) | spreadsheet |
| `sheet-metal/` | **Untested** flat plates (base plate, stackable fan panels) as DXF for laser / waterjet / CNC, plus SVG, hole tables, STEP | DXF: any CAM / laser software, LibreCAD, QCAD · STEP: any CAD |
| `docs/assembly-guide/` | Illustrated step-by-step **assembly guide (PDF)** + Typst source | PDF reader |
| `images/` | Renderings | — |

## Assembly guide

**[docs/assembly-guide/assembly-guide.pdf](docs/assembly-guide/assembly-guide.pdf)** covers tools, consumables, a parts overview, 16 illustrated steps, the cable tables (SlimSAS ports, PSU cables with spare length), the checks to do before building, and the BOM.

Build the PDF yourself with [Typst](https://typst.app) ≥ 0.13:

```sh
cd docs/assembly-guide
typst compile --root ../.. assembly-guide.typ
```

## Printed parts

PETG, about 0.6 kg in total. Parts are exported in their **assembly position**, so rotate them flat on the bed in your slicer. Suggested settings: 0.2 mm layers, 4 perimeters, 40 % infill.

| File | Qty | Use |
|---|---|---|
| `standoff-8x10` | 16 | Board / M.2 riser standoff, M3 heat-set insert |
| `standoff-8x18-riser` | 20 (+4 for 6th GPU) | GPU riser standoff, M3 heat-set insert |
| `gpu-front-rest` | 5 | GPU front rest on the front support |
| `gpu6-holder-optional` | 1 (optional) | 6th GPU holder (optional) |
| `bracket-comb-1` | 1 | Slot bracket comb, GPU1-2 |
| `bracket-comb-2` | 1 | Slot bracket comb, GPU3 |
| `bracket-comb-3` | 1 | Slot bracket comb, GPU4-5 |
| `psu-holder-1-outer` | 1 | PSU 1 holder outer |
| `psu-holder-1-inner` | 1 | PSU 1 holder inner |
| `psu-holder-2-outer` | 1 | PSU 2 holder outer |
| `psu-holder-2-inner` | 1 | PSU 2 holder inner |
| `rack-ear-left-optional` | 1 | 19" rack ear left (optional) |
| `rack-ear-right-optional` | 1 | 19" rack ear right (optional) |

Standoffs take an **M3 heat-set insert** (Ø4 × 5.7 mm) on top.

## Frame hardware

See [`bom/frame-hardware.csv`](bom/frame-hardware.csv). The article numbers are from one example supplier (Dold Mechatronik, Germany); any 20×20 I-type slot 5 system works. **Important:** with I-type slot 5 the T-nuts can **not** be inserted afterwards, so slide them in before joining. [`bom/t-nuts-per-extrusion.csv`](bom/t-nuts-per-extrusion.csv) lists how many go into each extrusion (188 in total, 116 of them come with the brackets).

## Status / known limitations

These are placeholders in the model; please check them against your real hardware (also listed in the guide):

- **SlimSAS plug under the neighbouring riser:** after the 45 mm rigid plug each cable passes very close (model: 0.5 mm overlap) under the edge of the riser to its left. If it collides, raise the neighbouring riser by 2–3 mm.
- **Left-side overhang:** the two GPU1 cables stick out about 15 mm on the left, so leave room in the rack.
- **Standoff fixing:** how the printed standoffs are fixed on the T-nuts is not designed yet.
- **Riser details:** the 6-pin socket position and the mounting holes of the C-Payne riser are placeholders.
- **Power budget:** PSU 1 feeds CPU, board and three RTX 4090s. A GPU power limit of about 350–400 W is recommended.
- **Language of the source:** component names inside the CAD source are German. Pull requests with English naming are welcome.

## Roadmap

- [ ] **First build:** assemble the frame and check the fit (risers, SlimSAS routing, PSUs, standoffs)
- [ ] **Fixes from the build:** update the CAD, BOM and assembly guide with whatever the real build shows
- [ ] **Fan layout:** optimise fan positions and the number of fans for the GPU level
- [ ] **Photos of the finished rig**
- [ ] **Measurements:** GPU/CPU temperatures, fan speeds, noise and power draw under sustained AI/LLM load
- [ ] **Sheet-metal variant:** flat laser/waterjet-cut plates (base plate + stackable fan panels) as an alternative to some of the inner extrusions. First draft is in [`sheet-metal/`](sheet-metal/) but has not been cut or tested yet.

## Contributing

Issues and pull requests are welcome: builds with other boards (WRX80, TRX50, SP5), other GPUs (RTX 3090 / 5090), measured riser and plug dimensions, photos of your build.

## License

Hardware design, documentation and images: **[CERN Open Hardware Licence Version 2 – Permissive](LICENSE)** (CERN-OHL-P-2.0). Product names and trademarks belong to their owners; the component models (GPU, mainboard, PSU, cooler) are simplified placeholders, not manufacturer data.

---

*Keywords: DIY AI server, multi-GPU server, consumer GPU server, RTX 4090 server, 4× / 5× / 6× GPU rig, LLM inference server, local AI, homelab GPU rack, open hardware case, aluminium extrusion case, 2020 extrusion, PCIe riser, SlimSAS, EPYC, 19 inch rack 14U.*
