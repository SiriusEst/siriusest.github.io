# 非线性动力学 (Nonlinear Dynamics)

标签约定：`Definition` 表示定义，`Theory` 表示理论/定理，`Inference` 仅表示推导步骤，`Result` 表示结论或判别结论。

## 1. 一维自治系统与相线 (One-dimensional Autonomous System & Phase Line)

**Definition.** 一维自治系统写为：


$$
\dot{x}=f(x)
$$


**Definition.** 平衡点 (Equilibrium Point) 满足：


$$
f(x^*)=0
$$


**Theory.** 线性稳定性判据 (Linear Stability Criterion)：


$$
f'(x^*)
$$


**Result.**

- 若导数小于零，轨道在平衡点附近收敛 (Stable)。
- 若导数大于零，轨道在平衡点附近发散 (Unstable)。

## 2. 分岔 (Bifurcation)

**Definition.** 分岔是参数变化导致系统定性行为改变的现象。

**Theory.** 常见类型：

- Saddle-node bifurcation
- Transcritical bifurcation
- Pitchfork bifurcation

## 3. 二维自治系统与线性化 (Two-dimensional Autonomous System & Linearization)

**Definition.** 二维自治系统：


$$
\dot{x}=f(x,y), \quad \dot{y}=g(x,y)
$$


**Definition.** 平衡点条件：


$$
f(x^*,y^*)=0, \quad g(x^*,y^*)=0
$$


**Definition.** 在平衡点附近定义小扰动：


$$
x=x^*+u, \quad y=y^*+v
$$



$$
\dot{u}=f(x^*+u,y^*+v), \quad \dot{v}=g(x^*+u,y^*+v)
$$


**Theory.** 一阶 Taylor 展开 (First-order Taylor Expansion)：


$$
f(x^*+u,y^*+v)\approx f(x^*,y^*)+f_xu+f_yv
$$



$$
g(x^*+u,y^*+v)\approx g(x^*,y^*)+g_xu+g_yv
$$


由平衡点条件可得线性化系统：


$$
\dot{u}\approx f_xu+f_yv, \quad \dot{v}\approx g_xu+g_yv
$$


矩阵形式：


$$
\begin{pmatrix}
\dot{u}\\
\dot{v}
\end{pmatrix}
=
\begin{pmatrix}
f_x & f_y\\
g_x & g_y
\end{pmatrix}
\begin{pmatrix}
u\\
v
\end{pmatrix}
$$


**Definition.** 雅可比矩阵 (Jacobian Matrix)：


$$
J=
\begin{pmatrix}
f_x & f_y\\
g_x & g_y
\end{pmatrix}_{(x^*,y^*)}
$$


## 4. 特征值方法 (Eigenvalue Method)

**Theory.** 线性化后系统写成：


$$
\dot{z}=Jz
$$


设指数型解 (Exponential Ansatz)：


$$
z(t)=e^{\lambda t}v
$$


代入得到：


$$
\dot{z}=\lambda e^{\lambda t}v, \quad Jz=e^{\lambda t}Jv
$$



$$
\lambda e^{\lambda t}v=e^{\lambda t}Jv
$$



$$
Jv=\lambda v
$$


**Inference.** 为了存在非零特征向量 (Non-trivial Eigenvector)：


$$
(J-\lambda I)v=0
$$



$$
\det(J-\lambda I)=0
$$


解得特征值：


$$
\lambda_1,\lambda_2
$$


这就是局部稳定性分析的核心逻辑。

## 5. Trace-Det 判据 (Trace-Determinant Criterion)

**Definition.** 对二维系统，定义：


$$
\operatorname{tr}(J)=\lambda_1+\lambda_2
$$



$$
\det(J)=\lambda_1\lambda_2
$$


**Result.**

- 若行列式小于零，平衡点为 Saddle。
- 若行列式大于零且迹小于零，常对应稳定类型 (Stable Node / Stable Focus)。
- 若行列式大于零且迹大于零，常对应不稳定类型 (Unstable Node / Unstable Focus)。

## 6. 混沌 (Chaos)

**Definition.** 混沌是确定性系统中出现的复杂非周期行为。

**Theory.** 典型特征：

- Deterministic dynamics
- Bounded trajectories
- Sensitive dependence on initial conditions

## 7. Hartman-Grobman 定理 (Hartman-Grobman Theorem)

**Theory.** 在双曲平衡点 (Hyperbolic Equilibrium) 附近，非线性系统与其线性化系统拓扑共轭 (Topological Conjugacy)。

