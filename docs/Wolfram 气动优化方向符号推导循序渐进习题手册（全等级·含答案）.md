# Wolfram 气动优化方向符号推导循序渐进习题手册（全等级·含答案）

**适配环境**：Wolfram Engine 15 / WolframScript 离线脚本、$AllowInternet=False 纯本地运算

**适配场景**：几何参数化、PDE控制方程、变分伴随、梯度推导、气动灵敏度分析、优化建模

**学习规则**：逐级练习，每级10题，吃透基础再进阶；所有推导必须带**化简校验 \+ TeXForm 论文公式导出**

**通用脚本头部（所有文件统一添加）**

```wolfram
$AllowInternet = False;
SetOptions[Simplify, TimeConstraint -> 10];
(* 离线环境、限制化简耗时，避免卡死 *)

```

---

## Level 0 表达式与模式替换（10题）｜符号推导地基

**核心目标**：掌握赋值差异、表达式变换、单次/重复替换、多项式整理、模式匹配，解决90%代数推导基础问题

### Ex0\-1 多项式展开与因式分解

任务：定义表达式 $E=(2x-3y)^4$，完成展开；再对 $F=x^4-5x^2+4$ 因式分解。

核心函数：Expand、Factor

验证标准：展开无括号冗余，因式分解为最简整式乘积

### Ex0\-2 同类项整理（气动拟合公式常用）

任务：表达式 $E=2x^2y+3xy^2-2x^2y+5y^3-x^2$，分别按变量 $x$、$y$ 整理合并同类项。

核心函数：Collect、Simplify

### Ex0\-3 单次规则替换 /\. 

任务：$E=a^2+b^2+2ab$，代入 $a\to u(x),\;b\to v(x)$，化简表达式。

核心：单次替换，适用于边界条件、变量代换

### Ex0\-4 迭代重复替换 //\.（链式代换核心）

任务：定义替换规则 $\{x\to t+1,\;t\to s^2\}$，对 $E=x^2-2x$ 迭代替换至无变化。

区别：/\. 仅替换一次，//\. 完全迭代替换（推导守恒方程必备）

### Ex0\-5 基础模式匹配 \_ 占位符

任务：自定义规则 $f[x_]\to 2x^2+1$，分别作用于 $f[2],f[a+b],f[\sin(x)]$。

拓展：限定仅数值匹配 $f[x_?NumericQ]\to x^3$

### Ex0\-6 符号条件筛选替换

任务：给定列表 $\{1,-2,3,-4,5\}$，通过模式匹配替换所有负数为0，正数保持不变。

核心：条件模式匹配，适配参数筛选、误差修正

### Ex0\-7 即时赋值 = 与延迟赋值 := 核心区别

任务：分别定义两组函数：

$f[x] = D[x^2,x],\quad g[x] := D[x^2,x]$

修改变量 $x$ 后调用函数，观察输出差异，总结适用场景。

### Ex0\-8 三角函数恒等化简

任务：化简 $E=\sin^2(x)+\cos^2(x)+\tan(x)\cos(x)$，使用三角化简函数得到最简式。

核心函数：TrigSimplify、TrigExpand

### Ex0\-9 多层表达式嵌套替换

任务：$E=\sin(a^2+b^2)$，先替换 $a\to \cos(t)$，再替换 $b\to \sin(t)$，最终化简。

### Ex0\-10 表达式等式校验（推导自检核心）

任务：手动构造两个等价表达式 $(x-1)^2+2x-1$ 与 $x^2$，用 Simplify 校验等式成立。

核心习惯：所有推导步骤必须加等式校验，杜绝人工笔误

---

## Level 1 多元微积分与泰勒展开（10题）｜扰动与近似基础

**核心目标**：掌握偏导、全微分、链式求导、级数近似、定/不定积分，适配气动小扰动、边界层、几何近似推导

### Ex1\-1 多元一阶/高阶偏导数

任务：$f(x,y)=x^3y^2+\cos(xy)$，求解：一阶偏导$\partial f/\partial x$、二阶偏导 $\partial^2 f/\partial x^2$、混合偏导 $\partial^2 f/\partial x\partial y$。

### Ex1\-2 混合偏导对称性校验

任务：基于上一题结果，验证 $\dfrac{\partial^2 f}{\partial x\partial y}=\dfrac{\partial^2 f}{\partial y\partial x}$。

### Ex1\-3 单变量链式求导（几何参数化核心）

任务：设 $y(s)=1-s^2$，$f(y)=\exp(y)$，用链式法则求解 $df/ds$，代入化简。

### Ex1\-4 多元链式求导

任务：$z=u^2+v^2$，$u=xy,\;v=x-y$，求 $\partial z/\partial x,\partial z/\partial y$。

