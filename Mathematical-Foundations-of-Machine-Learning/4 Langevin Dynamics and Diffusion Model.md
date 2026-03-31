# Langevin 动力学与扩散模型 (Langevin Dynamics and Diffusion Model)

<div class="updated-time">Updated: 2026-03-31 22:00 AEDT</div>

标签约定：`Definition` 表示定义，`Theory` 表示理论/定理，`Inference` 仅表示推导步骤，`Result` 表示结论或应用结论。

## 1. Langevin 动力学 (Langevin Dynamics)

**Definition.** 连续时间 Langevin 动力学写为：


$$
dX_t=-\nabla \Phi(X_t)\,dt+\sqrt{2}\,dW_t
$$


其中 $\Phi(x)$ 是势函数 (Potential Function)，$W_t$ 是标准布朗运动 (Standard Brownian Motion)。

> 口语理解：这个式子就两项——左边 $-\nabla\Phi$ 是梯度，让粒子往低的地方走（往势能谷底滑）；右边 $\sqrt{2}\,dW_t$ 是噪声，让粒子随机晃荡、到处探索。整个过程就像一个小球在起伏的地形上滚动，同时还被人不断随机推一把。

**Inference.** 若目标分布写为


$$
p_*(x)\propto e^{-\Phi(x)},
\qquad
\Phi(x)=-\log p_*(x)+C,
$$


则漂移项 $-\nabla \Phi$ 将粒子推向低势能区域，噪声项 $\sqrt{2}\,dW_t$ 持续注入随机探索。

> 口语理解：在 ML 里，直接把 $\Phi$ 套成 loss 面就行了。$p_*(x) \propto e^{-\Phi(x)}$ 的意思是——势能越低的地方，概率越大。所以粒子会倾向于聚集在 loss 低的地方，这正是我们想要的。

**Result.**

- 漂移项对应在能量地形上向下移动。
- 扩散项防止粒子过早塌缩到局部区域。
- 在平衡态下，过程的稳态分布恰好是目标分布 $p_*$。

在机器学习中，$\Phi$ 通常被视为能量/损失地形 (Energy / Loss Landscape)。

## 2. Fokker-Planck 方程与概率流 (Fokker-Planck Equation and Probability Current)

> 口语理解：前面 Langevin 方程描述的是单个粒子的运动轨迹，是"微观"视角。Fokker-Planck 方程则是"宏观"视角——它描述的是一大群粒子的密度怎么随时间演化。你可以理解为：Langevin 告诉你一个分子怎么跑，FP 告诉你一群分子整体的浓度分布怎么变。

**Theory.** 上述 SDE 的密度演化满足


$$
\frac{\partial p_t}{\partial t}
=
\nabla \cdot \bigl(p_t \nabla \Phi\bigr)+\Delta p_t.
$$


**Definition.** 定义概率流 (Probability Current)


$$
J_t(x)=-p_t(x)\nabla \Phi(x)-\nabla p_t(x),
$$


则连续性方程变为


$$
\frac{\partial p_t}{\partial t}=-\nabla \cdot J_t.
$$


> 口语理解：概率流 $J$ 就是描述"概率往哪个方向流、流多快"的量。可以把 $J$ 拆成两部分理解：$-p_t \nabla\Phi$ 是势能驱动的部分（粒子被梯度推着走），$-\nabla p_t$ 是扩散驱动的部分（粒子从密度高的地方往密度低的地方跑）。连续性方程 $\partial_t p = -\nabla \cdot J$ 就像物理里的质量守恒——概率不会凭空消失，只会从一个地方流到另一个地方。

**Inference.** 在平衡态下 $\partial_t p_t=0$。若进一步施加零通量条件 $J_t=0$，则


$$
\nabla p_*(x)=-p_*(x)\nabla \Phi(x),
$$


等价于


$$
\nabla \log p_*(x)=-\nabla \Phi(x).
$$


对该恒等式积分得到


$$
p_*(x)\propto e^{-\Phi(x)}.
$$


> 口语理解：平衡态就是密度不再变化了（$\partial_t p = 0$），而且到处的净流都是零（$J=0$），也就是说粒子虽然还在动，但整体分布已经稳定了。从 $J=0$ 出发，代入 $p_t = e^{-\Phi(x)}$ 可以验证 $\nabla p_t = -\nabla\Phi \cdot e^{-\Phi} = -p_t \nabla\Phi$，这样 $J = -p_t\nabla\Phi - \nabla p_t = -p_t\nabla\Phi + p_t\nabla\Phi = 0$，确实成立。

