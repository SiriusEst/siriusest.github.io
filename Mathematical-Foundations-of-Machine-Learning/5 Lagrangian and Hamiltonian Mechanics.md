# 分析力学：Lagrangian 与 Hamiltonian 系统 (Analytical Mechanics: Lagrangian and Hamiltonian Systems)

<div class="updated-time">Updated: 2026-03-31 12:00 AEDT</div>

标签约定：`Definition` 表示定义，`Theory` 表示理论/定理，`Inference` 仅表示推导步骤，`Result` 表示结论或应用结论。

## 1. 广义坐标与 Lagrangian (Generalized Coordinates and the Lagrangian)

**Definition.** 用广义坐标 $q$ 描述系统构型，对应的广义速度 (Generalized Velocity) 为：


$$
\dot q=\frac{dq}{dt}
$$


这里 $q$ 不必是笛卡尔坐标，可以是角度、受约束的长度参数，或任何唯一描述构型的变量。

**Definition.** Lagrangian 定义为：


$$
L(q,\dot q,t)=T-V
$$


其中 $T$ 为动能 (Kinetic Energy)，$V$ 为势能 (Potential Energy)。

**Result.** Lagrangian 表述将动力学改写为"动能减势能"的形式。不从力平衡出发，而是通过基于能量的结构编码系统的演化。

## 2. 共轭动量与 Euler-Lagrange 方程 (Conjugate Momentum and the Euler-Lagrange Equation)

**Definition.** 与 $q$ 关联的共轭动量 (Conjugate Momentum) 定义为：


$$
p=\frac{\partial L}{\partial \dot q}
$$


**Theory.** 物理轨道满足 Euler-Lagrange 方程：


$$
\frac{d}{dt}\left(\frac{\partial L}{\partial \dot q}\right)=\frac{\partial L}{\partial q}
$$


**Inference.** 用共轭动量记号改写为：


$$
\dot p=\frac{\partial L}{\partial q}
$$


这表明动量的变化率由 Lagrangian 对坐标的偏导数控制。

**Result.** 在 Lagrangian 框架下，运动方程写成一个变分方程，无需显式追踪每个约束力或坐标修正项。

## 3. 作用量与驻值原理 (Action and the Stationary Principle)

**Definition.** 给定路径 $q(t)$，作用量 (Action) 定义为：


$$
S[q]=\int_{t_0}^{t_1} L(q,\dot q,t)\,dt
$$


**Theory.** 真实轨道满足：


$$
\delta S=0
$$


这是最小作用量原理更精确的表述：作用量在真实轨道上取驻值，但不一定严格最小。

**Inference.** 若在固定端点的前提下对路径施加扰动，并要求一阶变分为零，即可恢复 Euler-Lagrange 方程。

**Result.** "物理路径"可以理解为所有容许路径中，作用量一阶变化为零的那条。

## 4. 例子：一维势场中的粒子 (Example: A Particle in a One-dimensional Potential)

**Definition.** 对一维粒子 $x(t)$，标准 Lagrangian 为：


$$
L(x,\dot x)=\frac{1}{2}m\dot x^2 - V(x)
$$


**Inference.** 对应的共轭动量为：


$$
p=\frac{\partial L}{\partial \dot x}=m\dot x
$$


**Theory.** 代入 Euler-Lagrange 方程得到：


$$
\frac{d}{dt}(m\dot x)=\frac{\partial L}{\partial x}=-V'(x)
$$


即


$$
m\ddot x=-V'(x)
$$


**Result.** 这正是势场中的牛顿第二定律。它表明 Lagrangian 框架与经典力学完全一致，但以更适合约束和坐标变换的方式组织。

## 5. 从 Lagrangian 到 Hamiltonian：Legendre 变换 (From Lagrangian to Hamiltonian: The Legendre Transform)

**Definition.** Legendre 变换将变量从 $(q,\dot q)$ 换到 $(q,p)$：


$$
H(q,p,t)=p\dot q-L(q,\dot q,t),
\qquad
p=\frac{\partial L}{\partial \dot q}
$$


对多维系统：


$$
H(q,p,t)=\sum_i p_i\dot q_i-L(q,\dot q,t)
$$


