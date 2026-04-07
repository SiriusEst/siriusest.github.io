# 光子物理与激光器 (Photon Physics and Laser)

<div class="updated-time">Updated: 2026-04-07 12:00 AEDT</div>

标签约定：`Definition` 表示定义，`Theory` 表示理论/定理，`Inference` 仅表示推导步骤，`Result` 表示结论或应用结论。

## 1. 能量量子化 (Energy Quantization)

**Definition.** 频率为 $\nu$ 的电磁场模式，其能量只能取 $h\nu$ 的整数倍：


$$
E_n = n h\nu, \quad n = 0, 1, 2, \ldots
$$


其中 $h \approx 6.626 \times 10^{-34} \, \text{J·s}$ 是 Planck 常数。

**Result.**

- 光子 (Photon) 不是"能量切出来的小块"，而是电磁场天生只能以光子为单位激发和释放。光子是电磁场能量的最小单位。
- 量子化思想是普遍的：光子是电磁场的量子，声子 (Phonon) 是晶格振动的量子，都是同一个框架。
- 为什么能量是量子化的？量子力学没有从更深层解释这一点，它是一个基本假设。Planck 为解释黑体辐射 (Black-body Radiation) 而提出，Einstein 用光电效应 (Photoelectric Effect) 证实了光子的实在性。

## 2. 不同频率的光子 (Photons at Different Frequencies)

**Theory.** 不同频率的光子就像不同面额的硬币——每种面额的"最小单位"不同，但都是不可再分的一份。


$$
E = h\nu
$$


**Result.**

- 红光 (Red Light)：频率低 → 单光子能量小。
- 紫光 (Violet Light)：频率高 → 单光子能量大。
- X 射线 / 伽马射线 (Gamma Ray)：频率更高 → 单光子能量更大。

紫外线有害的根本原因是质的区别：每一份能量（$h\nu$）都足以打断化学键、损伤 DNA，而红光的单光子能量太低，无论用多少个都打不断化学键。

## 3. 原子能级跃迁 (Atomic Energy Level Transitions)

**Theory.** 原子有不同的能量状态（能级 Energy Level）。当原子在能级之间跃迁时，能量以光子的形式释放或吸收：


$$
E_{\text{高}} - E_{\text{低}} = h\nu
$$


能级差唯一确定了释放光子的频率。

**Inference.** 原子从高能级跳到低能级时，电子云分布发生变化，产生一个振荡的电偶极矩 (Oscillating Electric Dipole Moment)。这个振荡的偶极矩激发电磁场，而电磁场只能以量子化的方式被激发，所以出来的恰好是一个光子。

## 4. 激光器中的三种辐射过程 (Three Radiation Processes in a Laser)

**Definition.** 激光器涉及三种辐射过程：

| 过程 | 描述 | 光子数变化 |
|------|------|-----------|
| 自发辐射 (Spontaneous Emission) | 高能态原子自行跳回低能态，随机方向发射光子 | +1（随机方向） |
| 受激吸收 (Stimulated Absorption) | 光子被低能态原子吸收，原子跳到高能态 | −1 |
| 受激辐射 (Stimulated Emission) | 光子"刺激"高能态原子跳下来，释放一个与入射光子完全相同（同频率、同方向、同相位）的新光子 | +1（相干） |

**Result.** 受激辐射是激光 (Laser) 的核心机制：一个光子进去，两个一模一样的光子出来。

## 5. 固态激光器的结构与工作原理 (Solid-State Laser Structure)

**Definition.** 固态激光器由以下部分组成：

- 活性材料 (Active Medium)：含有大量激光活性原子（如红宝石中的铬离子）。
- 两端镜子：构成光学谐振腔 (Optical Resonator)，让光子来回反射，不断触发受激辐射。
- 泵浦 (Pump)：外部能量源，将原子从基态激发到高能态。
- 半透镜 (Partially Transparent Mirror)：让一部分光漏出去，作为激光输出。

**Theory.** 粒子数反转 (Population Inversion)：正常热平衡下，低能态原子数 $N_1$ 远多于高能态 $N_2$，即 $N_1 > N_2$。粒子数反转就是人为地让 $N_2 > N_1$。

**Inference.** 一个轴向光子飞过活性材料时：

- 遇到高能态原子 → 触发受激辐射（光子数 +1）
- 遇到低能态原子 → 被受激吸收（光子数 −1）

如果 $N_1 > N_2$，光子被吸收的概率更大，净效果是光子被消耗。只有当 $N_2 > N_1$ 时，受激辐射占主导，光子数才能净增长。

**Result.**