**Result.** 这表明 Langevin 动力学并非任意噪声注入，而是通过漂移与扩散的平衡恢复目标分布。

## 3. 从 Itô 公式到一般 Fokker-Planck 方程 (From Itô's Formula to the General Fokker-Planck Equation)

> 口语理解：这一节的目标是——我们有一个随机微分方程（描述单个粒子的运动），怎么推出它对应的 Fokker-Planck 方程（描述粒子群密度的演化）？工具就是 Itô 公式。思路分四步：① 写出 SDE；② 用 Itô 公式展开 $d\varphi$；③ 代入 SDE 具体形式；④ 对左右两边分别取期望后用分部积分。

**Definition.** 更一般地，考虑各向同性 Itô 过程


$$
dX_t=f(X_t,t)\,dt+g(t)\,dW_t.
$$


> 口语理解：$f$ 是漂移项（确定性的力），$g\,dW_t$ 是扩散项（随机的力）。布朗运动 $W_t$ 就是"随机骰子"——每一小步的增量 $dW_t \sim \sqrt{dt}$，这个量级关系是 Itô 微积分和普通微积分不一样的根源。

**Theory (Itô 公式).** 对任意光滑测试函数 $\varphi$，普通微积分里 $d\varphi = \frac{\partial \varphi}{\partial x} dx$ 就够了，但在随机微积分里，因为 $(dW_t)^2 \sim dt$ 不可忽略，所以需要多一项二阶修正：


$$
d\varphi(X_t)
=
\frac{\partial \varphi}{\partial x}\,dX_t
+
\frac{1}{2}\frac{\partial^2 \varphi}{\partial x^2}\,(dX_t)^2 + \cdots
$$


二次变差恒等式为


$$
\mathbb E[dW_t]=0,
\qquad
\mathbb E[(dW_t)^2]=dt,
\qquad
\mathrm{Var}[dW_t^2]=dt.
$$


> 口语理解：布朗运动的增量 $dW_t = W_{t+dt} - W_t \sim \mathcal{N}(0, dt)$，所以 $dW_t$ 的量级是 $\sqrt{dt}$，而 $(dW_t)^2$ 的量级是 $dt$——和确定性项同阶！这就是为什么 Itô 公式必须保留二阶项。

**Inference (详细推导).** 把 $dX_t = f\,dt + g\,dW_t$ 代入 Itô 展开式，分两个 item 来看：

**Item 1（一阶项）：**

$$
\frac{\partial \varphi}{\partial x}\,dX_t
=
\frac{\partial \varphi}{\partial x}\bigl(-\nabla\Phi(x)\,dt + g\,dW_t\bigr)
=
-\frac{\partial \varphi}{\partial x}\nabla\Phi\,dt
+
\frac{\partial \varphi}{\partial x}\,g\,dW_t
$$

**Item 2（二阶项）：**

$$
\frac{1}{2}\frac{\partial^2 \varphi}{\partial x^2}(dX_t)^2
=
\frac{1}{2}\frac{\partial^2 \varphi}{\partial x^2}
\bigl[(\nabla\Phi)^2 dt^2 - 2\nabla\Phi\cdot g\,dt\,dW_t + g^2(dW_t)^2\bigr]
$$

> 口语理解：展开 $(dX_t)^2$ 的三项里，$dt^2 \sim 0$（高阶小量扔掉），$dt\cdot dW_t \sim dt^{3/2} \sim 0$（也扔掉），只有 $g^2(dW_t)^2 \sim g^2 dt$ 活下来。所以：

$$
\frac{1}{2}\frac{\partial^2 \varphi}{\partial x^2}(dX_t)^2
\approx
\frac{g^2}{2}\frac{\partial^2 \varphi}{\partial x^2}\,dt
$$

合起来就是 Itô 公式的完整形式：

$$
d\varphi
=
-\frac{\partial \varphi}{\partial x}\nabla\Phi\,dt
+
\frac{\partial \varphi}{\partial x}\,g\,dW_t
+
\frac{g^2}{2}\frac{\partial^2 \varphi}{\partial x^2}\,dt.
$$