**Inference.** 关键在于 $p$ 取代 $\dot q$ 成为独立变量。因此 Hamiltonian 表述生活在相空间 $(q,p)$ 中，而非基于速度的构型空间描述。

**Theory.** 对自然系统，当动能是速度的二次函数、势能仅依赖位置时，通常有：


$$
H=T+V
$$


**Result.** Hamiltonian 通常可解释为总能量。它将系统改写为位置和动量的一阶动力系统，Legendre 变换提供了从 Lagrangian 变量 $(q,\dot q)$ 到相空间变量 $(q,p)$ 的桥梁。

## 6. Hamilton 方程 (Hamilton's Equations)

**Theory.** 从定义关系出发


$$
H(q,p)=p\dot q-L(q,\dot q)
$$


对其求微分：


$$
dH=d(p\dot q)-dL
$$


利用乘积法则，


$$
d(p\dot q)=p\,d\dot q+\dot q\,dp
$$


以及


$$
dL=\frac{\partial L}{\partial q}\,dq+\frac{\partial L}{\partial \dot q}\,d\dot q,
\qquad
p=\frac{\partial L}{\partial \dot q},
\qquad
\dot p=\frac{\partial L}{\partial q},
$$

得到


$$
\begin{aligned}
dH
&=p\,d\dot q+\dot q\,dp-\frac{\partial L}{\partial q}\,dq-\frac{\partial L}{\partial \dot q}\,d\dot q \\
&=\left(p-\frac{\partial L}{\partial \dot q}\right)d\dot q+\dot q\,dp-\frac{\partial L}{\partial q}\,dq \\
&=\dot q\,dp-\dot p\,dq.
\end{aligned}
$$

**Inference.** 另一方面，将 $H$ 视为 $(q,p)$ 的函数，


$$
dH=\frac{\partial H}{\partial q}\,dq+\frac{\partial H}{\partial p}\,dp
$$


比较系数得到 Hamilton 方程：


$$
\dot q=\frac{\partial H}{\partial p},
\qquad
\dot p=-\frac{\partial H}{\partial q}
$$


**Result.** 二阶 Euler-Lagrange 动力学被拆分为一对一阶方程。这一推导也表明，经过从 $(q,\dot q)$ 到 $(q,p)$ 的 Legendre 变换后，Hamilton 方程与 Euler-Lagrange 方程等价。这是相空间分析、守恒律和数值积分的标准出发点。

## 7. 辛结构与 Liouville 定理 (Symplectic Structure and Liouville's Theorem)

**Definition.** 设相空间变量为：


$$
z=(q,p),
\qquad
J=
\begin{pmatrix}
0 & 1\\
-1 & 0
\end{pmatrix}
$$


则 Hamiltonian 系统可写为：


$$
\dot z=J\nabla H
$$


**Definition.** 相空间上的辛 2-形式 (Symplectic 2-form) 为：


$$
\omega=dq\wedge dp
$$


它描述了 Hamiltonian 流所保持的几何结构。

**Theory.** 若定义向量场


$$
f(q,p)=
\left(
\frac{\partial H}{\partial p},
-\frac{\partial H}{\partial q}
\right)
$$


则其散度 (Divergence) 为：


$$
\nabla\cdot f
=
\frac{\partial}{\partial q}\left(\frac{\partial H}{\partial p}\right)
-
\frac{\partial}{\partial p}\left(\frac{\partial H}{\partial q}\right)
=0
$$


**Result.**

- Hamiltonian 流保持相空间体积，这就是 Liouville 定理。
- 直觉上，轨道可以拉伸、弯曲或折叠，但不会局部压缩或膨胀相空间面积。
- 若 $\nabla\cdot f<0$，系统通常是耗散的；若 $\nabla\cdot f>0$，流在局部膨胀体积，不是 Hamiltonian 系统。

## 8. 为什么这些很重要 (Why This Matters)

**Result.**

- Lagrangian 框架表明动力学可以由标量泛函 $S[q]$ 的驻值条件生成。
- Hamiltonian 框架表明动力学还携带更强的几何结构：相空间、辛形式和体积保持。
- 在机器学习中，这些思想直接影响 Hamiltonian Monte Carlo、辛积分器 (Symplectic Integrator)、能量基模型 (Energy-based Model) 和长时间连续时间建模。
