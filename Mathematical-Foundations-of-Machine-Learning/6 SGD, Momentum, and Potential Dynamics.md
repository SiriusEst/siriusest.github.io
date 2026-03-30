# SGD, Momentum, and Potential Dynamics

<div class="updated-time">Updated: 2026-03-30 18:08 AEDT</div>

Tag legend: `Definition` marks a definition, `Theory` marks an equation or principle, `Inference` marks a derivation step, and `Result` marks a conclusion or modeling takeaway.

## 1. Loss as a Potential Function

**Definition.** Let the objective function be `f(x)`. In optimization, it is often useful to interpret `f` as a potential energy landscape.

**Theory.** Under this interpretation, the force induced by the landscape is


$$
F(x)=-\nabla f(x).
$$


**Inference.** A point `x` tends to move toward lower-potential regions, so optimization can be viewed as the motion of a particle descending an energy surface.

**Result.** Minimizing the loss is equivalent to driving the system toward low-potential states.

## 2. Gradient Descent as a Discretization of Gradient Flow

**Theory.** The basic gradient descent update is


$$
x_{k+1}=x_k-\eta \nabla f(x_k).
$$


**Inference.** Let `x_k=x(t_k)` and choose the time step


$$
t_{k+1}-t_k=\eta.
$$


Then


$$
\frac{x_{k+1}-x_k}{\eta}=-\nabla f(x_k).
$$


As `\eta \to 0`, the difference quotient converges to a time derivative, giving the continuous-time limit


$$
\dot x(t)=-\nabla f(x(t)).
$$


**Result.** Gradient descent is the forward Euler discretization of gradient flow on the potential `f`.

## 3. Interpreting SGD

**Definition.** In stochastic gradient descent, the exact gradient is replaced by a minibatch estimate:


$$
x_{k+1}=x_k-\eta g_k,
\qquad
\mathbb E[g_k\mid x_k]=\nabla f(x_k).
$$


**Inference.** The deterministic part is still the same downhill drift `-\nabla f(x)`, while the sampling error introduces noise around that drift.

**Result.** SGD can be viewed as gradient flow plus randomness. If the noise is small or averaged out, the leading-order behavior is still controlled by the potential landscape `f`.

## 4. Momentum as a Second-Order Dynamical System

**Definition.** A standard momentum update is


$$
v_{k+1}=\beta v_k-\gamma \nabla f(x_k),
\qquad
x_{k+1}=x_k+v_{k+1},
$$


where `v_k` is the velocity-like auxiliary variable.

**Inference.** From the position update,


$$
v_k=x_k-x_{k-1}.
$$


Substituting this into the velocity recursion gives


$$
x_{k+1}-x_k=\beta(x_k-x_{k-1})-\gamma \nabla f(x_k).
$$


Rearranging,


$$
x_{k+1}-2x_k+x_{k-1}
+
(1-\beta)(x_k-x_{k-1})
=
-\gamma \nabla f(x_k).
$$


Now divide by `(\Delta t)^2`:


$$
\frac{x_{k+1}-2x_k+x_{k-1}}{(\Delta t)^2}
+
\frac{1-\beta}{\Delta t}\cdot \frac{x_k-x_{k-1}}{\Delta t}
=
-\frac{\gamma}{(\Delta t)^2}\nabla f(x_k).
$$


If we take the continuum scaling


$$
\frac{1-\beta}{\Delta t}\to r,
\qquad
\frac{\gamma}{(\Delta t)^2}\to 1,
$$


then as `\Delta t\to 0` we obtain


$$
\ddot x(t)+r\dot x(t)+\nabla f(x(t))=0.
$$


**Result.** Momentum corresponds to a damped second-order system: inertia comes from `\ddot x`, friction comes from `r\dot x`, and the restoring force comes from the potential gradient `\nabla f`.

## 5. Mechanical Interpretation

**Definition.** Define the total energy


$$
E(t)=\frac{1}{2}\|\dot x(t)\|^2+f(x(t)).
$$


**Inference.** Differentiate along the momentum ODE:


$$
\frac{dE}{dt}
=
\dot x^\top \ddot x+\nabla f(x)^\top \dot x.
$$


Using


$$
\ddot x+r\dot x+\nabla f(x)=0,
$$


we get


$$
\frac{dE}{dt}=-r\|\dot x(t)\|^2\le 0.
$$


**Result.** Momentum does not simply move downhill point by point. It carries kinetic energy, overshoots when necessary, and gradually dissipates energy through damping until the system settles near a minimizer.

## 6. Connection Back to Optimization

**Result.**

- Gradient descent is a first-order descent law on the potential landscape.
- SGD adds stochastic perturbations to that first-order law.
- Momentum upgrades the dynamics to a second-order system with inertia and damping.
- This perspective explains why momentum can cross shallow valleys faster while still being stabilized by friction.

In short, optimization algorithms can be interpreted as discretizations of continuous dynamical systems, and the loss function plays the role of a potential energy surface.