**Inference (从 Itô 到 Fokker-Planck).** 现在对两边取期望，左边变成 $\frac{d}{dt}\mathbb{E}[\varphi] = \int \varphi \frac{\partial p_t}{\partial t}dx$，右边的 $dW_t$ 项期望为零，剩下：

$$
\mathbb{E}[d\varphi]
=
\left[\int\left(-\frac{\partial \varphi}{\partial x}\nabla\Phi + \frac{g^2}{2}\frac{\partial^2 \varphi}{\partial x^2}\right)p_t(x)\,dx\right]dt
$$

对右边逐项做分部积分，把导数从 $\varphi$ 转移到 $p_t$ 上：

**Item 1 (分部积分)：** $\displaystyle\int -\frac{\partial \varphi}{\partial x}\nabla\Phi\,p_t\,dx = \int \varphi\,\nabla\cdot(\nabla\Phi\,p_t)\,dx$

**Item 2 (分部积分两次)：** $\displaystyle\int \frac{g^2}{2}\frac{\partial^2 \varphi}{\partial x^2}\,p_t\,dx = \frac{g^2}{2}\int \varphi\,\nabla^2 p_t\,dx$

> 口语理解：分部积分就是"把导数甩给对方"。因为这对任意测试函数 $\varphi$ 都成立，所以可以把 $\varphi$ "消掉"，得到密度 $p_t$ 本身必须满足的方程。

令左右相等，因为对任意 $\varphi$ 成立，所以被积函数本身相等：


$$
\frac{\partial p_t}{\partial t}
=
-\nabla \cdot \bigl(f(x,t)p_t(x)\bigr)
+
\frac{g(t)^2}{2}\Delta p_t(x).
$$


这就是一般的 **Fokker-Planck 方程**。

**Result.** Langevin 动力学是上述一般形式的特例，取 $f(x)=-\nabla \Phi(x)$，$g=\sqrt{2}$，代入即得 Section 2 的 FP 方程。


## 4. 前向扩散：OU / VP 过程 (Forward Diffusion as an OU / VP Process)

**Definition.** 在扩散模型中，标准连续时间前向过程为


$$
dX_t=-\frac{1}{2}\beta(t)X_t\,dt+\sqrt{\beta(t)}\,dW_t.
$$


这是时间非齐次 Ornstein-Uhlenbeck / 方差保持 (VP) 过程，对应


$$
f(x,t)=-\frac{1}{2}\beta(t)x,
\qquad
g(t)=\sqrt{\beta(t)}.
$$


> 口语理解：前向扩散就是"逐步搞脏数据"的过程——$-\frac{1}{2}\beta(t)x$ 把数据往原点拉（衰减信号），$\sqrt{\beta(t)}\,dW_t$ 不断加噪声。时间越长，原始数据的信息被破坏得越彻底，最终变成纯噪声 $\mathcal{N}(0,I)$。这个过程就像你把一件衣服丢进泥里越揉越脏。

**Theory.** 代入一般 Fokker-Planck 方程，$f = -\frac{1}{2}\beta x$，$g = \sqrt{\beta}$：


$$
\frac{\partial p_t}{\partial t}
= -\nabla\cdot\left(-\frac{1}{2}\beta x\,p_t\right) + \frac{\beta}{2}\Delta p_t
= \frac{\beta(t)}{2}
\left[
\nabla \cdot \bigl(x p_t\bigr)+\Delta p_t
\right].
$$


**Inference (验证稳态).** 若 $p_t=\mathcal N(0,I)$，即 $p(x) = \frac{1}{(2\pi)^{d/2}} e^{-\|x\|^2/2}$，需要验证代入 FP 方程后右端为零。

先算梯度和 Laplacian：

$$
\nabla p = -x\,p \quad \text{（对高斯求导，指数上的 $-\frac{1}{2}x^2$ 求导出 $-x$）}
$$

$$
\nabla\cdot(xp) = p + x\cdot\nabla p = p + x\cdot(-xp) = p - \|x\|^2 p = (1-\|x\|^2)p \quad \text{（$d$维时为 $d - \|x\|^2$）}
$$

> 更仔细地算 $\Delta p$：$\Delta p = \nabla\cdot(\nabla p) = \nabla\cdot(-xp) = -\nabla p - x\cdot\nabla p = -(-xp)\cdot 1 - x\cdot(-xp)$... 在 $d$ 维情况下：

$$
\Delta p = \nabla\cdot(-xp) = -dp + \|x\|^2 p = (\|x\|^2 - d)\,p
$$

