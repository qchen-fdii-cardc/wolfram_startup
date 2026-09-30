
(* This is a simple Hello World program in Wolfram Language *)
Main[] := Print["Hello, World!"];

Main[];

(* Compute the mixed partial derivative of x^2 * Sin[y] * Cos[x] *)
eq := D[x^2 * Sin[y] * Cos[x], x, y]

Print[eq]


(* Plot Sin/Cos and their product *)
plot = Plot[
    {Sin[x], Cos[x], Sin[x] Cos[x]},
    {x, 0, 2 Pi},
    PlotLegends -> {"Sin[x]", "Cos[x]", "Sin[x] Cos[x]"},
    PlotTheme -> "Scientific",
    Filling -> {1 -> {2, Opacity[0.12]}},
    GridLines -> Automatic,
    AxesLabel -> {"x", "y"},
    BaseStyle -> {FontFamily -> "Arial", FontSize -> 12}
];

outPath = "curve.png";
Export[outPath, plot, ImageResolution -> 600];



(* 蝴蝶曲线，导出 butterfly.png *)
butterfly[t_] := (Exp[Sin[t]] - 2 Cos[4 t] + Sin[(2 t - Pi)/24]^5) {Cos[t], Sin[t]};

plot = ParametricPlot[butterfly[t], {t, 0, 12 Pi},
    PlotTheme -> "Business",
    PlotPoints -> 300,
    Axes -> False,
    Background -> White,
    PlotStyle -> {RGBColor[0.619608, 1, 0.4], Thickness[0.002]}
];
Export["butterfly.png", plot, ImageResolution -> 300];



(* 3D高斯曲面，导出 surface.png *)

Export["surface.png", Plot3D[
    Exp[-(x^2 + y^2)],
    {x, -3, 3}, {y, -3, 3},
    (* PlotPoints -> {50, 50}, *)
    (* MaxRecursion -> 4, *)
    Lighting -> "Neutral",
    PlotTheme -> "Scientific",
    Mesh -> 50,
    MeshStyle -> Opacity[0.2],
    AxesLabel -> {"x", "y", "z"},
    ColorFunction -> "BlueGreenYellow", PlotRange -> All
], ImageResolution -> 600];




Export["surface2.png", Plot3D[
    Exp[-(x^2 + y^2)],
    {x, -3, 3}, {y, -3, 3},
    PlotPoints -> {51, 51},
    MaxRecursion -> 4,
    PlotTheme -> "Scientific",
    Mesh -> 50,
    MeshStyle -> Opacity[0.2],
    AxesLabel -> {"x", "y", "z"},
    ColorFunction -> "BlueGreenYellow",
    Epilog -> {Red, PointSize[Large], Point[{0,0,1}]} (* 标记最高点 *)
    , PlotRange -> All
], ImageResolution -> 600];



(* 叠加3D球体标记最高点，并且增加文字标注 *)


Export["surface3.png", Show[
    Plot3D[
        Exp[-(x^2 + y^2)],
        {x, -3, 3}, {y, -3, 3},
        PlotPoints -> {51, 51}, (*奇数采样，顶点包含x=0,y=0*)
        MaxRecursion -> 4,
        PlotTheme -> "Scientific",
        Mesh -> 50,
        MeshStyle -> Opacity[0.2],
        AxesLabel -> {"x", "y", "z"},
        ColorFunction -> "BlueGreenYellow",
        PlotRange -> All
    ],
    Graphics3D[{Red, Sphere[{0, 0, 1}, 0.08]}],
    Graphics3D[{Black, Text["(0,0,1)", {0, 0, 1.15}]}]], ImageResolution -> 600];