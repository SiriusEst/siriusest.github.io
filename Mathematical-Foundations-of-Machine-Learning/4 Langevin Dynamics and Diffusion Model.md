# Langevin 动力学与扩散模型 (Langevin Dynamics and Diffusion Model)

<div class="updated-time">Updated: 2026-03-31 12:00 AEDT</div>

标签约定：`Definition` 表示定义，`Theory` 表示理论/定理，`Inference` 仅表示推导步骤，`Result` 表示结论或应用结论。

## 1. Langevin 动力学 (Langevin Dynamics)

**Definition.** 连续时间 Langevin 动力学写为：


$$
dX_t=-\nabla \Phi(X_t)\,dt+\sqrt{2}\,dW_t
$$


其中 $\Phi(x)$ 是势函数 (Potential Function)，$W_t$ 是标准布朗运动 (Standard Brownian Motion)。

**Inference.** 若目标分布写为


$$
p_*(x)\propto e^{-\Phi(x)},
\qquad
\Phi(x)=-\log p_*(x)+C,
$$


则漂移项 $-\nabla \Phi$ 将粒子推向低势能区域，噪声项 $\sqrt{2}\,dW_t$ 持续注入随机探索。

**Result.**

- 漂移项对应在能量地形上向下移动。
- 扩散项防止粒子过早塌缩到局部区域。
- 在平衡态下，过程的稳态分布恰好是目标分布 $p_*$。

在机器学习中，$\Phi$ 通常被视为能量/损失地形 (Energy / Loss Landscape)。

## 2. Fokker-Planck 方程与概率流 (Fokker-Planck Equation and Probability Current)

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


**Result.** 这表明 Langevin 动力学并非任意噪声注入，而是通过漂移与扩散的平衡恢复目标分布。

## 3. 从 Itô 公式到一般 Fokker-Planck 方程 (From Itô's Formula to the General Fokker-Planck Equation)

**Definition.** 更一般地，考虑各向同性 Itô 过程


$$
dX_t=f(X_t,t)\,dt+g(t)\,dW_t.
$$


**Theory.** 对任意光滑测试函数 $\varphi$，Itô 公式给出


$$
d\varphi(X_t)
=
\nabla \varphi(X_t)\cdot f(X_t,t)\,dt
+
\nabla \varphi(X_t)\cdot g(t)\,dW_t
+
\frac{g(t)^2}{2}\Delta \varphi(X_t)\,dt.
$$


二次变差恒等式为


$$
\mathbb E[dW_t]=0,
\qquad
\mathbb E[(dW_t)^2]=dt.
$$


**Inference.** 取期望消除随机项，再通过分部积分将导数转移到密度 $p_t$ 上，得到


$$
\frac{\partial p_t}{\partial t}
=
-\nabla \cdot \bigl(f(x,t)p_t(x)\bigr)
+
\frac{g(t)^2}{2}\Delta p_t(x).
$$


**Result.** Langevin 动力学是上述一般形式的特例，取


$$
f(x)=-\nabla \Phi(x),
\qquad
g=\sqrt{2}.
$$


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


**Theory.** 代入一般 Fokker-Planck 方程得到


$$
\frac{\partial p_t}{\partial t}
=
\frac{\beta(t)}{2}
\left[
\nabla \cdot \bigl(x p_t\bigr)+\Delta p_t
\right].
$$


**Inference.** 若 $p_t=\mathcal N(0,I)$，则


$$
\nabla p_t(x)=-x\,p_t(x),
$$


以及


$$
\Delta p_t(x)=\bigl(\|x\|^2-d\bigr)p_t(x).
$$


回代后右端恰好为零，因此标准高斯分布是该过程的平衡分布。

**Result.**

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

**Inference.** 对 VP 前向 SDE，


$$
f(x,t)=-\frac{1}{2}\beta(t)x,
\qquad
g(t)=\sqrt{\beta(t)},
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

所以我们训练一个神经网络


$$
s_\theta(x,t)\approx \nabla_x \log p_t(x).
$$


在条件生成中，同样的思想变为条件 Score，如 $\nabla_x \log p_t(x\mid c)$，其中 $c$ 可以是类别标签、文本嵌入或 Prompt 信息。

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


**Theory.** 去噪 Score Matching 恒等式 (Vincent, 2011) 表明


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

**Result.** DSM 将不可求的边际 Score 目标替换为可求的已知高斯转移核的 Score。

## 8. 从 DSM 到 DDPM 噪声目标 (From DSM to the DDPM Noise Objective)

**Inference.** 对前向样本做重参数化


$$
x=\alpha_t x_0+\sigma_t \epsilon,
\qquad
\epsilon\sim \mathcal N(0,I).
$$


则


$$
-\frac{x-\alpha_t x_0}{\sigma_t^2}
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
