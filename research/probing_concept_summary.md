# Probing 概念体系总结

> 一份关于 probe / SAE / LoRA / Linear Representation Hypothesis / SSL 的结构化笔记。
>
> 按"**是什么 → 怎么做 → 怎么用 → 注意什么**"的顺序组织，每一节标注关键论文。

---

## 一、Probe 是什么

### 核心定义（Alain & Bengio 2016）

> **Linear probe** = 在神经网络某一冻结层的激活上独立训练的一个线性分类器，用来量化该层表示对一个预先指定概念的**线性可分性**。

形式化：

$$
g_\ell(h^{(\ell)}(x)) = W h^{(\ell)}(x) + b, \quad \text{(只更新 W, b；backbone 冻结)}
$$

三个不可缺要素：

1. **线性分类器**（容量受限）
2. **独立训练**（不影响 backbone）
3. **针对中间层激活**

### 数学等价物：方向向量

二分类时 probe 退化为：

$$
\hat{y}(x) = \text{sign}(v^\top h + b)
$$

其中 $v$ 就是该概念在表示空间中的**方向向量**。这就是 **Linear Representation Hypothesis (Park et al. 2024)** 的核心：

> **高层概念以方向（direction）的形式被线性编码在表示空间里。**

### Probe 在问什么

> **M 个我们关心的概念，是否在某一层表示中线性可分。**

这是 Alain & Bengio (2017) + Park et al. (2024) + Belinkov (2022) 三条文献链的共同精神。

---

## 二、Probe 的两种用途：诊断 vs 评测

这是整个领域**最容易混淆**的地方——同一个工具，两种目的。

| 维度 | **诊断型**（NLP/Interp 派） | **评测型**（FM 派） |
|---|---|---|
| 代表论文 | Hewitt & Liang, Belinkov, Tenney | DINO, MAE, SimCLR |
| 取哪一层 | 逐层（中间层重点） | 最后一层 |
| Probe 类型 | **严格线性** | **Linear + Non-linear 都报** |
| 关心 selectivity | 极度关心 | 不太关心 |
| 核心问题 | 信息在哪一层？ | backbone 实用性多强？ |
| Probe 角色 | 诊断工具（必须弱） | 实用性代理（可强可弱） |

**关键洞察**：两派不矛盾，是分工。**最佳实践是 linear + non-linear + fine-tune 三栏全报**。

---

## 三、为什么必须 linear + non-linear 两栏一起报

这条规律的根源是 SSL 训练目标的差异：

| SSL 类型 | 训练目标 | 表示性质 | 该报哪种 probe |
|---|---|---|---|
| **对比式**（SimCLR, DINO, CLIP, SleepFM） | InfoNCE | **天然线性可分** | linear 就够 |
| **生成式**（MAE, BEiT, GluFormer, CSFM, **FWAM**） | 重建 | **信息丰富但线性散乱** | 必须报 non-linear |

**MAE 困惑**：MAE 的 linear probe 低于对比学习，但 fine-tune 后超过——证明信息**存在**但不**线性可分**。

四种结果的诊断意义：

| Linear | Non-linear | 解读 |
|---|---|---|
| 高 | 高 | 表示干净又有信息 |
| 低 | 高 | 表示散乱但有信息（典型 MAE 系） |
| 高 | 高（接近） | 表示已接近上限 |
| 低 | 低 | 没学到东西 |

---

## 四、Probe 方法论的核心保险：Selectivity

### Hewitt & Liang (2019) 的洞察

> **Probe accuracy 高，可能是因为表示编码了概念，也可能是因为 probe 自己会学。光看一个数字区分不出来。**

### Control Task 实验

```
1. 真任务：用真实标签训 probe → P_real
2. Control task：用随机/打乱标签训同样 probe → P_random
3. Selectivity = P_real − P_random
```

诊断规则：

- **Selectivity 高（>20-30%）** → probe 数字可信
- **Selectivity 低** → probe 太强，数字不可信（不管多高）

### Linear probe 天然 selective

线性分类器的容量瓶颈**保证了它学不会随机标签**——这就是为什么解释性派坚持只用 linear probe。

四种结果的判断表：

| 真任务 acc | Random acc | Selectivity | 解读 |
|---|---|---|---|
| 95% | 50% | **+45%** | ✅ 表示真的编码了概念 |
| 95% | 90% | +5% | ❌ probe 太强了，结果不可信 |
| 60% | 50% | +10% | ⚠️ 表示编码弱信号，但 probe 没问题 |
| 50% | 50% | 0% | ❌ 表示没学到这个概念 |