代入 FP 方程右端：

$$
\frac{\beta}{2}\left[\nabla\cdot(xp) + \Delta p\right]
= \frac{\beta}{2}\left[(d - \|x\|^2)p + (\|x\|^2 - d)p\right]
= \frac{\beta}{2}\cdot 0 = 0
$$

> 口语理解：两项一正一负，完美抵消，右端为零。这说明一旦分布到了标准高斯，就不会再变了——$\mathcal{N}(0,I)$ 就是这个 OU 过程的稳态解。所以 $t \to \infty$ 时 $p_t \to \mathcal{N}(0,I)$。

**Result.**

- 前向扩散 (forward diffusion)：$p_{\text{data}} \xrightarrow{\text{SDE}} p_T \approx \mathcal{N}(0,I)$。
- 随着时间增加，数据分布逐渐被推向 $\mathcal N(0,I)$。
- 这就是前向扩散的本质：逐步破坏结构，直到分布接近纯噪声。

## 5. 反向时间 SDE (Reverse-Time SDE)

**Theory.** Anderson (1982) 的经典结果指出，若前向过程为


$$
dX_t=f(X_t,t)\,dt+g(t)\,dW_t,
$$


则反向时间过程（按从 $T$ 回到 $0$ 的约定）也是一个 SDE：


$$
dX_t=
\bigl[-f(X_t,t)+g(t)^2\nabla_x \log p_t(X_t)\bigr]dt
+
g(t)\,d\bar W_t.
$$


其中 $\bar W_t$ 是反向布朗运动 (Reverse Brownian Motion)。

> 口语理解：前向过程是"搞脏"（加噪声），反向过程就是"洗干净"（去噪声）。Anderson 告诉我们，只要你知道每个时刻的 score $\nabla_x \log p_t(x)$，就可以精确地把时间倒过来走。反向漂移 = 把前向漂移反过来 + 一个 score 修正项。这个 score 修正项是关键——它告诉粒子"数据密度高的方向在哪里"，引导粒子从噪声回到数据。

**Inference.** 对 VP 前向 SDE，令 $f(x,t)=-\frac{1}{2}\beta(t)x$，$g(t)=\sqrt{\beta(t)}$，代入反向 SDE：


$$
-f = \frac{1}{2}\beta(t)x, \qquad g^2 = \beta(t),
$$


反向过程变为


$$
dX_t=
\left[
\frac{1}{2}\beta(t)X_t
+
\beta(t)\nabla_x \log p_t(X_t)
\right]dt
+
\sqrt{\beta(t)}\,d\bar W_t.
$$


> 口语理解：$\frac{1}{2}\beta(t)X_t$ 是前向衰减的"反动作"（把信号放大回来），$\beta(t)\nabla_x\log p_t$ 是 score 指引的方向（往数据密度高的地方拉）。这两项合作，把纯噪声一步一步拉回数据分布。而 $\nabla_x\log p_t$ 就是我们需要用神经网络去学的东西。

**Result.**

- 若从 $X_T\sim \mathcal N(0,I)$ 出发，将此 SDE 反向积分到 $t=0$，终点即为数据样本。
- 反向漂移是前向漂移加上一个 Score 修正项。

## 6. 为什么 Score 是未知的 (Why the Score Is Unknown)

**Definition.** 反向 SDE 中的关键量是 Score


$$
\nabla_x \log p_t(x).
$$


边际密度 $p_t(x)$ 是将数据分布 $p_0=p_{\mathrm{data}}$ 前向演化到时间 $t$ 后的结果：


$$
p_t(x)=\int p_{t|0}(x\mid x_0)\,p_{\mathrm{data}}(x_0)\,dx_0.
$$


**Result.**

- 我们不知道 $p_{\mathrm{data}}$ 的解析形式。
- 因此也不知道 $p_t$ 的解析形式。
- 从而真实 Score $\nabla_x \log p_t(x)$ 无法直接计算。

> 口语理解：Score 就是"对数概率密度的梯度"，直觉上它告诉你"从当前位置出发，往哪个方向走概率密度会增大最快"。但问题是 $p_t(x)$ 是 $p_{\text{data}}$ 经过前向扩散之后的分布，而 $p_{\text{data}}$ 本身就是未知的（我们只有样本，没有解析公式），所以 $p_t$ 也是未知的。

