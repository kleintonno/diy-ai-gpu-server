// DIY AI GPU Server 14U – assembly guide (CERN-OHL-P v2)
// Data: data/doc.json, drawings: lines/*.svg, renderings: ../../images/*.png
// Build: typst compile --root ../.. assembly-guide.typ
#let D = json("data/doc.json")
#let ink = rgb("#1d1d1b")
#let grn = rgb("#6aaa2a")
#let lgrey = rgb("#eeeeec")
#let mgrey = rgb("#9a9a9a")

#set document(title: "DIY AI GPU Server 14U – Assembly guide")
#set text(font: "Noto Sans", size: 10pt, fill: ink, lang: "en")
#set par(justify: false, leading: 0.55em)
#set page(paper: "a4", margin: (x: 16mm, top: 14mm, bottom: 18mm),
  footer: context {
    let n = counter(page).get().first()
    if n > 1 [
      #set text(size: 8pt, fill: mgrey)
      #grid(columns: (1fr, auto, 1fr), align: (left + horizon, center + horizon, right + horizon),
        text(weight: "bold", fill: ink)[DIY AI GPU SERVER],
        [Open hardware · CERN-OHL-P v2],
        text(size: 14pt, weight: "bold", fill: ink)[#n])
    ]
  })

// ---------- Building blocks ----------
#let badge(t, fill: ink, size: 9pt) = box(baseline: 25%, circle(radius: 0.95em, fill: fill, stroke: none,
  align(center + horizon, text(fill: white, weight: "bold", size: size, t))))
#let ring(t) = box(baseline: 25%, circle(radius: 1.0em, stroke: 1.4pt + ink, fill: white,
  align(center + horizon, text(weight: "bold", size: 9pt, t))))
#let qty(n) = text(size: 16pt, weight: "bold")[#n×]
#let chip(letter, label, n) = box(inset: (x: 6pt, y: 4pt), radius: 6pt, stroke: 0.8pt + ink,
  [#ring(letter) #h(3pt) #qty(n) #h(2pt) #text(size: 8.5pt)[#label]])
#let person = box(width: 13pt, height: 24pt, {
  place(dx: 3pt, dy: 0pt, circle(radius: 3.5pt, fill: ink))
  place(dx: 1pt, dy: 8pt, rect(width: 11pt, height: 15pt, radius: (top: 5pt), fill: ink))
})
#let nope(body) = block(width: 100%, stroke: 1.2pt + ink, radius: 8pt, inset: (left: 8pt, y: 7pt, right: 22pt), {
  place(top + right, dx: 4pt, dy: -4pt, circle(radius: 9pt, fill: white, stroke: 1.6pt + rgb("#c62828"),
    align(center + horizon, text(fill: rgb("#c62828"), weight: "black", size: 12pt)[✕])))
  body
})
#let ok(body) = block(width: 100%, stroke: 1.2pt + ink, radius: 8pt, inset: (left: 8pt, y: 7pt, right: 22pt), {
  place(top + right, dx: 4pt, dy: -4pt, circle(radius: 9pt, fill: white, stroke: 1.6pt + grn,
    align(center + horizon, text(fill: grn, weight: "black", size: 12pt)[✓])))
  body
})
#let hint(body) = block(fill: lgrey, radius: 6pt, inset: 8pt, width: 100%,
  grid(columns: (auto, 1fr), gutter: 8pt,
    circle(radius: 9pt, fill: ink, align(center + horizon, text(fill: white, weight: "black")[!])), body))
#let magnify(body) = box(stroke: 1.5pt + ink, radius: 50%, inset: 10pt, clip: true, body)

#let stepnum(n) = text(size: 54pt, weight: "black", fill: ink)[#n]
#let step(n, title, parts: (), img: none, notes: none, height: 160mm) = {
  block(breakable: false, width: 100%, {
    grid(columns: (auto, 1fr), gutter: 12pt, align: (left + top, left + bottom),
      stepnum(n),
      [#text(size: 13pt, weight: "bold")[#title] \ #v(2pt) #parts.map(p => chip(..p)).join(h(5pt))])
    v(4pt)
    if img != none { align(center, image(img, height: height, fit: "contain")) }
    if notes != none { v(4pt); notes }
  })
}

// ---------- Cover ----------
#page(margin: 0mm, footer: none)[
  #place(top + left, dx: 16mm, dy: 18mm, box(fill: ink, inset: (x: 8pt, y: 5pt), radius: 4pt, text(fill: white, weight: "black", size: 13pt, tracking: 1pt)[OPEN HARDWARE]))
  #place(top + right, dx: -16mm, dy: 20mm, align(right)[
    #text(size: 30pt, weight: "black", tracking: 1pt)[DIY AI GPU SERVER] \
    #text(size: 11pt, fill: mgrey)[20×20 aluminium extrusion frame · 5–6 × RTX 4090 · 19″ / 14U]
  ])
  #place(center + horizon, dy: 10mm, image("../../images/r01-complete-iso-front-left.png", width: 190mm))
  #place(bottom + left, dx: 16mm, dy: -16mm, grid(columns: 2, gutter: 10pt, align: horizon,
    box(stroke: 1.5pt + ink, radius: 6pt, inset: 6pt, [#person#person]),
    text(size: 9pt)[Two people needed.]))
  #place(bottom + right, dx: -16mm, dy: -16mm, text(size: 9pt, fill: mgrey)[Assembly guide · #D.stand])
]