---

## 五、Probe 的进阶：因果干预

普通 probe 只能证明**相关性**（"信息存在"），不能证明**因果性**（"模型在用这个信息"）。

| 方法 | 论文 | 做什么 |
|---|---|---|
| **Amnesic probing** | Elazar et al. 2021 | 用 INLP 擦除目标信息，看行为变化 |
| **INLP** | Ravfogel et al. 2020 | 迭代零空间投影，擦除线性可分信息 |
| **LEACE** | Belrose et al. 2023 | INLP 的闭式解改进，更精确擦除 |
| **Causal abstraction** | Geiger et al. | 干预 attention/MLP，看行为变化 |

→ 因果 probing 把 "信息在不在" 升级为 "信息有没有被用"。

---

## 六、SAE：probe 的无监督泛化

### 是什么

**SAE = Sparse Autoencoder**。架构上是一个**过完备**的两层自编码器，中间层维度远大于输入：

$$
x \xrightarrow{W_{enc} + \text{ReLU}} f \xrightarrow{W_{dec}} \hat{x}
$$

损失：$L = \|x - \hat{x}\|^2 + \lambda \|f\|_1$

### 和 probe 的关系

> **SAE 解码器 $W_{dec}$ 的每一列 = 一个无监督找到的 probe direction。**
>
> Probe 是给定概念找方向，SAE 是不预设概念、一次性找出所有方向、再事后解读。

### 关键贡献（Templeton et al., Anthropic 2024 — Claude 3 Sonnet）

- 在中间层残差流上训 1M / 4M / 34M 特征的 SAE
- 找到大量可解释的、跨模态、多语言的特征（Golden Gate Bridge、scam email 等）
- **干预**特征能改变行为（Golden Gate Claude）

### 但要小心的质疑

- 可分解 ≠ 模型在用这个分解
- 可解释 ≠ 真实（事后合理化风险）
- 干预成功 ≠ 因果证据
- 重建误差永远不为 0，丢失的信息可能正好关键

→ **SAE 是当前最 actionable 的解释性工具，但 claim 不能太强**。

---

## 七、Probe vs LoRA vs Fine-tune：完整谱系

```
                            适配能力 →
冻结 ──────────────────────────────────────── 完全可训练
  │←─── 外挂式 ────→│←──── 内嵌式 ────→│
  Linear probe       LoRA / Adapter           Full Fine-tune
  Non-linear probe   Prefix tuning
  
  ↑                  ↑                              ↑
读取已有方向        修改已有方向 +              重塑所有方向
                    创造少量新方向
```

### 关键区分

- **Probe**：在 backbone **外面**加 head，只能**读取**已有方向
- **LoRA**：在 backbone **内部**加低秩扰动，可以**创造**新方向
- **Fine-tune**：解冻所有参数，**重塑**整个表示空间

### 报哪几栏取决于 backbone 规模

| 模型规模 | 推荐评测 |
|---|---|
| <100M（FWAM 当前） | Linear + Non-linear + Full FT |
| 100M–1B | Linear + Non-linear + LoRA + Full FT |
| >1B（LLM） | Linear + Non-linear + LoRA（不再 full FT） |

---

## 八、Probe-as-Loss：把 probe 推回训练

> **不只是在评测时用 probe，而是把 probe loss 加进预训练目标里。**

### 代表工作

| 论文 | 做什么 |
|---|---|
| **Deeply Supervised Nets** (Lee 2015) | 远古辅助监督 |
| **GoogLeNet auxiliary classifier** (Szegedy 2015) | 中间层加分类 head |
| **REPA** (Yu et al. ICLR 2025) | 扩散模型对齐 DINOv2 → **17.5× 训练加速** |
| **LSEP** (2025) | 显式叫 "Linear Separability"，扩散模型加 linear probe loss |
| **对比学习（隐式）** | InfoNCE 本身就是隐式的 probe-aware loss |

### 为什么有效

1. **归纳偏置**：把 LRH 从评测假设升级为训练目标
2. **梯度捷径**：辅助 loss 在中间层注入语义信号
3. **特征解耦**：逼迫不同概念朝不同方向"分流"

### 对 FWAM 的直接启示