所以我们训练一个神经网络


$$
s_\theta(x,t)\approx \nabla_x \log p_t(x).
$$


> 口语理解：既然 score 算不出来，那就让神经网络去学！训练目标是 $\min_\theta \mathbb{E}_{t, x\sim p_t}\left[\|s_\theta(x,t) - \nabla_x\log p_t(x)\|^2\right]$。但这个目标本身也依赖未知的 score——怎么办？这就引出了下一节的 Denoising Score Matching。

在条件生成中，同样的思想变为条件 Score，如 $\nabla_x \log p_t(x\mid c)$，其中 $c$ 可以是类别标签、文本嵌入 (embedding) 或 Prompt 信息。

## 7. 去噪 Score Matching (Denoising Score Matching)

**Definition.** 自然的学习目标为


$$
\mathcal L(\theta)
=
\mathbb E_{t,\,x\sim p_t}
\left[
\left\|s_\theta(x,t)-\nabla_x \log p_t(x)\right\|^2
\right].
$$


问题在于右端的目标 Score 是未知的。

> 口语理解：我们想让 $s_\theta$ 去拟合真实 score，但真实 score 本身就不知道——这不是鸡生蛋蛋生鸡吗？DSM 的核心 trick 就是：虽然边际 score $\nabla_x\log p_t(x)$ 不知道，但条件 score $\nabla_x\log p_{t|0}(x|x_0)$ 是已知的（因为转移核是高斯），而且可以证明用条件 score 做目标和用边际 score 做目标，在优化意义上是等价的。

**Theory.** 对线性 VP 前向过程，转移核 (Transition Kernel) 是显式的：


$$
p_{t|0}(x\mid x_0)
=
\mathcal N\!\left(x;\,\alpha_t x_0,\sigma_t^2 I\right),
$$


其中


$$
\alpha_t=\exp\!\left(-\frac{1}{2}\int_0^t \beta(s)\,ds\right),
\qquad
\sigma_t^2=1-\alpha_t^2.
$$


其 Score 因此为


$$
\nabla_x \log p_{t|0}(x\mid x_0)
=
-\frac{x-\alpha_t x_0}{\sigma_t^2}.
$$


> 口语理解：转移核就是"给定干净数据 $x_0$，加噪到时间 $t$ 后的分布"。因为 VP 过程是线性的，这个分布就是一个高斯，均值是 $\alpha_t x_0$（原始数据被衰减了），方差是 $\sigma_t^2$（噪声贡献）。高斯分布的 score 很简单，就是 $-\frac{x-\mu}{\sigma^2}$。

**Theory (DSM 恒等式).** 去噪 Score Matching 恒等式 (Vincent, 2011) 表明


$$
\mathbb E_{x\sim p_t}
\left[
\left\|s_\theta-\nabla_x \log p_t(x)\right\|^2
\right]
=
\mathbb E_{x_0\sim p_{\mathrm{data}},\,x\sim p_{t|0}(\cdot\mid x_0)}
\left[
\left\|s_\theta-\nabla_x \log p_{t|0}(x\mid x_0)\right\|^2
\right]
+
C_t,
$$


其中 $C_t$ 与 $\theta$ 无关。

**Inference.** 展开平方范数后，唯一非平凡的项是交叉项


$$
\int s_\theta(x,t)\cdot \nabla_x \log p_t(x)\,p_t(x)\,dx
=
\int s_\theta(x,t)\cdot \nabla_x p_t(x)\,dx.
$$


利用


$$
p_t(x)=\int p_{t|0}(x\mid x_0)\,p_{\mathrm{data}}(x_0)\,dx_0,
$$


该交叉项可用已知条件核改写，余项不依赖 $\theta$。

> 口语理解：关键的数学 trick 是——$\nabla_x\log p_t \cdot p_t = \nabla_x p_t$，而 $p_t$ 又可以写成 $\int p_{t|0}(\cdot|x_0) p_{\text{data}}(x_0) dx_0$，所以交叉项可以完全用已知的条件核 $p_{t|0}$ 来表达。最终效果是：优化边际 score 的 loss = 优化条件 score 的 loss + 常数，而条件 score 我们是知道的！

**Result.** DSM 将不可求的边际 Score 目标替换为可求的已知高斯转移核的 Score。

## 8. 从 DSM 到 DDPM 噪声目标 (From DSM to the DDPM Noise Objective)