**Result.** 在局部邻域内，可以用线性系统判断相图骨架。

## 8. Liouville 定理 (Liouville's Theorem)

**Theory.** 在哈密顿系统中，相空间体积在时间演化下保持不变。

**Result.** 哈密顿流可视为不可压缩流 (Incompressible Flow in Phase Space)。

## 9. 哈密顿系统基础 (Hamiltonian Mechanics)

### 9.1 基本变量 (Basic Variables)

**Definition.** 广义速度 (Generalized Velocity)：


$$
\dot{q}=\frac{dq}{dt}
$$


**Definition.** 拉格朗日量 (Lagrangian)：


$$
L(q,\dot{q})=T-V
$$


其中 T 为 Kinetic Energy，V 为 Potential Energy。

**Definition.** 广义动量 (Generalized Momentum)：


$$
p=\frac{\partial L}{\partial \dot{q}}
$$


**Theory.** Euler-Lagrange Equation：


$$
\frac{d}{dt}\left(\frac{\partial L}{\partial \dot{q}}\right)=\frac{\partial L}{\partial q}
$$


等价写法：


$$
\dot{p}=\frac{\partial L}{\partial q}
$$


**Definition.** 作用量 (Action)：


$$
S=\int L\,dt
$$


真实轨道满足驻值条件 (Stationary Action)：


$$
\delta S=0
$$


### 9.2 Legendre 变换 (Legendre Transform)

**Definition.**


$$
p=\frac{df}{dx}
$$



$$
g(p)=px-f(x)
$$


### 9.3 Hamiltonian 与 Hamilton 方程 (Hamilton's Equations)

**Definition.** Hamiltonian：


$$
H(q,p)=p\dot{q}-L(q,\dot{q})
$$


在常见机械系统中：


$$
H=T+V
$$


**Theory.** 对 Hamiltonian 做全微分：


$$
dH=d(p\dot{q})-dL
$$



$$
d(p\dot{q})=\dot{q}\,dp+p\,d\dot{q}
$$



$$
dL=\frac{\partial L}{\partial q}\,dq+\frac{\partial L}{\partial \dot{q}}\,d\dot{q}
$$


代入并使用：


$$
\frac{\partial L}{\partial \dot{q}}=p, \quad \frac{\partial L}{\partial q}=\dot{p}
$$


得到：


$$
dH=\dot{q}\,dp-\dot{p}\,dq
$$


另一方面：


$$
dH=\frac{\partial H}{\partial q}\,dq+\frac{\partial H}{\partial p}\,dp
$$


**Inference.** 比较系数得到 Hamilton's Equations：


$$
\dot{q}=\frac{\partial H}{\partial p}, \quad \dot{p}=-\frac{\partial H}{\partial q}
$$


这与 Euler-Lagrange 方程等价，只是坐标描述不同。

### 9.4 辛结构与体积保持 (Symplectic Structure & Volume Preservation)

**Definition.** 状态向量 (State Vector)：


$$
z=(q,p)
$$


**Definition.** 标准辛矩阵 (Canonical Symplectic Matrix)：


$$
J=
\begin{pmatrix}
0 & 1\\
-1 & 0
\end{pmatrix}
$$


**Theory.** Hamiltonian 系统可写为：


$$
\dot{z}=J\nabla H
$$


**Definition.** 相空间流 (Phase-space Flow) 可记为：


$$
X_H=(\dot{q},\dot{p})=\left(\frac{\partial H}{\partial p},-\frac{\partial H}{\partial q}\right)
$$


**Inference.** 其散度 (Divergence) 为：


$$
\nabla\cdot X_H
=
\frac{\partial}{\partial q}\left(\frac{\partial H}{\partial p}\right)
+
\frac{\partial}{\partial p}\left(-\frac{\partial H}{\partial q}\right)
=0
$$

在多维情形下同理可得：


$$
\nabla\cdot X_H
=
\sum_{i=1}^{n}
\left(
\frac{\partial^2 H}{\partial q_i\partial p_i}
-
\frac{\partial^2 H}{\partial p_i\partial q_i}
\right)
=0
$$


**Result.**

- 辛结构保持相空间基本面积元 (Area Element Preservation)。
- Hamiltonian 相空间流是散度为 0 的流 (Divergence-free Flow)。
- Liouville 定理保证相空间体积保持 (Volume Preservation)。
- 若一般系统散度小于零，则体积收缩，可能出现吸引子 (Attractor)。