FWAM 是 MAE-style（生成式 SSL，线性散乱），**正好是 REPA 要解决的那种模型**。可以加 day/night、season、growth phase 等弱监督 probe loss 作为辅助。

---

## 九、SSL 是底层范式

| 范式 | 标签来源 |
|---|---|
| 监督学习 | 人工标注 |
| **SSL（自监督）** | **数据自己生成的伪标签** |
| 无监督 | 完全无标签（如 K-means） |

### 三大 SSL 范式

| 类型 | 例子 | Probe 表现 |
|---|---|---|
| **生成式** | GPT, BERT, MAE, FWAM | linear 弱，non-linear 强 |
| **对比式** | SimCLR, CLIP, DINO, SleepFM | linear 就够 |
| **蒸馏式** | BYOL, DINO | 类似对比 |

**FM 时代 ≈ SSL 时代**——所有大型基础模型都是 SSL 预训练的。

---

## 十、给你的具体应用：FWAM 评测协议

### 完整评测表

```
                        Random   FWAM    Selectivity
─────────────────────────────────────────────────────
Linear Probe
  Day/Night             0.51     0.92    +0.41
  Season                0.30     0.84    +0.54
  Heat stress           0.55     0.88    +0.33
  Light deficit         0.50     0.79    +0.29
  Vent state            0.52     0.81    +0.29
  Growth phase          0.34     0.71    +0.37
─────────────────────────────────────────────────────
Non-linear Probe (XGBoost)
  [same tasks]          ...      ...     ...
─────────────────────────────────────────────────────
Fine-tune upper bound   ...      ...
```

### 三个核心保障

1. **三栏全报**（linear / non-linear / fine-tune）→ 同时告诉读者表示的结构性、信息量、上限
2. **每个 probe 配 control task** → selectivity 证据
3. **逐层 probe（附录）** → 中间层往往更可迁移

### 免费 probe 标签清单（温室传感器场景）

**Tier 1：完全免费（时间/状态自动可得）**

| Probe 标签 | 难度 | 物理含义 |
|---|---|---|
| Day / Night | 易 | 昼夜节律 |
| Hour of day（分桶） | 中 | 更细粒度时间 |
| Season | 中 | 季节 |
| Heating ON/OFF | 易 | 加热系统状态 |
| Vent open/closed | 易 | 通风状态 |
| Light ON/OFF | 易 | 补光状态 |

**Tier 2：弱监督（基于阈值的"伪标签"）**

| Probe 标签 | 构造方式 | 物理含义 |
|---|---|---|
| High/Low CO2 | 阈值分桶 | 光合活跃度 |
| Heat stress | Tair > 30°C | 热胁迫 |
| Light deficit | PAR < 阈值 | 光不足 |
| VPD regime | 计算后分桶 | 蒸腾压力 |

**Tier 3：需要少量农艺知识**

| Probe 标签 | 构造方式 |
|---|---|
| Growth phase（vegetative/flowering/ripening） | 用日期 + 作物档案 |
| Anomaly type | 故障记录 |

---

## 十一、给你的研究的延伸方向

### 对 FWAM

| 用途 | 怎么做 |
|---|---|
| **评测** | 三栏 + 6 个免费 probe 标签 + selectivity |
| **预训练辅助 loss** | REPA-style 弱监督 probe loss |
| **诊断** | 逐层 probe，找哪一层 regime 最可分 |
| **可解释性** | 训 SAE 看自动发现哪些特征 |

### 对 RALF

| 用途 | 怎么做 |
|---|---|
| **验证 late-fusion 合法性** | LLM branch vs MLP branch 的 regime probe accuracy 对比 |
| **理论辩护** | LoRA 是 "在 LLM 内部创造 regime 方向"，是 probe 做不到的 |
| **因果证据** | 用 LEACE 擦除 LLM branch 的 regime 信息，看 RALF 性能掉多少 |

---

## 十二、必读论文清单（按优先级）

### 一定要读（4 篇）

1. **Belinkov (2022)** — *Probing Classifiers: Promises, Shortcomings, and Advances* — Computational Linguistics 48(1)
   - 30 分钟扫完，建立全局框架
2. **Hewitt & Liang (2019)** — *Designing and Interpreting Probes with Control Tasks* — EMNLP 2019
   - selectivity 的源头
3. **Lee et al. (2023)** — *Rethinking Evaluation Protocols of Visual Representations Learned via Self-supervised Learning* — arXiv:2304.03456
   - SSL probe 操作手册