// ---------- Important ----------
#text(size: 22pt, weight: "black")[Important] #h(8pt) #text(fill: mgrey)[Read before you start]
#v(6pt)
#grid(columns: (1fr, 1fr), gutter: 12pt,
  ok[#person#person #h(6pt) From step 4 on the frame is bulky. Build it with two people.],
  nope[#text(weight: "bold")[Forgot a T-nut?] \ I-type slot 5: T-nuts can *not* be added later. Slide in *all* of them before joining (step 2).],
  ok[#text(weight: "bold")[ESD] \ From step 10 (mainboard) ground an ESD strap to the frame.],
  nope[#text(weight: "bold")[Mains power] \ Plug in the power cords last. Never re-plug anything while powered.],
  ok[#text(weight: "bold")[Square] \ Check every corner with a try square, *then* tighten.],
  nope[#text(weight: "bold")[Kinking SlimSAS] \ Bend radius ≥ 25 mm. The first 45 mm at the plug are rigid – do not bend.],
)
#v(8pt)
#hint[*Two cables stick out on the left.* The SlimSAS cables of GPU1 run over the mid frame and down the outside of the left side (approx. #D.ueberstand mm). Leave at least #(D.ueberstand + 2) mm on the left in the rack; no closed left side panel.]
#v(6pt)
#hint[*Airflow.* All graphics cards face their fans to the *left* (−X). A gap of #D.luft mm stays in front of each card. Keep it clear.]
#v(10pt)
#text(size: 14pt, weight: "bold")[Dimensions]
#v(2pt)
#table(columns: (auto, 1fr), stroke: none, inset: 4pt,
  [Outside (W × D × H)], [#D.B × #D.T × #D.H mm (incl. 50 mm feet)],
  [Rack], [19″, 14U (622.3 mm), stands on rails or a shelf; rack ears optional],
  [Frame weight], [approx. #D.gewicht_rahmen kg (extrusions + brackets)],
  [Graphics cards], [5 × RTX 4090 (305 × 61 × 125 mm), optional 6th card on the board level],
  [Power supplies], [2 × Silverstone ZEUS 1650R, upright, inlet down],
)

// ---------- Tools + consumables ----------
#pagebreak()
#text(size: 22pt, weight: "black")[Tools]
#v(4pt)
#grid(columns: (1fr, 1fr, 1fr), gutter: 10pt,
  ..D.werkzeug.map(w => box(width: 100%, stroke: 1pt + ink, radius: 8pt, inset: 8pt, [
    #align(center, text(size: 22pt)[#w.icon]) \
    #text(weight: "bold")[#w.name] \
    #text(size: 8.5pt, fill: mgrey)[#w.wofuer]])))
#v(12pt)
#text(size: 22pt, weight: "black")[Consumables]
#v(4pt)
#table(columns: (auto, 1fr, auto), stroke: (x, y) => if y > 0 { (top: 0.5pt + lgrey) }, inset: 5pt,
  table.header([*Qty*], [*Material*], [*Used for*]),
  ..D.material.map(m => (text(weight: "bold")[#m.menge], m.name, text(size: 8.5pt, fill: mgrey)[#m.wofuer])).flatten())

// ---------- Parts ----------
#pagebreak()
#text(size: 22pt, weight: "black")[Parts]
#v(4pt)
#grid(columns: (1fr, 1fr, 1fr, 1fr, 1fr), gutter: 6pt,
  ..D.teile.map(t => box(width: 100%, height: 37mm, stroke: 1pt + ink, radius: 8pt, inset: 7pt, [
    #ring(t.code) #h(4pt) #qty(t.menge) \
    #v(2pt) #text(size: 8.5pt, weight: "bold")[#t.name] \
    #text(size: 7.5pt, fill: mgrey)[#t.detail]])))

// ---------- Preparation ----------
#pagebreak()
#step(1, "Prepare the printed parts", parts: ((("D", "Standoff 8×10", D.n.bolzen10)), (("E", "Standoff 8×18", D.n.bolzen18))), img: none)
#grid(columns: (1fr, 1fr), gutter: 14pt,
  magnify(image("lines/detail-standoff.svg", width: 70mm)),
  [Press an M3 heat-set insert straight into the top hole of every standoff with the soldering iron (approx. 220 °C) until flush. \ #v(6pt)
   #grid(columns: 2, gutter: 8pt, ok[flush, straight], nope[tilted / proud])])
#v(10pt)
#step(2, "Slide in the T-nuts", parts: ((("N", "T-nut M4", D.n.nutensteine_gesamt)),), img: none)
#grid(columns: (1fr, 1.2fr), gutter: 14pt,
  magnify(image("lines/detail-corner.svg", width: 72mm)),
  [Before every joint slide the T-nuts into the slot – *2* per bracket (one per extrusion), plus those for standoffs, holders and fans. \ #v(4pt)
   #text(size: 7.5pt)[#columns(2, gutter: 8pt, table(columns: (1fr, auto), inset: 2.5pt, stroke: (x, y) => if y > 0 { (top: 0.4pt + lgrey) },
     table.header([*Extrusion*], [*Qty*]),
     ..D.nuts.map(r => (r.profil, text(weight: "bold")[#r.anzahl])).flatten()))]])

// ---------- Assembly steps ----------
#for s in D.steps {
  pagebreak()
  step(s.nr, s.titel, parts: s.teile.map(t => (t.code, t.name, t.menge)), img: "lines/" + s.svg,
    height: if s.at("tabelle", default: none) != none { 125mm } else { 190mm },
    notes: [
      #if s.at("hinweis", default: none) != none { hint(s.hinweis) }
      #if s.at("tabelle", default: none) != none {
        set text(size: 8pt)
        table(columns: s.tabelle.spalten.len(), inset: 3.5pt, stroke: (x, y) => if y > 0 { (top: 0.4pt + lgrey) },
          table.header(..s.tabelle.spalten.map(c => text(weight: "bold")[#c])),
          ..s.tabelle.zeilen.flatten())
      }
    ])
}

// ---------- Checks ----------
#pagebreak()
#text(size: 22pt, weight: "black")[Check before building] #h(6pt) #text(fill: mgrey)[placeholders in the model]
#v(6pt)
#for p in D.pruefen { hint[*#p.titel* \ #p.text]; v(4pt) }

// ---------- Done ----------
#pagebreak()
#align(center)[
  #text(size: 30pt, weight: "black")[Done.]
  #v(4pt)
  #image("../../images/r03-complete-iso-front-right.png", width: 150mm)
  #grid(columns: 2, gutter: 8pt,
    image("../../images/r11-frame-iso-front-left.png", width: 85mm),
    image("../../images/r07-complete-left.png", width: 85mm))
]

// ---------- BOM ----------
#pagebreak()
#text(size: 22pt, weight: "black")[Bill of materials] #h(6pt) #text(fill: mgrey)[from the CAD model]
#v(4pt)
#set text(size: 8pt)
#table(columns: (auto, auto, 1fr), inset: 3.5pt, stroke: (x, y) => if y > 0 { (top: 0.4pt + lgrey) },
  table.header([*Qty*], [*Part number*], [*Description*]),
  ..D.bom.map(r => (text(weight: "bold")[#r.menge], raw(r.pn), r.text)).flatten())
#v(10pt)
#text(size: 14pt, weight: "bold")[Frame hardware] #h(4pt) #text(fill: mgrey)[example supplier: Dold Mechatronik (DE), article numbers]
#v(2pt)
#table(columns: (auto, auto, 1fr, auto, auto), inset: 3.5pt, stroke: (x, y) => if y > 0 { (top: 0.4pt + lgrey) },
  table.header([*Qty*], [*Art. no.*], [*Item*], [*Length*], [*Note*]),
  ..D.dold.map(r => (text(weight: "bold")[#r.menge], raw(r.nr), r.name, r.laenge, text(fill: mgrey)[#r.hinweis])).flatten())

// ---------- Back cover ----------
#pagebreak()
#set text(size: 10pt)
#page(footer: none)[
  #v(1fr)
  #align(center)[
    #image("../../images/r13-frame-iso-front-right.png", width: 120mm)
    #v(10mm)
    #text(size: 26pt, weight: "black")[DIY AI GPU SERVER] \ #text(size: 10pt, fill: mgrey)[Open hardware · CERN-OHL-P v2]
    #v(2mm)
    #text(fill: mgrey, size: 9pt)[14U · #D.stand]
  ]
  #v(1fr)
]
