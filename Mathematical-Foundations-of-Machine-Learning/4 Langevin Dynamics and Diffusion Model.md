# Langevin Dynamics and Diffusion Model

<div class="updated-time">Updated: 2026-03-30 17:59 AEDT</div>

Tag legend: `Definition` marks a definition, `Theory` marks an equation or principle, `Inference` marks a derivation step, and `Result` marks a conclusion or modeling takeaway.

## 1. Langevin Dynamics

**Definition.** Continuous-time Langevin dynamics can be written as:


$$
dX_t=-\nabla \Phi(X_t)\,dt+\sqrt{2}\,dW_t
$$


Here $\Phi(x)$ is the potential function and $W_t$ is standard Brownian motion.

**Inference.** If the target distribution is written as


$$
p_*(x)\propto e^{-\Phi(x)},
\qquad
\Phi(x)=-\log p_*(x)+C,
$$


then the drift term $-\nabla \Phi$ pushes particles toward lower-potential regions, while the noise term $\sqrt{2}\,dW_t$ keeps injecting random exploration.

**Result.**

- The drift term corresponds to moving downhill on an energy landscape.
- The diffusion term prevents the particles from collapsing too early into a local region.
- At equilibrium, the stationary distribution of the process is exactly the target distribution $p_*$.

In machine learning, $\Phi$ is often viewed as an energy / loss landscape.

## 2. Fokker-Planck Equation and Probability Current

**Theory.** The density evolution of the SDE above satisfies


$$
\frac{\partial p_t}{\partial t}
=
\nabla \cdot \bigl(p_t \nabla \Phi\bigr)+\Delta p_t.
$$


**Definition.** Define the probability current


$$
J_t(x)=-p_t(x)\nabla \Phi(x)-\nabla p_t(x),
$$


Then the continuity equation becomes


$$
\frac{\partial p_t}{\partial t}=-\nabla \cdot J_t.
$$


**Inference.** At equilibrium we have $\partial_t p_t=0$. If we additionally impose the zero-flux condition $J_t=0$, then


$$
\nabla p_*(x)=-p_*(x)\nabla \Phi(x),
$$


which is equivalent to


$$
\nabla \log p_*(x)=-\nabla \Phi(x).
$$


Integrating this identity gives


$$
p_*(x)\propto e^{-\Phi(x)}.
$$


**Result.** This shows that Langevin dynamics is not arbitrary noise injection. It recovers the target distribution through the balance between drift and diffusion.

## 3. From Itô's Formula to the General Fokker-Planck Equation

**Definition.** More generally, consider the isotropic Itô process


$$
dX_t=f(X_t,t)\,dt+g(t)\,dW_t.
$$


**Theory.** For any smooth test function $\varphi$, Itô's formula gives


$$
d\varphi(X_t)
=
\nabla \varphi(X_t)\cdot f(X_t,t)\,dt
+
\nabla \varphi(X_t)\cdot g(t)\,dW_t
+
\frac{g(t)^2}{2}\Delta \varphi(X_t)\,dt.
$$


The quadratic variation identities are


$$
\mathbb E[dW_t]=0,
\qquad
\mathbb E[(dW_t)^2]=dt.
$$


**Inference.** Taking expectation removes the stochastic term. Then integration by parts moves the derivatives onto the density $p_t$, which yields


$$
\frac{\partial p_t}{\partial t}
=
-\nabla \cdot \bigl(f(x,t)p_t(x)\bigr)
+
\frac{g(t)^2}{2}\Delta p_t(x).
$$


**Result.** Langevin dynamics is just a special case of this general form, with


$$
f(x)=-\nabla \Phi(x),
\qquad
g=\sqrt{2}.
$$


## 4. Forward Diffusion as an OU / VP Process

**Definition.** In diffusion models, a standard continuous-time forward process is


$$
dX_t=-\frac{1}{2}\beta(t)X_t\,dt+\sqrt{\beta(t)}\,dW_t.
$$


This is a time-inhomogeneous Ornstein-Uhlenbeck / variance-preserving (VP) process, corresponding to


$$
f(x,t)=-\frac{1}{2}\beta(t)x,
\qquad
g(t)=\sqrt{\beta(t)}.
$$


**Theory.** Substituting it into the general Fokker-Planck equation gives


$$
\frac{\partial p_t}{\partial t}
=
\frac{\beta(t)}{2}
\left[
\nabla \cdot \bigl(x p_t\bigr)+\Delta p_t
\right].
$$


**Inference.** If $p_t=\mathcal N(0,I)$, then


$$
\nabla p_t(x)=-x\,p_t(x),
$$


and


$$
\Delta p_t(x)=\bigl(\|x\|^2-d\bigr)p_t(x).
$$


Plugging these back in makes the right-hand side vanish, so the standard Gaussian is the equilibrium distribution of the process.

**Result.**

- As time increases, the data distribution is gradually pushed toward $\mathcal N(0,I)$.
- This is the essence of forward diffusion: progressively destroying structure until the distribution becomes close to pure noise.

## 5. Reverse-Time SDE

**Theory.** A classical result due to Anderson (1982) says that if the forward process is


$$
dX_t=f(X_t,t)\,dt+g(t)\,dW_t,
$$


then the time-reversed process, written in the convention used in these notes where we integrate from $T$ back to $0$, is also an SDE:


$$
dX_t=
\bigl[-f(X_t,t)+g(t)^2\nabla_x \log p_t(X_t)\bigr]dt
+
g(t)\,d\bar W_t.
$$


