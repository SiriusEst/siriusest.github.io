# SGD、动量与势动力学 (SGD, Momentum, and Potential Dynamics)

<div class="updated-time">Updated: 2026-03-31 12:00 AEDT</div>

标签约定：`Definition` 表示定义，`Theory` 表示理论/定理，`Inference` 仅表示推导步骤，`Result` 表示结论或应用结论。

## 1. 损失函数作为势函数 (Loss as a Potential Function)

**Definition.** 设目标函数为 $f(x)$。在优化中，常将 $f$ 解释为势能地形 (Potential Energy Landscape)。

**Theory.** 在此解释下，地形诱导的力为


$$
F(x)=-\nabla f(x).
$$


**Inference.** 点 $x$ 倾向于移向低势能区域，因此优化可被视为粒子在能量曲面上的下降运动。

**Result.** 最小化损失等价于将系统驱向低势能状态。

## 2. 梯度下降作为梯度流的离散化 (Gradient Descent as a Discretization of Gradient Flow)

**Theory.** 基本梯度下降更新为


$$
x_{k+1}=x_k-\eta \nabla f(x_k).
$$


**Inference.** 令 $x_k=x(t_k)$，选取时间步长


$$
t_{k+1}-t_k=\eta.
$$


则


$$
\frac{x_{k+1}-x_k}{\eta}=-\nabla f(x_k).
$$


当 $\eta \to 0$ 时，差商收敛到时间导数，给出连续时间极限


$$
\dot x(t)=-\nabla f(x(t)).
$$


**Result.** 梯度下降是势函数 $f$ 上梯度流 (Gradient Flow) 的前向 Euler 离散化。

## 3. SGD 的解释 (Interpreting SGD)

**Definition.** 在随机梯度下降中，精确梯度被小批量估计替代：


$$
x_{k+1}=x_k-\eta g_k,
\qquad
\mathbb E[g_k\mid x_k]=\nabla f(x_k).
$$


**Inference.** 确定性部分仍然是相同的下坡漂移 $-\nabla f(x)$，而采样误差在漂移周围引入噪声。

**Result.** SGD 可被视为梯度流加上随机性。若噪声较小或被平均掉，主导行为仍由势能地形 $f$ 控制。

## 4. 动量作为二阶动力系统 (Momentum as a Second-Order Dynamical System)

**Definition.** 标准动量更新为


$$
v_{k+1}=\beta v_k-\gamma \nabla f(x_k),
\qquad
x_{k+1}=x_k+v_{k+1},
$$


其中 $v_k$ 是类速度辅助变量。

**Inference.** 由位置更新可得


$$
v_k=x_k-x_{k-1}.
$$


代入速度递推得到


$$
x_{k+1}-x_k=\beta(x_k-x_{k-1})-\gamma \nabla f(x_k).
$$


整理为


$$
x_{k+1}-2x_k+x_{k-1}
+
(1-\beta)(x_k-x_{k-1})
=
-\gamma \nabla f(x_k).
$$


两端除以 $(\Delta t)^2$：


$$
\frac{x_{k+1}-2x_k+x_{k-1}}{(\Delta t)^2}
+
\frac{1-\beta}{\Delta t}\cdot \frac{x_k-x_{k-1}}{\Delta t}
=
-\frac{\gamma}{(\Delta t)^2}\nabla f(x_k).
$$


取连续化尺度


$$
\frac{1-\beta}{\Delta t}\to r,
\qquad
\frac{\gamma}{(\Delta t)^2}\to 1,
$$


当 $\Delta t\to 0$ 时得到


$$
\ddot x(t)+r\dot x(t)+\nabla f(x(t))=0.
$$


**Result.** 动量对应一个有阻尼的二阶系统：惯性来自 $\ddot x$，摩擦来自 $r\dot x$，恢复力来自势梯度 $\nabla f$。

## 5. 力学解释 (Mechanical Interpretation)

**Definition.** 定义总能量


$$
E(t)=\frac{1}{2}\|\dot x(t)\|^2+f(x(t)).
$$


**Inference.** 沿动量 ODE 对其求导：


$$
\frac{dE}{dt}
=
\dot x^\top \ddot x+\nabla f(x)^\top \dot x.
$$


利用


$$
\ddot x+r\dot x+\nabla f(x)=0,
$$


得到


$$
\frac{dE}{dt}=-r\|\dot x(t)\|^2\le 0.
$$


**Result.** 动量并非逐点简单下坡。它携带动能，必要时可以越过浅谷，并通过阻尼逐渐耗散能量，直到系统在极小值附近安定下来。

## 6. 与优化的联系 (Connection Back to Optimization)

**Result.**

- 梯度下降是势能地形上的一阶下降律。
- SGD 在该一阶律上添加了随机扰动。
- 动量将动力学升级为带惯性和阻尼的二阶系统。
- 这一视角解释了为什么动量能更快地穿越浅谷，同时仍被摩擦所稳定。

简言之，优化算法可被解释为连续动力系统的离散化，而损失函数扮演势能面的角色。
