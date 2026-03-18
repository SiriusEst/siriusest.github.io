# 线性代数：四个子空间（给自己看的口语版）

先约定：

$$
A\in\mathbb{R}^{m\times n},\quad A:\mathbb{R}^n\to\mathbb{R}^m
$$

把它当成一个“过滤器”最直观：有些输入方向会被保留，有些会被吃掉。

## 0. 四个子空间先摆出来

| 名称 | 记号 | 在哪里 | 直觉 |
| --- | --- | --- | --- |
| 列空间 | $C(A)$ | $\mathbb{R}^m$ | 能被 $Ax$ 产生出来的输出 |
| 行空间 | $C(A^T)$ | $\mathbb{R}^n$ | 输入里真正被 A 看见的方向 |
| 零空间 | $N(A)$ | $\mathbb{R}^n$ | 会被 A 直接压成 0 的输入 |
| 左零空间 | $N(A^T)$ | $\mathbb{R}^m$ | 和所有可达输出都正交的输出方向 |

---

## 1. 先记住一个超级关键结论

$$
\boxed{\text{不管 }x\text{ 是什么，}Ax\text{ 一定在 }C(A)}
$$

原因就是定义本身：

$$
C(A)=\{Ax\mid x\in\mathbb{R}^n\}
$$

所以“x 好不好”不影响它在不在列空间，只影响它落在列空间的哪个位置。

---

## 2. Ax=b 到底什么时候有解

精确可解当且仅当：

$$
Ax=b \text{ 有解}\iff b\in C(A)
$$

等价写法：

$$
b\in C(A)\iff b\perp N(A^T)
$$

也就是：如果 $b$ 里面掺了左零空间分量，那部分是 A 永远生成不出来的。

---

## 3. 解为什么会不唯一

零空间定义：

$$
N(A)=\{x\mid Ax=0\}
$$

如果 $x_p$ 是一个特解，那么全部解是：

$$
x=x_p+x_n,\quad x_n\in N(A)
$$

所以：

- $N(A)=\{0\}$：解唯一。
- $N(A)$ 非平凡：解不唯一（沿零空间可以随便加）。

---

## 4. 输入分解（这个视角很有用）

任意输入都能唯一拆成：

$$
x=x_r+x_n,
$$

其中

$$
x_r\in C(A^T)\ (\text{行空间}),\quad x_n\in N(A)\ (\text{零空间})
$$

作用 A 之后：

$$
Ax=A(x_r+x_n)=Ax_r+Ax_n=Ax_r
$$

因为 $Ax_n=0$。

结论：只有行空间部分决定输出，零空间部分完全被吃掉。

---

## 5. 正交关系（四子空间的骨架）

在输入空间 $\mathbb{R}^n$：

$$
\mathbb{R}^n=C(A^T)\oplus N(A),\quad C(A^T)\perp N(A)
$$

在输出空间 $\mathbb{R}^m$：

$$
\mathbb{R}^m=C(A)\oplus N(A^T),\quad C(A)\perp N(A^T)
$$

就是两边都拆成“有效部分 + 正交的无效部分”。

---

## 6. 维度分账（Rank-Nullity）

设 $\operatorname{rank}(A)=r$，那么：

$$
\dim C(A)=r,\quad \dim C(A^T)=r
$$

$$
\dim N(A)=n-r,\quad \dim N(A^T)=m-r
$$

对应两条常用等式：

$$
n=r+(n-r),\quad m=r+(m-r)
$$

也就是维度没消失，只是重新分配到了不同子空间。

---

## 7. 不可解时：最小二乘在干嘛

当 `Ax=b` 不可解时，做：

$$
\hat{x}=\arg\min_x\|Ax-b\|_2^2,
$$

把目标函数展开成数值计算友好的形式：

$$
f(x)=\|Ax-b\|_2^2=(Ax-b)^T(Ax-b)
$$

$$
=x^TA^TAx-2b^TAx+b^Tb
$$

对 $x$ 求导并令梯度为 0：

$$
\nabla_x f(x)=2A^TAx-2A^Tb=0
$$

得到正规方程：

$$
A^TA\hat{x}=A^Tb
$$

如果 $A$ 列满秩（rank = n），那 $A^TA$ 可逆，于是有显式数值解：

$$
\hat{x}=(A^TA)^{-1}A^Tb
$$

如果不满秩，就用伪逆写成统一形式：

$$
\hat{x}=A^+b
$$

其中最小二乘的最小范数解也是这一个。

残差：

$$
r=b-A\hat{x}
$$

会落在左零空间：

$$
r\in N(A^T),\quad r\perp C(A)
$$

直觉：先把 $b$ 投影到列空间，可达部分由 $A\hat{x}$ 解释，剩下那块就是“怎么也解释不了”的残差。

---

## 8. SVD 和四子空间一一对应

$$
A=U\Sigma V^T
$$

若非零奇异值有 $r$ 个，则：

$$
C(A)=\operatorname{span}(u_1,\dots,u_r),\quad N(A^T)=\operatorname{span}(u_{r+1},\dots,u_m)
$$

$$
C(A^T)=\operatorname{span}(v_1,\dots,v_r),\quad N(A)=\operatorname{span}(v_{r+1},\dots,v_n)
$$

所以 SVD 其实就是把四个子空间的正交基一次性给你。

---

## 9. 一句话总结

- `Ax` 永远在列空间。
- 哪些输入有效看行空间，哪些输入被抹掉看零空间。
- `Ax=b` 是否可解看 $b$ 在不在列空间（等价于是否垂直左零空间）。
- SVD 是四子空间最干净的坐标系。