4. **Park, Choe & Veitch (2024)** — *The Linear Representation Hypothesis and the Geometry of Large Language Models* — ICML 2024
   - 理论基础

### 想做 probe-as-loss

5. **Yu et al. (2025)** — *Representation Alignment for Generation: Training Diffusion Transformers Is Easier Than You Think (REPA)* — ICLR 2025
   - 最火的实例，扩散模型 17.5× 加速
6. **LSEP (2025)** — *No Alignment Needed for Generation: Learning Linearly Separable Representations in Diffusion Models* — arXiv:2509.21565
   - 显式 "linear separability" 损失

### 想做因果/SAE

7. **Elazar et al. (2021)** — *Amnesic Probing: Behavioral Explanation with Amnesic Counterfactuals* — TACL 2021
   - 因果 probing 入门
8. **Templeton et al. (Anthropic 2024)** — *Scaling Monosemanticity: Extracting Interpretable Features from Claude 3 Sonnet*
   - SAE 大规模实例
9. **Belrose et al. (2023)** — *LEACE: Perfect Linear Concept Erasure in Closed Form* — NeurIPS 2023
   - 精确擦除

### 奠基

10. **Alain & Bengio (2016)** — *Understanding intermediate layers using linear classifier probes* — arXiv:1610.01644
    - 引用 probe 时的祖师爷

### 补充（已在对话中提及）

- **Hewitt & Manning (2019)** — *A Structural Probe for Finding Syntax in Word Representations* — NAACL 2019
- **Voita & Titov (2020)** — *Information-Theoretic Probing with Minimum Description Length* — EMNLP 2020
- **Ravfogel et al. (2020)** — *Null It Out: Guarding Protected Attributes by Iterative Null-space Projection (INLP)* — ACL 2020
- **Marks & Tegmark (2023)** — *The Geometry of Truth: Emergent Linear Structure in LLM Representations of True/False Datasets*
- **Hernandez et al. (2023)** — *Linearity of Relation Decoding in Transformer Language Models*
- **Tenney et al. (2019)** — *BERT Rediscovers the Classical NLP Pipeline*

---

## 十三、一句话浓缩

> **Probe 是检验 "Linear Representation Hypothesis 是否在某一层成立" 的工具。**
>
> **它可以用来诊断（看信息在哪一层、以什么形式存在），可以用来评测（看 backbone 实用性多强），也可以用来训练（用 probe loss 强制表示线性可分）。**
>
> **它的可信度依赖容量约束（linear 才安全）和 selectivity 验证（control task 是金标准）。**
>
> **SAE 是 probe 的无监督泛化，LoRA 是 probe 触不到的"创造新方向"，三者构成现代 FM 的完整解释/适配/评测谱系。**

---

## 附录：核心术语速查

| 术语 | 中文 | 一句话定义 |
|---|---|---|
| **Probe** | 探针 | 在冻结表示上独立训练的辅助分类器 |
| **Linear probe** | 线性探针 | 容量受限的线性版本，用于诊断线性可分性 |
| **LRH (Linear Representation Hypothesis)** | 线性表示假说 | 概念以方向形式编码在表示空间 |
| **Selectivity** | 选择性 | P_real − P_random，衡量 probe 数字的可信度 |
| **Control task** | 控制任务 | 用随机标签训同样 probe 作为基线 |
| **SAE (Sparse Autoencoder)** | 稀疏自编码器 | 无监督找出所有 probe direction |
| **Superposition** | 叠加 | d 维空间塞下远多于 d 个几乎正交的方向 |
| **LoRA** | 低秩适配 | 在 backbone 内加低秩扰动，创造新方向 |
| **SSL** | 自监督学习 | 用数据自己生成的伪标签做监督学习 |
| **MAE-style / Generative SSL** | 生成式 SSL | 重建被 mask 的数据，表示线性散乱 |
| **Contrastive SSL** | 对比式 SSL | 拉近同类推远异类，表示天然线性可分 |
| **REPA** | 表示对齐 | 用预训练 encoder 的表示作为辅助 loss |
| **Amnesic probing** | 健忘探针 | 擦除某属性后看行为变化，做因果 probing |
| **LEACE** | 闭式概念擦除 | INLP 的精确版本 |

---

*生成日期：2026-05-20*  
*基于与 Claude 的对话整理*