- 谐振腔起到方向滤波器 (Directional Filter) 的作用：轴向光子在两面镜子之间来回反弹被不断放大，偏离轴向的光子则被自然淘汰。
- 激光器是能量转换器：把无序的泵浦能量转换成高度有序的激光输出，具有单色性 (Monochromaticity)、方向性 (Directionality) 和相干性 (Coherence)。

## 6. 激光模型的动力学分析 (Dynamical Analysis of Laser Model)

### 6.1 模型构建 (Model Construction)

**Definition.** 动态变量是腔内光子数 $n(t)$，其演化由增益和损耗的竞争决定：


$$
\dot{n} = \underbrace{GnN}_{\text{gain (受激辐射)}} - \underbrace{kn}_{\text{loss (光子漏出)}}
$$


- 增益项 $GnN$：来自受激辐射，速率正比于光子数 $n$ 与高能态原子数 $N$ 的乘积。$G > 0$ 是增益系数。
- 损耗项 $kn$：光子从半透镜漏出，速率正比于光子数。$k > 0$ 是损耗速率常数，其倒数 $\tau = 1/k$ 是光子在腔内的典型寿命。

### 6.2 增益饱和 (Gain Saturation)

**Theory.** $N$ 不是常数。每次受激辐射发射一个光子，就有一个原子从高能态跳到低能态，$N$ 减少。用线性模型近似：


$$
N(t) = N_0 - \alpha n
$$


其中 $N_0$ 是无激光时泵浦维持的高能态原子数（反映泵浦强度），$\alpha > 0$ 表示每个光子消耗高能态原子的比率。

**Result.** 这就是增益饱和效应：光子越多 → 高能态原子被消耗越快 → 增益被压低 → 系统自我调节。

### 6.3 最终方程与 Transcritical 标准型 (Final Equation & Transcritical Normal Form)

**Inference.** 将 $N = N_0 - \alpha n$ 代入：


$$
\dot{n} = Gn(N_0 - \alpha n) - kn = (GN_0 - k)n - (\alpha G)n^2
$$


令有效控制参数 $r = GN_0 - k$：


$$
\dot{n} = rn - (\alpha G)n^2
$$


**Result.** 这正是 Transcritical 分岔的标准型。

### 6.4 不动点分析 (Fixed Point Analysis)

**Inference.** 令 $\dot{n} = 0$：


$$
n\left[r - (\alpha G)n\right] = 0
$$


两个不动点：


$$
n_1^* = 0, \qquad n_2^* = \frac{r}{\alpha G} = \frac{GN_0 - k}{\alpha G}
$$


### 6.5 稳定性分析 (Stability Analysis)

**Theory.** 令 $f(n) = rn - (\alpha G)n^2$，则 $f'(n) = r - 2(\alpha G)n$。

在 $n_1^* = 0$ 处：$f'(0) = r = GN_0 - k$

- $r < 0$（泵浦弱，$GN_0 < k$）：$f'(0) < 0$，**稳定**
- $r > 0$（泵浦强，$GN_0 > k$）：$f'(0) > 0$，**不稳定**

在 $n_2^* = r/(\alpha G)$ 处：$f'(n_2^*) = r - 2r = -r$

- $r < 0$：$f'(n_2^*) > 0$，不稳定（但此时 $n_2^* < 0$，物理上无意义）
- $r > 0$：$f'(n_2^*) < 0$，**稳定**

**Result.** 两个不动点的稳定性恰好互补并交换——这是 Transcritical 分岔的标志。

### 6.6 物理解读：激光阈值 (Physical Interpretation: Laser Threshold)

**Result.** 激光阈值对应 $r = 0$，即 $GN_0 = k$（增益恰好等于损耗）：

| 参数区域 | 条件 | 物理状态 |
|---------|------|---------|
| $GN_0 < k$ | 增益 < 损耗 | $n^* = 0$ 稳定，无激光输出 |
| $GN_0 = k$ | 增益 = 损耗 | 分岔点（激光阈值） |
| $GN_0 > k$ | 增益 > 损耗 | $n^* = 0$ 不稳定，系统跑到 $n^* = (GN_0-k)/(\alpha G)$，激光工作 |

$N_0$ 由泵浦强度控制：泵浦越强 → $N_0$ 越大 → 越容易超过阈值。物理约束 $n \geq 0$ 意味着 $r < 0$ 时的负不动点没有物理意义。

## 7. Transcritical 分岔：一般理论 (Transcritical Bifurcation: General Theory)

**Definition.** Transcritical 分岔描述的是两个不动点始终存在，但在某个参数临界值处交换稳定性的场景。

**Theory.** 标准型 (Normal Form)：