**Inference.** 对前向样本做重参数化 (reparameterization)：


$$
x=\alpha_t x_0+\sigma_t \epsilon,
\qquad
\epsilon\sim \mathcal N(0,I).
$$


> 口语理解：这就是高斯采样的重参数化技巧——不是直接从 $\mathcal{N}(\alpha_t x_0, \sigma_t^2 I)$ 里采样 $x$，而是先采一个标准高斯噪声 $\epsilon$，然后算 $x = \alpha_t x_0 + \sigma_t\epsilon$。这样一来，条件 score 中的 $x - \alpha_t x_0$ 就等于 $\sigma_t\epsilon$：

$$
-\frac{x-\alpha_t x_0}{\sigma_t^2}
=
-\frac{\sigma_t\epsilon}{\sigma_t^2}
=
-\frac{\epsilon}{\sigma_t}.
$$


代入 DSM 目标得到


$$
\mathcal L(\theta)
=
\mathbb E_{t,\,x_0,\,\epsilon}
\left[
\left\|
s_\theta(\alpha_t x_0+\sigma_t \epsilon,t)
+
\frac{\epsilon}{\sigma_t}
\right\|^2
\right].
$$


**Theory.** 若通过噪声预测器参数化 Score 模型，


$$
s_\theta(x,t)=-\frac{\epsilon_\theta(x,t)}{\sigma_t},
$$


则目标变为 Ho et al. (2020) 的标准 DDPM 损失：


$$
\mathcal L_{\mathrm{simple}}
=
\mathbb E_{t,\,x_0,\,\epsilon}
\left[
\left\|
\epsilon_\theta(\alpha_t x_0+\sigma_t \epsilon,t)-\epsilon
\right\|^2
\right].
$$


> 口语理解：绕了一大圈，最后得到的训练目标其实非常简单直觉——给模型一张加了噪声的图 $\alpha_t x_0 + \sigma_t\epsilon$，让它预测加了什么噪声 $\epsilon$。预测得越准，说明学到的 score 越好。整个推导链条是：反向 SDE 需要 score → score 未知所以用 DSM 等价替换 → 重参数化把 score 目标变成噪声预测目标 → 得到 DDPM loss。

**Result.**

- 反向 SDE 采样需要 Score。
- DSM 用条件高斯 Score 替换未知的边际 Score。
- 重参数化将 Score 目标转换为噪声目标。
- DDPM 训练因此是 Score 学习的一种实际实现。

## 9. Langevin 动力学与扩散模型的关系 (Relation Between Langevin Dynamics and Diffusion Models)

**Result.**

- Langevin 动力学直接使用目标分布的 Score：$\nabla_x \log p(x)=-\nabla \Phi(x)$。
- 扩散模型学习一整族时间索引的 Score：$\nabla_x \log p_t(x)$。
- 前向过程将复杂数据分布逐步高斯化。
- 反向过程利用学到的 Score 将噪声拉回数据流形。
- 从这个意义上说，反向扩散是一种由学习到的 Score 场驱动的、时间依赖的 Langevin 式动力学。

> 口语理解：打个比方——Langevin 动力学说的是"如果你已经知道地形长啥样（score 已知），怎么撒粒子让它们最终聚集在你要的分布上"。扩散模型面对的是更难的问题："地形你不知道，但你有一堆数据样本"。它的策略是：先用前向过程把数据逐步搞脏变成纯噪声（这个过程不需要知道 score），然后在这个过程中顺便学到了每个时刻的 score（通过 DSM/噪声预测），最后用学到的 score 反向走一遍 Langevin 式的采样，从噪声变回数据。

一句话总结：Langevin 动力学回答"当 Score 已知时如何采样"，而扩散模型将问题转化为一族带噪分布，学习它们的 Score，然后利用反向时间 SDE 生成样本。

完整概念链为


$$
\text{Langevin SDE}
\to
\text{Fokker-Planck}
\to
\text{前向高斯化}
\to
\text{反向 SDE 需要 Score}
\to
\text{DSM 等价}
\to
\text{噪声预测}.
$$

## 参考文献 (References)

- Anderson, B. D. O. (1982). Reverse-time diffusion equation models.
- Vincent, P. (2011). A connection between score matching and denoising autoencoders.
- Ho, J., Jain, A., and Abbeel, P. (2020). Denoising Diffusion Probabilistic Models.
