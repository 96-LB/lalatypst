#import "@preview/quill:0.7.2": *
#let q = tequila

#let x = h(0pt, weak: true)
#let qquad = h(2em)

#let i = emph
#let b = strong
#let u = underline

#let bigO = $cal(O)$
#let littleO = $cal(o)$
#let Hi = $cal(H)$
#let P = $sans(P)$
#let NP = $sans(N P)$
#let BPP = $sans(B P P)$
#let CNOT = $op("CNOT")$
#let Var = $op("Var")$
#let Re = $op("Re")$
#let Im = $op("Im")$
#let PSD = $op("PSD")$
#let Tr = $op("Tr")$
#let span = $op("span")$

#let XOR = sym.xor.big
#let iso = sym.tilde.equiv
#let pm = sym.plus.minus
#let conj = math.overline
#let cap = sym.inter
#let qed = sym.square.stroked
#let tensor = sym.times.circle
#let varphi = sym.phi.alt
#let vareps = sym.epsilon.alt
#let fsq = $1/sqrt(2)$
#let inv = -1

#let hbar = (sym.wj, move(dy: -0.08em, strike(offset: -0.55em, extent: -0.05em, sym.planck)), sym.wj).join()
#let up = sym.arrow.double.t
#let down = sym.arrow.double.b

#let cm(..args) = $#args.pos().map(y => $#y$).join(", ")$
#let inner(..args) = $lr(angle.l #cm(..args) angle.r)$
#let bra(..args) = $lr(angle.l#cm(..args)|)$
#let ket(..args) = $lr(|#cm(..args)angle.r)$
#let braket(a, b) = $inner(#a #x | #x #b)$
#let ketbra(a, b) = $lr(|#a angle.r #h(-.1em) angle.l #b|)$

#let kup = $ket(up)$
#let kdown = $ket(down)$
#let bup = $bra(up)$
#let bdown = $bra(down)$
#let kright = $ket(=>)$
#let kleft = $ket(arrow.double.l)$

#let ddt = $frac(d, d t)$

#let lsticks(..args, x: 0, y: 0) = args.pos().enumerate().map(((i, z)) => lstick(z, x: x, y: y + i))
#let lkets(..args) = lsticks(..args.pos().map(x => $ket(#x)$), ..args.named())

#let rsticks(..args, x: 0, y: 0) = args.pos().enumerate().map(((i, z)) => rstick(z, x: x, y: y + i))
#let rkets(..args) = rsticks(..args.pos().map(x => $ket(#x)$), ..args.named())

#let bubble(color, body) = box(body, stroke: 1pt, inset: 1em, radius: 1em, fill: color, width: 1fr)

#let statement(color: none, ..args, format: strong) = bubble(color, {
        format(args.at(0))
        if args.pos().len() > 2 [~#emph[(#args.at(1))]]
        linebreak()
        args.at(-1)
    }
)

#let theorem(..args) = statement("Theorem", ..args, color: rgb("#6df14141"))
#let lemma(..args) = statement("Lemma", ..args, color: rgb("#c4f14141"))
#let corollary(..args) = statement("Corollary", ..args, color: rgb("#41f16d41"))
#let def(..args) = statement("Definition", ..args, color: rgb("#41c4f141"))
#let claim(..args) = statement("Claim", ..args, color: rgb("#f1c44141"))
#let ex(..args) = statement("Exercise", ..args, color: rgb("#f1414141"))

#let proof(body) = statement("Proof", color: rgb("#f1f1f141"), format: i)[
    #body
    #h(1fr) $qed$
]
#let sol(..args) = statement("Solution", ..args, color: rgb("#f1f1f141"), format: i)

#let numberedequation(number, body) = math.equation(body, block: true, numbering: x => "(" + number + ")")

#let pdflink(url) = (page, scroll, body) => link(str(url) + "#page=" + str(page) + "&zoom=100,96," + str(scroll), body)


#let document-as-homework(document) = {
    show heading.where(level: 1): x => {
        pagebreak(weak: true)
        underline(x)
    }
    show link: it => text(rgb("#00f"))[#it]
    set enum(numbering: "(a)")
    set cite(style: "alphanumeric")
    show cite: it => text(rgb("#009618"))[#it]
    
    document
}

#let document-as-notes(document) = {
    show heading.where(level: 1): x => {
        pagebreak(weak: true)
        emoji.calendar.spiral + underline(x.body)
    }
    show link: it => text(rgb("#00f"))[#it]
    set cite(style: "alphanumeric")
    show cite: it => text(rgb("#009618"))[#it]
    
    document
}