$$
\dot{x} = rx - x^2
$$


其中 $r$ 是控制参数 (Control Parameter)。

**Inference.** 令 $\dot{x} = 0$，提取 $x$：


$$
x(r - x) = 0 \implies x_1^* = 0, \quad x_2^* = r
$$


两个不动点始终存在，在 $r = 0$ 处合并。

**Theory.** 稳定性：$f(x) = rx - x^2$，$f'(x) = r - 2x$。

| 不动点 | $f'(x^*)$ | $r < 0$ 时 | $r > 0$ 时 |
|--------|-----------|-----------|-----------|
| $x_1^* = 0$ | $r$ | 稳定 ($f' < 0$) | 不稳定 ($f' > 0$) |
| $x_2^* = r$ | $-r$ | 不稳定 ($f' > 0$) | 稳定 ($f' < 0$) |

**Result.** 在 $r = 0$ 处，两个不动点的稳定性同时翻转——这就是"交换稳定性"。

### 与 Saddle-Node 分岔的对比 (Comparison with Saddle-Node Bifurcation)

| 特征 | Saddle-Node | Transcritical |
|------|-------------|---------------|
| 分岔时 | 两个不动点碰撞后消失 | 两个不动点交换稳定性 |
| 不动点数量变化 | 2 → 0（或 0 → 2） | 始终为 2 |
| 标准型 | $\dot{x} = r + x^2$ | $\dot{x} = rx - x^2$ |
| 物理场景 | 阈值效应（状态消失） | 模式切换（主导权转移） |

### 判别方法 (Identification Method)

**Theory.** 对一般系统 $\dot{x} = f(x; r)$，判断某个不动点 $x^*$ 是否发生 Transcritical 分岔：

1. 在 $x^*$ 处 Taylor 展开
2. 检查线性项系数是否随参数过零
3. 确认二次项系数非零（否则可能退化为更高阶的分岔）
4. 验证不动点不消失，只是交换稳定性

## 8. 例题：参数空间中的分岔曲线 (Example: Bifurcation Curve in Parameter Space)

**Definition.** 系统 $\dot{x} = x(1 - x^2) - a(1 - e^{-bx})$，分析 $x = 0$ 处的分岔。

**Inference.** $x = 0$ 始终是不动点：代入 $x = 0$ 得 $0 \cdot (1 - 0) - a(1 - e^0) = 0$。对所有 $(a, b)$ 成立。这是 Transcritical 的特征。

在 $x = 0$ 附近 Taylor 展开。利用 $e^{-bx} = 1 - bx + \frac{1}{2}b^2x^2 + O(x^3)$：


$$
1 - e^{-bx} = bx - \frac{1}{2}b^2x^2 + O(x^3)
$$


代入原方程（注意 $x(1-x^2) = x + O(x^3)$，保留到 $x^2$）：


$$
\dot{x} = (1 - ab)x + \frac{1}{2}ab^2 x^2 + O(x^3)
$$


**Result.** 线性项系数为 $(1 - ab)$。当 $ab = 1$ 时线性项消失，这就是 $(a, b)$ 参数空间中的分岔曲线——双曲线 $ab = 1$。

近似非零不动点：


$$
x^* \approx \frac{2(ab - 1)}{ab^2}
$$


验证稳定性交换：$f'(0) = 1 - ab$，在非零不动点处 $f'(x^*) = ab - 1$。两者在 $ab = 1$ 处同时翻转，确认为 Transcritical 分岔。

## 9. 总结：从物理到数学的对应 (Summary: Physics-to-Mathematics Correspondence)

| 物理概念 | 数学对应 |
|----------|----------|
| 腔内光子数 $n$ | 动态变量 $x$ |
| 泵浦强度（通过 $N_0$） | 控制参数 $r$ |
| 激光阈值（增益 = 损耗） | 分岔点 $r = 0$ |
| 无激光状态 | 不动点 $x^* = 0$（$r < 0$ 时稳定） |
| 激光工作状态 | 非零不动点 $x^* = r/\beta$（$r > 0$ 时稳定） |
| 增益饱和 | 非线性项 $-\beta n^2$ |
| 泵浦过阈值后激光开启 | 稳定性交换 |

**Result.** 核心方法论：

1. 找不动点：令 $\dot{x} = 0$
2. Taylor 展开：在不动点处展开，化简为多项式
3. 读系数：线性项系数过零 → 分岔；二次项非零 → Transcritical
4. 判稳定性：$f'(x^*) < 0$ 稳定，$f'(x^*) > 0$ 不稳定
5. 验证交换：确认两个不动点的稳定性在分岔点处同时翻转
