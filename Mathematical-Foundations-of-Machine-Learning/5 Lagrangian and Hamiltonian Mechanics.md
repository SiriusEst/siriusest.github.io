# Analytical Mechanics: Lagrangian and Hamiltonian Systems

<div class="updated-time">Updated: 2026-03-30 18:02 AEDT</div>

Tag legend: `Definition` marks a definition, `Theory` marks an equation or principle, `Inference` marks a derivation step, and `Result` marks a conclusion or application takeaway.

## 1. Generalized Coordinates and the Lagrangian

**Definition.** Use the generalized coordinate `q` to describe the system configuration. The corresponding generalized velocity is:


$$
\dot q=\frac{dq}{dt}
$$


Here `q` does not need to be a Cartesian coordinate. It can be an angle, a constrained length parameter, or any variable that uniquely describes the configuration.

**Definition.** The Lagrangian is defined as:


$$
L(q,\dot q,t)=T-V
$$


Here `T` is the kinetic energy and `V` is the potential energy.

**Result.** The Lagrangian formulation rewrites dynamics in terms of "kinetic minus potential energy." Instead of starting from force balance directly, it encodes the evolution through an energy-based structure.

## 2. Conjugate Momentum and the Euler-Lagrange Equation

**Definition.** The conjugate momentum associated with `q` is defined by:


$$
p=\frac{\partial L}{\partial \dot q}
$$


**Theory.** The physical trajectory satisfies the Euler-Lagrange equation:


$$
\frac{d}{dt}\left(\frac{\partial L}{\partial \dot q}\right)=\frac{\partial L}{\partial q}
$$


**Inference.** Using the conjugate momentum notation, this becomes:


$$
\dot p=\frac{\partial L}{\partial q}
$$


This shows that the rate of change of momentum is controlled by the partial derivative of the Lagrangian with respect to the coordinate.

**Result.** In the Lagrangian framework, the equation of motion is written as a single variational equation, without having to explicitly track every constraint force or coordinate correction term.

## 3. Action and the Stationary Principle

**Definition.** Given a path `q(t)`, the action is defined as:


$$
S[q]=\int_{t_0}^{t_1} L(q,\dot q,t)\,dt
$$


**Theory.** The true trajectory satisfies:


$$
\delta S=0
$$


This is the more accurate statement of the principle of least action: the action is stationary on the true trajectory, but not necessarily strictly minimal.

**Inference.** If we perturb the path while keeping the endpoints fixed and require the first variation to vanish, we recover the Euler-Lagrange equation.

**Result.** The "physical path" can be understood as the path among all admissible ones for which the first-order change in action vanishes.

## 4. Example: A Particle in a One-dimensional Potential

**Definition.** For a one-dimensional particle `x(t)`, a standard Lagrangian is:


$$
L(x,\dot x)=\frac{1}{2}m\dot x^2 - V(x)
$$


**Inference.** The corresponding conjugate momentum is:


$$
p=\frac{\partial L}{\partial \dot x}=m\dot x
$$


**Theory.** Substituting into the Euler-Lagrange equation gives:


$$
\frac{d}{dt}(m\dot x)=\frac{\partial L}{\partial x}=-V'(x)
$$


that is,


$$
m\ddot x=-V'(x)
$$


**Result.** This is exactly Newton's second law in a potential field. It shows that the Lagrangian framework is fully consistent with classical mechanics, but organized in a way that is better suited for constraints and coordinate changes.

## 5. From Lagrangian to Hamiltonian: The Legendre Transform

**Definition.** The Legendre transform changes variables from `(q,\dot q)` to `(q,p)`:


$$
H(q,p,t)=p\dot q-L(q,\dot q,t),
\qquad
p=\frac{\partial L}{\partial \dot q}
$$


For a multi-dimensional system, this becomes:


$$
H(q,p,t)=\sum_i p_i\dot q_i-L(q,\dot q,t)
$$


**Inference.** The key point is that `p` replaces `\dot q` as an independent variable. As a result, the Hamiltonian formulation lives in phase space `(q,p)` rather than a velocity-based configuration-space description.

**Theory.** For natural systems, when the kinetic energy is quadratic in velocity and the potential depends only on position, one often has:


$$
H=T+V
$$


**Result.** The Hamiltonian can often be interpreted as the total energy. It rewrites the system as a first-order dynamical system in position and momentum.

## 6. Hamilton's Equations

**Theory.** Differentiate the Hamiltonian:


$$
dH=d(p\dot q)-dL
$$


Using


$$
dL=\frac{\partial L}{\partial q}\,dq+\frac{\partial L}{\partial \dot q}\,d\dot q
=\dot p\,dq+p\,d\dot q
$$


we obtain:


$$
dH=\dot q\,dp-\dot p\,dq
$$


**Inference.** On the other hand, as a function of `(q,p)`,


$$
dH=\frac{\partial H}{\partial q}\,dq+\frac{\partial H}{\partial p}\,dp
$$


matching coefficients gives Hamilton's equations:


$$
\dot q=\frac{\partial H}{\partial p},
\qquad
\dot p=-\frac{\partial H}{\partial q}
$$


**Result.** The second-order Euler-Lagrange dynamics is split into a pair of first-order equations. This is the standard starting point for phase-space analysis, conservation laws, and numerical integration.

## 7. Symplectic Structure and Liouville's Theorem

**Definition.** Let the phase-space variable be:


$$
z=(q,p),
\qquad
J=
\begin{pmatrix}
0 & 1\\
-1 & 0
\end{pmatrix}
$$


Then the Hamiltonian system can be written as:


$$
\dot z=J\nabla H
$$


**Definition.** The symplectic 2-form on phase space is:


$$
\omega=dq\wedge dp
$$


It describes the geometric structure preserved by Hamiltonian flow.

**Theory.** If we define the vector field


$$
f(q,p)=
\left(
\frac{\partial H}{\partial p},
-\frac{\partial H}{\partial q}
\right)
$$


then its divergence is:


$$
\nabla\cdot f
=
\frac{\partial}{\partial q}\left(\frac{\partial H}{\partial p}\right)
-
\frac{\partial}{\partial p}\left(\frac{\partial H}{\partial q}\right)
=0
$$


**Result.**

- Hamiltonian flow preserves phase-space volume. This is Liouville's theorem.
- Intuitively, trajectories may stretch, bend, or fold, but they do not locally compress or expand phase-space area.
- If `\nabla\cdot f<0`, the system is typically dissipative; if `\nabla\cdot f>0`, the flow exhibits local volume expansion and is not Hamiltonian.

## 8. Why This Matters

**Result.**

- The Lagrangian framework shows that dynamics can be generated from a stationary condition on a scalar functional `S[q]`.
- The Hamiltonian framework shows that dynamics also carries stronger geometric structure: phase space, symplectic form, and volume preservation.
- In machine learning, these ideas directly influence Hamiltonian Monte Carlo, symplectic integrators, energy-based models, and long-horizon continuous-time modeling.