### Ex1\-5 基础不定积分求解

任务：求解 $\displaystyle \int x^2 e^{2x} dx$、$\displaystyle \int \sin^2(x) dx$ 不定积分。

### Ex1\-6 工程定积分（气动边界积分常用）

任务：求解区间定积分 $\displaystyle \int_0^L \sin\left(\frac{\pi x}{L}\right)\cos\left(\frac{\pi x}{L}\right) dx$。

### Ex1\-7 一阶/二阶泰勒级数展开

任务：$f(x)=\ln(1+x)$ 在 $x=0$ 处展开至4阶项，输出级数表达式。

### Ex1\-8 多元泰勒展开

任务：$f(x,y)=(1+x+y)^2$ 在 $(0,0)$ 处二阶泰勒展开。

### Ex1\-9 全微分 Dt 求解（变分前置基础）

任务：对 $f(x,y)=x^2y+\sin(x+y)$ 求全微分 $Dt[f]$，理解全微分与偏微分差异。

### Ex1\-10 极限求解（流场渐近分析）

任务：求解极限 $\displaystyle \lim_{x\to0}\frac{\sin(x)-x}{x^3}$、$\displaystyle \lim_{x\to\infty}\frac{x^2+1}{2x^2+x}$。

---

## Level 2 矩阵运算与矩阵求导（10题）｜优化梯度/伴随核心

**核心目标**：区分矩阵乘/元素乘、掌握二次型求导、雅可比、迹求导，适配气动灵敏度、梯度优化、状态空间推导

### Ex2\-1 基础矩阵四则运算

任务：定义二阶符号矩阵 $A=\{\{a,b\},\{c,d\}\},\;B=\{\{1,2\},\{3,4\}\}$，计算：矩阵乘积 $A.B$、元素乘积 $A*B$、转置、行列式、逆矩阵。

### Ex2\-2 矩阵秩与最简行变换

任务：给定数值矩阵，求解矩阵秩、行最简形，判断线性相关性。

### Ex2\-3 二次型标量梯度（优化最基础公式）

任务：设向量 $\boldsymbol x=\{x_1,x_2\}$，对称矩阵 $A$，标量函数 $J=\boldsymbol x^T A \boldsymbol x$，求梯度 $\nabla_{\boldsymbol x}J$。

### Ex2\-4 线性函数雅可比矩阵

任务：向量函数 $\boldsymbol y=\{x_1^2+x_2,\;x_1x_2^2\}$，求解雅可比矩阵 $J_{ij}=\partial y_i/\partial x_j$。

### Ex2\-5 矩阵迹求导

任务：标量 $f=\mathrm{Tr}(A^T B)$，求解 $\partial f/\partial A$。

### Ex2\-6 矩阵逆的求导

任务：已知 $A(t)$ 为时变矩阵，求 $\dfrac{d}{dt}A(t)^{-1}$。

### Ex2\-7 特征值特征向量求解（气动弹性稳定性）

任务：给定状态矩阵 $M=\{\{2,1\},\{1,2\}\}$，求解全部特征值、特征向量。

### Ex2\-8 对称矩阵正交对角化

任务：对上一题矩阵，完成正交对角化分解。

### Ex2\-9 最小二乘解析解推导

任务：损失函数 $J=\Vert A\boldsymbol x-\boldsymbol b\Vert^2$，对 $\boldsymbol x$ 求导并令梯度为0，推导最小二乘解析解。

### Ex2\-10 海森矩阵求解（二阶优化）

任务：二元函数 $f(x,y)=x^3+2xy^2+y^3$，求解海森矩阵（二阶偏导矩阵）。

---

## Level 3 矢量分析与变分法（10题）｜PDE与伴随方程核心

**核心目标**：掌握场论算子、泛函变分、欧拉\-拉格朗日方程、约束变分、PDE线性化，完全适配气动控制方程、伴随优化推导

### Ex3\-1 基础矢量场微分算子

任务：标量场 $\phi=x^2+y^2+z^2$，矢量场 $\boldsymbol u=\{xy,yz,xz\}$，求解梯度、散度、旋度、拉普拉斯。

### Ex3\-2 矢量恒等式化简

任务：化简$\nabla\cdot(\phi \boldsymbol u)$，验证矢量微分乘积法则。

### Ex3\-3 无约束泛函变分（基础E\-L方程）

