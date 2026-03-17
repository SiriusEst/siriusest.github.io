# 正交性 (Orthogonality)

标签约定：`Definition` 表示定义，`Theory` 表示理论/定理，`Inference` 仅表示推导步骤，`Result` 表示结论或应用结论。

## 1. 从耦合到解耦 (Coupled to Decoupled)

**Theory.** 正交化的核心价值是把耦合问题改写为解耦问题，这与 Divide and Conquer 的思想一致。  
在一组正交基下，每个分量可以独立分析，计算和解释都会更清晰。

## 2. 正交的定义 (Definition of Orthogonality)

**Definition.** 向量正交满足：

\[
\langle u,v\rangle=0
\]

**Result.**

- 几何视角：两个向量互相投影为零。
- 代数视角：内积为零意味着在内积结构下无重叠方向信息。
- 信息视角：两个分量在该表示中可视为解耦。

## 3. 正交分解与能量可加性 (Energy Additivity)

**Theory.** 在欧式空间中，正交分量满足能量可加：

\[
\|x\|^2=\sum_i x_i^2
\]

**Definition.** 这里的系数是向量在一组标准正交基下的坐标。

## 4. 正交基下的展开 (Expansion in Orthonormal Basis)

**Theory.** 任意向量可展开为：

\[
v=\sum_i \langle v,e_i\rangle e_i
\]

**Definition.** 系数

\[
\langle v,e_i\rangle
\]

是投影系数 (Projection Coefficient)。

## 5. Gram-Schmidt 正交化

**Theory.** Gram-Schmidt 包含两步：

1. Straighten (Orthogonalization)
2. Normalize (Normalization)

**Inference.** 对两向量版本：

\[
\tilde{v}=v-\operatorname{proj}_u(v)
\]

\[
e=\frac{\tilde{v}}{\|\tilde{v}\|}
\]

**Result.** 原始基被转换为标准正交基，后续投影与坐标计算更稳定。

## 6. 正交矩阵与正交变换 (Orthogonal Matrix & Orthogonal Transform)

**Definition.** 正交矩阵满足：

\[
Q^TQ=I
\]

**Theory.** 正交变换保持长度与角度，典型几何操作是 Rotation 与 Reflection。

**Result.** 若矩阵列向量构成标准正交基，则该矩阵必可逆且逆矩阵为转置矩阵。

## 7. 共轭转置 (Conjugate Transpose)

**Theory.** 在复数空间中，内积应使用共轭转置，才能保证能量量

\[
x^Hx
\]

为非负实数。

**Definition.**

\[
A^H=\overline{A}^T
\]

给定：

\[
A=
\begin{bmatrix}
1+i & 2\\
3i & 4-i
\end{bmatrix}
\]

则：

\[
A^T=
\begin{bmatrix}
1+i & 3i\\
2 & 4-i
\end{bmatrix}
\]

\[
\overline{A}=
\begin{bmatrix}
1-i & 2\\
-3i & 4+i
\end{bmatrix}
\]

\[
A^H=
\begin{bmatrix}
1-i & -3i\\
2 & 4+i
\end{bmatrix}
\]

## 8. 实空间与复空间中的正交 (Real vs Complex Inner Product)

**Definition.** 实数空间内积与正交条件：

\[
\langle x,y\rangle=x^Ty,\quad x^Ty=0
\]

对应矩阵条件：

\[
Q^TQ=I
\]

**Definition.** 复数空间内积与正交条件：

\[
\langle x,y\rangle=x^Hy,\quad x^Hy=0
\]

对应矩阵条件：

\[
U^HU=I
\]

**Inference.** 内积保持性推导：

\[
\langle Qx,Qy\rangle=(Qx)^T(Qy)=x^TQ^TQy=x^Ty
\]

\[
\langle Ux,Uy\rangle=(Ux)^H(Uy)=x^HU^HUy=x^Hy
\]

**Result.** 实空间保持内积的矩阵称正交矩阵，复空间保持内积的矩阵称酉矩阵。

## 9. 函数空间中的正交 (Orthogonality in Function Space)

**Definition.** 对实函数：

\[
\langle f,g\rangle=\int_a^b f(x)g(x)\,dx
\]

对复函数：

\[
\langle f,g\rangle=\int_a^b \overline{f(x)}g(x)\,dx
\]

正交条件：

\[
\langle f,g\rangle=0
\]

## 10. 经典正交系 (Classical Orthogonal Systems)

**Definition.** 三角正交系：

\[
1,\cos x,\sin x,\cos 2x,\sin 2x,\cdots
\]

在典型区间上的正交关系：

\[
\int_{-\pi}^{\pi}\sin(mx)\sin(nx)\,dx=0,\quad m\neq n
\]

\[
\int_{-\pi}^{\pi}\cos(mx)\cos(nx)\,dx=0,\quad m\neq n
\]

\[
\int_{-\pi}^{\pi}\sin(mx)\cos(nx)\,dx=0
\]

**Definition.** 正交多项式系满足：

\[
\int_a^b P_m(x)P_n(x)\,dx=0,\quad m\neq n
\]

**Result.** 有限维空间只需有限个正交基；函数空间通常需要无限个正交基函数。

## 11. 谱定理 (Spectral Theorem)

**Definition.** 实对称矩阵满足：

\[
A^T=A
\]

**Theory.** 任意实对称矩阵可正交对角化：

\[
A=Q\Lambda Q^T
\]

**Result.** 特征向量给出主轴方向，特征值给出各主轴缩放率。  
在该基下，耦合线性变换变成独立缩放。

## 12. 奇异值分解 (SVD)

**Theory.** SVD 表示为：

\[
A=U\Sigma V^T
\]

**Definition.**

- 列向量集合 V 对应输入空间基，称 Right Singular Vectors。
- 列向量集合 U 对应输出空间基，称 Left Singular Vectors。
- 矩阵 Sigma 表示各方向缩放强度。

**Inference.** 每个奇异对满足：

\[
Av_i=\sigma_i u_i
\]

**Result.** SVD 可解释为：输入正交变换 + 轴向缩放 + 输出正交变换。

## 13. Correlation 与 Independence

**Definition.** 线性不相关条件：

\[
\operatorname{Cov}(X,Y)=0
\]

**Definition.** 独立条件：

\[
f(x,y)=f(x)f(y)
\]

**Theory.** 互信息刻画广义依赖，满足：

\[
I(X;Y)=0
\]

当且仅当独立。

**Result.** 不相关不等于独立。  
典型例子是对称分布下的

\[
X\ \text{与}\ X^2
\]

它们可线性不相关，但仍强依赖。

## 14. 高维近似正交现象 (Near Orthogonality in High Dimensions)

**Theory.** 在高维空间中，随机向量夹角集中在直角附近，出现角度集中现象 (Concentration of Measure)。

**Result.** 随机向量在高维中通常近似正交，这也是高维统计与机器学习中常见的几何基础。
