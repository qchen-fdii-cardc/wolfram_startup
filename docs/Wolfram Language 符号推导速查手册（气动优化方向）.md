# Wolfram Language 符号推导速查手册（气动优化方向）

# Wolfram Language Cheatsheet（气动符号推导・MD 文件）

> 配套前面习题手册，适配 Wolfram Engine 15 \+ wolframscript 离线环境
> 保存为 `wl-cheatsheet.md`
> 
> 

```markdown
# Wolfram Language 符号推导速查手册（气动优化方向）
> 环境：Wolfram Engine 15 / WolframScript，离线脚本头部固定
```wolfram
$AllowInternet = False;
SetOptions[Simplify, TimeConstraint -> 10];
```

## 一、基础语法规则

### 1\. 表达式与注释

- 注释：`(* 这里是注释 *)`，**无单行 // 注释**

- 函数调用：`Func[arg1, arg2]`，**方括号 \[\] 传参；圆括号 \(\) 仅用于表达式分组**

- 列表（向量）：`{a,b,c}`；列表索引：`lst[[1]]`，**下标从 1 开始，不是 0**

- `;`：语句末尾加分号，抑制输出，脚本中大量使用

- 大小写敏感：`Sin` / `D` / `Simplify`，首字母必须大写

### 2\. 两种赋值（推导最容易踩坑）

|写法|名称|行为|适用场景|
|---|---|---|---|
|`f[x_] = expr`|即时赋值|定义时立刻计算右侧表达式，结果固定|常量、预计算表达式，**尽量少用于推导函数**|
|`f[x_] := expr`|延迟赋值|每次调用函数时才计算右侧|✅ 绝大多数自定义推导函数、几何表达式|

### 3\. 替换规则（符号推导核心）

- `expr /. rule`：单次替换

- `expr //. rule`：反复迭代替换，直到表达式不再变化

- 规则写法：`符号 -> 表达式`；多规则 `{a->b, c->d}`

- 模式占位符：`x_` 任意表达式；`x_?NumericQ` 仅匹配数值

### 4\. 化简函数

- `Simplify[expr]`：常规化简，速度快，推荐优先使用

- `FullSimplify[expr]`：深度化简，**耗时高，复杂推导慎用**

- `Expand[expr]`：展开多项式

- `Factor[expr]`：因式分解

- `Collect[expr, x]`：按变量 x 整理多项式（合并同次项）

- `TrigExpand / TrigSimplify`：三角函数展开 / 化简

### 5\. 获取帮助（离线 REPL /wolframscript）

```wolfram
? Integrate     (* 简短帮助 *)
?? Integrate    (* 完整帮助，属性+选项+示例 *)
Information[Integrate] (* 等价 ?? *)
```

命令行直接查询：

```bash
wolframscript -code '?? PolarDecomposition' -print
```

## 二、微积分（偏导、全微分、积分、级数）

```wolfram
D[f, x]                (* ∂f/∂x 一阶偏导 *)
D[f, {x, 2}]           (* ∂²f/∂x² 二阶偏导 *)
D[f, x, y]             (* 混合偏导 ∂²f/∂x∂y *)
Dt[f]                  (* 全微分，变分前置基础 *)

Integrate[f, x]        (* 不定积分 *)
Integrate[f, {x,a,b}]  (* 定积分 a→b *)

Series[f, {x, x0, n}]  (* 在x0点泰勒展开至n阶 *)
Limit[f, x->x0]        (* 极限 *)
```

## 三、线性代数 \& 矩阵求导（伴随 / 梯度优化）

> ⚠️ 重点区分：`.` = 矩阵乘法；`*` = 元素逐点相乘
> 
> 

```wolfram
A = {{a11,a12},{a21,a22}}; (* 定义矩阵 *)
A.B                      (* 矩阵乘法 *)
A*B                      (* 元素相乘 *)
Transpose[A]             (* 转置 *)
Det[A]                   (* 行列式 *)
Inverse[A]               (* 矩阵求逆 *)
Eigenvalues[A]           (* 特征值 *)
Eigenvectors[A]          (* 特征向量 *)

D[f, {xvec}]             (* 标量对向量求导，梯度 *)
Outer[D, yvec, xvec]     (* 向量对向量求导，雅可比矩阵 *)
D[f, {{x,y},2}]          (* 海森矩阵：二阶偏导 *)
Tr[A]                    (* 矩阵迹 *)
```

## 四、矢量场与变分法（PDE、欧拉 \- 拉格朗日、伴随）

```wolfram
Grad[phi, {x,y,z}]       (* 标量场梯度 *)
Div[u, {x,y,z}]          (* 矢量场散度 *)
Curl[u, {x,y,z}]         (* 矢量场旋度 *)
Laplacian[phi, {x,y,z}]  (* 拉普拉斯算子 *)

VariationalD[L, u[x], x] (* 泛函变分，输出欧拉-拉格朗日方程 *)
DSolve[eq, u[x], {x,t}]  (* 符号求解ODE/PDE *)
```

## 五、循环、模块、函数封装（脚本开发）

```wolfram
Module[{localVar1, localVar2},
  (* 局部变量，隔离全局命名空间，推导脚本必备 *)
  expr1;
  expr2;
]

Do[ body, {i, imin, imax}] (* 循环 *)
Map[func, list] / func/@list (* 映射遍历列表 *)
```

## 六、论文输出 LaTeX / 导出

```wolfram
TeXForm[expr]    (* 输出LaTeX公式，直接粘贴论文 *)
Export["out.csv", data] (* 导出数据表格 *)
Export["fig.svg", plot] (* 导出矢量图 *)
```

## 七、常用布尔校验（推导自检）

```wolfram
Simplify[LHS == RHS]  (* 校验等式是否恒成立，返回True/False *)
```

## 八、离线环境关键全局变量

```wolfram
$AllowInternet = False; (* 禁止联网下载paclet，防止脚本卡住 *)
$Version               (* 查看Wolfram内核版本 *)
```

## 九、高频坑点速记

1. `[]` 函数传参；`()` 数学分组；`{}` 列表 / 向量，**不要混用括号**

2. 矩阵乘法必须用 `.`，`*` 是元素乘，气动矩阵推导最常见错误

3. 列表下标**从 1 开始**，不是 0

4. 自定义函数优先 `:=` 延迟赋值，不要无脑使用 `=`

5. `FullSimplify` 计算开销巨大，复杂符号推导优先 `Simplify`

6. 离线服务器脚本第一行务必写 `$AllowInternet=False;`，避免内核联网卡死

7. 所有函数首字母大写；变量名小写区分开，防止和内置符号冲突

```Plain Text
---

你直接复制全部内容，保存为 `wl-cheatsheet.md`，和之前那份习题手册放在同一个目录即可。

如果你需要，我可以把【习题手册 + 速查cheatsheet】合并成一个完整的 Markdown 文件。
```

> （注：部分内容由豆包工作 AI 生成）