任务：泛函 $J[u]=\int_a^b \left(u'(x)^2 + 2u(x)f(x)\right)dx$，求变分得到欧拉\-拉格朗日方程。

### Ex3\-4 带约束变分（拉格朗日乘子）

任务：泛函 $J[u]=\int_0^1 u'(x)^2 dx$，约束 $\int_0^1 u(x)dx=1$，构造增广泛函并求E\-L方程。

### Ex3\-5 一维对流方程线性化

任务：原方程 $u_t + (u^2/2)_x=0$，引入小扰动 $u=u_0+u'$，保留一阶小量，推导线性扰动方程。

### Ex3\-6 扩散方程变分推导

任务：基于扩散方程 $u_t=\nabla^2 u$，构造对应能量泛函并完成变分推导。

### Ex3\-7 二维场拉普拉斯方程求解

任务：对二维标量场 $\phi(x,y)$，求解 $\nabla^2 \phi=0$ 的简单解析解。

### Ex3\-8 泛函含高阶导数变分

任务：泛函 $J[u]=\int_0^1 \left(u''(x)^2\right)dx$，推导高阶欧拉\-拉格朗日方程（梁/薄板力学、气动柔性壁面）。

### Ex3\-9 简单PDE符号求解

任务：用DSolve求解一维波动方程 $u_{tt}=c^2 u_{xx}$ 通解。

### Ex3\-10 伴随方程极简原型推导

任务：原残差 $\mathcal R=u'-f(x,u)=0$，目标函数 $J=\int u dx$，构造拉格朗日泛函，对状态变量变分得到伴随方程。

---

## Level 4 气动综合实战（10题）｜科研落地完整案例

**核心目标**：贴合你的研究方向（Bernstein几何参数化、气动灵敏度、目标函数建模、公式批量导出），可直接复用为论文代码

### Ex4\-1 Bernstein基函数定义与化简

任务：定义n阶Bernstein基函数 $B_{n,i}(s)=\binom{n}{i}s^i(1-s)^{n-i}$，计算3阶全部基函数并化简、导出LaTeX。

### Ex4\-2 Bernstein曲线求导（几何斜率）

任务：构造3阶Bernstein曲线 $y(s)=\sum_{i=0}^3 c_i B_{3,i}(s)$，求解一阶导数 $dy/ds$。

### Ex4\-3 几何控制点灵敏度推导

任务：对上一题曲线，求解几何灵敏度 $\partial y(s)/\partial c_i$（优化核心梯度来源）。

### Ex4\-4 曲线弧长泛函构建

任务：基于Bernstein曲线，构建弧长泛函 $L=\int_0^1 \sqrt{1+(y'(s))^2}ds$。

### Ex4\-5 弧长对控制点的灵敏度

任务：对上一题弧长泛函，求导得到 $\partial L/\partial c_i$，完成化简并导出论文公式。

### Ex4\-6 压力损失目标函数建模

任务：构造气动损失泛函 $J=\int_0^1 P(s)\cdot y(s)ds$，推导对控制点的灵敏度。

### Ex4\-7 参数批量替换与公式批量导出

任务：设定3组不同控制点参数，批量替换曲线表达式，循环输出每组公式的LaTeX代码。

### Ex4\-8 几何约束条件化简

任务：添加几何约束（首尾固定 $y(0)=0,y(1)=1$），代入Bernstein曲线，化简得到控制点约束关系。

### Ex4\-9 带约束的气动优化泛函

任务：结合损失目标函数\+几何约束，引入拉格朗日乘子构造完整优化泛函。

### Ex4\-10 端到端科研脚本封装

任务：将上述几何建模、求导、化简、LaTeX导出全流程封装为Module，实现**一键运行、输出论文公式\+结果**。

---

## 全等级参考答案（可直接运行WL脚本）

所有答案适配离线 Wolfram 15，无网络依赖，可直接保存为 `answer.wl` 运行

```wolfram
$AllowInternet = False;
SetOptions[Simplify, TimeConstraint -> 10];
Print["===== Level 0 参考答案 ====="];
(* Ex0-1 *)
Expand[(2*x - 3*y)^4]
Factor[x^4 - 5*x^2 + 4]
(* Ex0-2 *)
expr02 = 2*x^2*y + 3*x*y^2 - 2*x^2*y + 5*y^3 - x^2;
Collect[expr02, x]
Collect[expr02, y]
(* Ex0-3 *)
expr03 = a^2 + b^2 + 2*a*b;
expr03 /. {a -> u[x], b -> v[x]} // Simplify
(* Ex0-4 *)
expr04 = x^2 - 2*x;
expr04 //. {x -> t + 1, t -> s^2} // Simplify
(* Ex0-5 *)
f[x_] := 2*x^2 + 1;
{f[2], f[a + b], f[Sin[x]]}
g[x_?NumericQ] := x^3;
(* Ex0-6 *)
{1, -2, 3, -4, 5} /. x_ /; x < 0 -> 0
(* Ex0-7 *)
Clear[x];
fa[x_] = D[x^2, x];
fb[x_] := D[x^2, x];
x = 10;
{fa[x], fb[x]}
(* Ex0-8 *)
TrigSimplify[Sin[x]^2 + Cos[x]^2 + Tan[x]*Cos[x]]
(* Ex0-9 *)
expr09 = Sin[a^2 + b^2] /. {a -> Cos[t], b -> Sin[t]} // Simplify
(* Ex0-10 *)
Simplify[(x - 1)^2 + 2*x - 1 == x^2]

Print["===== Level 1 参考答案 ====="];
(* Ex1-1 / 1-2 *)
f1[x_, y_] = x^3*y^2 + Cos[x*y];
D[f1[x, y], x]
D[f1[x, y], {x, 2}]
D[f1[x, y], x, y]
Simplify[D[f1[x, y], x, y] == D[f1[x, y], y, x]]
(* Ex1-3 *)
f13[s_] = Exp[1 - s^2];
D[f13[s], s] // Simplify
(* Ex1-4 *)
z14 = u^2 + v^2 /. {u -> x*y, v -> x - y};
{D[z14, x], D[z14, y]} // Simplify
(* Ex1-5 *)
Integrate[x^2*Exp[2*x], x]
Integrate[Sin[x]^2, x]
(* Ex1-6 *)
Integrate[Sin[Pi*x/L]*Cos[Pi*x/L], {x, 0, L}] // Simplify
(* Ex1-7 *)
Series[Log[1 + x], {x, 0, 4}]
(* Ex1-8 *)
Series[(1 + x + y)^2, {x, 0, 2}, {y, 0, 2}]
(* Ex1-9 *)
Dt[x^2*y + Sin[x + y]]
(* Ex1-10 *)
Limit[(Sin[x] - x)/x^3, x -> 0]
Limit[(x^2 + 1)/(2*x^2 + x), x -> Infinity]

Print["===== Level 2 参考答案 ====="];
(* Ex2-1 *)
A = {{a, b}, {c, d}}; B = {{1, 2}, {3, 4}};
{A.B, A*B, Transpose[A], Det[A], Inverse[A]} // Simplify
(* Ex2-3 *)
xvec = {x1, x2}; A2 = {{a11, a12}, {a12, a22}};
J23 = xvec.A2.xvec;
D[J23, {xvec}] // Simplify
(* Ex2-4 *)
yvec = {x1^2 + x2, x1*x2^2};
Outer[D, yvec, xvec] // Simplify
(* Ex2-5 *)
D[Tr[Transpose[A].B], A] // Simplify
(* Ex2-7 *)
M27 = {{2, 1}, {1, 2}};
{Eigenvalues[M27], Eigenvectors[M27]}
(* Ex2-10 *)
f210[x_, y_] = x^3 + 2*x*y^2 + y^3;
D[f210[x, y], {{x, y}, 2}]

Print["===== Level 3 参考答案 ====="];
(* Ex3-1 *)
phi31 = x^2 + y^2 + z^2; u31 = {x*y, y*z, x*z};
{Grad[phi31, {x, y, z}], Div[u31, {x, y, z}], Curl[u31, {x, y, z}], Laplacian[phi31, {x, y, z}]}
(* Ex3-3 *)
L33 = u'[x]^2 + 2*u[x]*f[x];
VariationalD[L33, u[x], x] // Simplify
(* Ex3-9 *)
DSolve[D[u[x, t], {t, 2}] == c^2 * D[u[x, t], {x, 2}], u[x, t], {x, t}]

Print["===== Level 4 核心参考答案 ====="];
(* Ex4-1 / 4-2 / 4-3 Bernstein几何核心 *)
Binomial[n_, i_] := n!/(i!*(n - i)!);
B[n_, i_, s_] := Binomial[n, i]*s^i*(1 - s)^(n - i);
Table[B[3, i, s], {i, 0, 3}] // Simplify
y42[s_] = Sum[c[i]*B[3, i, s], {i, 0, 3}];
D[y42[s], s] // Simplify
Table[D[y42[s], c[i]], {i, 0, 3}] // Simplify
(* 导出论文LaTeX *)
TeXForm[y42[s]]

```

---

## 使用规范与进阶建议

1. **离线必加头部代码**：所有脚本开头固定添加禁用网络、限制化简耗时代码，避免卡顿、联网加载；

2. **推导闭环习惯**：每一题必须完成 `化简 + 等式校验 + TeXForm导出`，贴合论文写作场景；

3. **优先级学习**：Level0\>Level1\>Level2（优化核心）\>Level3（PDE核心）\>Level4（科研落地）；

4. **避坑要点**：矩阵运算严格使用 `.`，禁止用 `*`；复杂推导优先 `Simplify`，慎用 `FullSimplify` 防止超时。

> （注：部分内容由豆包工作 AI 生成）