Here $\bar W_t$ is reverse Brownian motion. Under the more standard reverse-time convention the same statement appears with an equivalent sign change.

**Inference.** For the VP forward SDE,


$$
f(x,t)=-\frac{1}{2}\beta(t)x,
\qquad
g(t)=\sqrt{\beta(t)},
$$


so the reverse process becomes


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

- If we initialize $X_T\sim \mathcal N(0,I)$ and integrate this SDE backward to $t=0$, the endpoint is a data sample.
- The reverse drift is the forward drift corrected by a score term.

## 6. Why the Score Is Unknown

**Definition.** The hard quantity in the reverse SDE is the score


$$
\nabla_x \log p_t(x).
$$


The marginal density $p_t(x)$ is what you get after evolving the data distribution $p_0=p_{\mathrm{data}}$ forward to time $t$:


$$
p_t(x)=\int p_{t|0}(x\mid x_0)\,p_{\mathrm{data}}(x_0)\,dx_0.
$$


**Result.**

- We do not know $p_{\mathrm{data}}$ analytically.
- Therefore we do not know $p_t$ analytically either.
- Hence the true score $\nabla_x \log p_t(x)$ cannot be computed directly.

So we train a neural network


$$
s_\theta(x,t)\approx \nabla_x \log p_t(x).
$$


In conditional generation, the same idea becomes a conditional score such as $\nabla_x \log p_t(x\mid c)$, where $c$ can be a class label, a text embedding, or prompt information.

## 7. Denoising Score Matching

**Definition.** A natural learning objective is


$$
\mathcal L(\theta)
=
\mathbb E_{t,\,x\sim p_t}
\left[
\left\|s_\theta(x,t)-\nabla_x \log p_t(x)\right\|^2
\right].
$$


The issue is that the target score on the right-hand side is unknown.

**Theory.** For the linear VP forward process, the transition kernel is explicit:


$$
p_{t|0}(x\mid x_0)
=
\mathcal N\!\left(x;\,\alpha_t x_0,\sigma_t^2 I\right),
$$


with


$$
\alpha_t=\exp\!\left(-\frac{1}{2}\int_0^t \beta(s)\,ds\right),
\qquad
\sigma_t^2=1-\alpha_t^2.
$$


Its score is therefore


$$
\nabla_x \log p_{t|0}(x\mid x_0)
=
-\frac{x-\alpha_t x_0}{\sigma_t^2}.
$$


**Theory.** The denoising score matching identity, in the form used by Vincent (2011), says that


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


where $C_t$ is independent of $\theta$.

**Inference.** After expanding the squared norm, the only nontrivial term is the cross term


$$
\int s_\theta(x,t)\cdot \nabla_x \log p_t(x)\,p_t(x)\,dx
=
\int s_\theta(x,t)\cdot \nabla_x p_t(x)\,dx.
$$


Using


$$
p_t(x)=\int p_{t|0}(x\mid x_0)\,p_{\mathrm{data}}(x_0)\,dx_0,
$$


this cross term can be rewritten in terms of the known conditional kernel, and the remaining difference does not depend on $\theta$.

**Result.** DSM replaces an intractable marginal score target by the tractable score of a known Gaussian transition kernel.

## 8. From DSM to the DDPM Noise Objective

**Inference.** Reparameterize the forward sample as


$$
x=\alpha_t x_0+\sigma_t \epsilon,
\qquad
\epsilon\sim \mathcal N(0,I).
$$


Then


$$
-\frac{x-\alpha_t x_0}{\sigma_t^2}
=
-\frac{\epsilon}{\sigma_t}.
$$


Substituting this into the DSM target gives


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


**Theory.** If we parameterize the score model through a noise predictor,


$$
s_\theta(x,t)=-\frac{\epsilon_\theta(x,t)}{\sigma_t},
$$


then the objective becomes the standard DDPM loss of Ho et al. (2020):


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

- Reverse SDE sampling needs the score.
- DSM replaces the unknown marginal score by a conditional Gaussian score.
- Reparameterization turns that score target into a noise target.
- DDPM training is therefore a practical implementation of score learning.

## 9. Relation Between Langevin Dynamics and Diffusion Models

**Result.**

- Langevin dynamics directly uses the score of the target distribution: $\nabla_x \log p(x)=-\nabla \Phi(x)$.
- A diffusion model learns an entire time-indexed family of scores: $\nabla_x \log p_t(x)$.
- The forward process continuously Gaussianizes a complicated data distribution.
- The reverse process uses the learned score to pull noise back toward the data manifold.
- In this sense, reverse diffusion is a time-dependent Langevin-like dynamics driven by a learned score field.

In one sentence: Langevin dynamics answers "how to sample when the score is already known," while a diffusion model turns the problem into a family of noisy distributions, learns their scores, and then uses a reverse-time SDE to generate samples.

The full conceptual chain is


$$
\text{Langevin SDE}
\to
\text{Fokker-Planck}
\to
\text{forward Gaussianization}
\to
\text{reverse SDE needs score}
\to
\text{DSM equivalence}
\to
\text{noise prediction}.
$$

## References

- Anderson, B. D. O. (1982). Reverse-time diffusion equation models.
- Vincent, P. (2011). A connection between score matching and denoising autoencoders.
- Ho, J., Jain, A., and Abbeel, P. (2020). Denoising Diffusion Probabilistic Models.
