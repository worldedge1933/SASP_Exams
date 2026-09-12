// -----------------
// Cover
// -----------------
#set page(
  margin: (top: 22mm, bottom: 22mm, left: 18mm, right: 18mm),
  columns: 1,
  background: none,
  numbering: none,
)

#place(center, dy: 80mm)[
  #set text(size: 22pt, weight: "bold")
  #align(center)[SSSP exams]
]

#place(bottom + center, dy: -10mm)[
  #set text(size: 12pt, weight: "regular")
  #align(center)[基于米兰理工大学（Politecnico di Milano）\ 2026 Spring《Sound analysis, synthesis and processing》课程]

  #v(0.8em)
  #set text(size: 11pt)
  #align(center)[作者：#link("https://github.com/worldedge1933/SASP_Exams")[\@worldedge1933]]

  #v(0.6em)
  #align(center)[2026-09-12]
]


#pagebreak()

// -----------------
// Notes
// -----------------
#set page(
  margin: (top: 22mm, bottom: 22mm, left: 18mm, right: 18mm),
  columns: 1,
  background: none,
  numbering: none,
)

#set text(size: 18pt, weight: "bold")
#align(left)[说明]

#v(0.6em)
#line(length: 100%, stroke: 0.6pt)

#v(1.2em)
#set text(size: 11pt, weight: "regular")

本笔记为非官方的 SSSP 课程考试题目整理，仅供学习与复习参考。题目来自米兰理工大学 (Politecnico di Milano) 2026 Spring《Sound Analysis, Synthesis and Processing》课程模块 Sound synthesis and spatial processing 的历年考试，并按课程主题归类编排；目前尽可能收录了自 2021 年以来的试卷内容。

对于重复出现的题目，仅在首次出现处给出参考答案，后续仅保留题目。答案均为个人整理与撰写，可能存在错误或遗漏；如与课程讲义、教师说明或当年试题不一致，请以官方资料为准。

自 2026 年 7 月起，试题风格出现较大变化，考察知识点改变且计算类题目明显增多。因此，本笔记另完整收录了 2026 年 9 月两套试卷（未附答案），供复习时参考。

#pagebreak()

// -----------------
// Table of contents
// -----------------
#set page(
  margin: (top: 22mm, bottom: 22mm, left: 18mm, right: 18mm),
  columns: 1,
  background: none,
  numbering: none,
)

#set text(size: 18pt, weight: "bold")
#align(center)[目录]

#v(1.2em)
#set text(size: 11pt, weight: "regular")
#show outline.entry.where(level: 1): set block(above: 2em, below: 1.2em)
#outline(depth: 2)

#pagebreak()

// -----------------
// Main document
// -----------------
#set page(
  margin: (top: 18mm, bottom: 18mm, left: 10mm, right: 10mm),
  columns: 2,
)

#set page(background: context {
  // 正文区域宽度（不含左右页边距）
  let textw = page.width - page.margin.left - page.margin.right
  // gutter 的中线刚好在正文区域的 50% 处（两栏对称时）
  let x = page.margin.left + 0.5 * textw

  // 竖线从正文顶部到正文底部（不含上下页边距）
  let y = page.margin.top
  let h = page.height - page.margin.top - page.margin.bottom

  place(
    top + left,
    dx: x,
    dy: y,
    line(length: h, angle: 90deg, stroke: 0.5pt),
  )
})
#counter(page).update(1)
#set page(
  numbering: "1",
  number-align: center + bottom,
)


#set text(size: 10.5pt)
#set par(justify: true, leading: 0.65em)

#show heading.where(level: 1): set block(below: 2em, above: 2em)
#show heading.where(level: 2): set block(below: 1.5em, above: 2em)
#show heading.where(level: 3): set block(below: 1.3em)

#show heading.where(level: 1): set text(fill: red)
#show heading.where(level: 2): set text(fill: blue, font: "Microsoft YaHei")
#show heading.where(level: 3): set text(weight: "regular")

#show heading.where(level: 1): it => [
  #colbreak(weak: true)
  #it
]

#let note(body) = [
  #text(fill: gray)[注：#body]
]










= Oscillator and DPW

== 1
Q: Describe the matrix data model of a sinusoidal (ballistic) oscillator, and the conditions that the matrix must satisfy in order to behave like an oscillator. Offer an interpretation of such conditions based on eigenvalue decomposition. (2025-07-18)


A:


A sinusoidal ballistic oscillator can be described by a two-dimensional state vector whose next state is obtained through a linear transformation of the current state

$
mat(hat(x)_1; hat(x)_2)
=
A mat(x_1; x_2)
=
mat(a,b;c,d) mat(x_1;x_2)
$

Since the oscillator is ballistic, after initialization it evolves freely by repeatedly applying the same matrix

$
bold(x)_n = A^n bold(x)_0
$

For the system to behave as a sustained oscillator, the matrix must satisfy

$
det(A) = a d - b c = 1
$

$
abs(a+d) < 2
$

The first condition gives unit loop gain, so the oscillation does not exponentially grow or decay. Together with the second condition, it ensures that the two eigenvalues of the real matrix are a complex-conjugate pair with unit magnitude

$
lambda_(1,2) = e^(plus.minus j theta)
$

where

$
theta = arccos((a+d)/2)
$

Using the eigenvalue decomposition

$
A = Q D Q^(-1)
$

$
D = mat(e^(j theta),0;0,e^(-j theta))
$

we obtain

$
A^n = Q D^n Q^(-1)
$

$
D^n = mat(e^(j n theta),0;0,e^(-j n theta))
$

Therefore, in the eigenvector basis, the state consists of two complex-conjugate rotations in opposite directions. Mapping them back through $Q$ produces a real sinusoidal oscillation. The angle $theta$ is the phase increment per iteration and therefore determines the oscillation frequency

$
f_0 = theta F_s / (2 pi)
$


== 2
Q: Briefly describe how to implement a generic discrete oscillator in matrix form and describe some of the oscillators you can implement with it. (2025-06-23)


A:

A generic discrete oscillator can be implemented with two state variables updated by a constant $2 times 2$ matrix

$
mat(hat(x)_1; hat(x)_2)
=
A mat(x_1; x_2)
=
mat(a,b;c,d) mat(x_1;x_2)
$

At each sample, the new state is obtained from the previous one by the same linear transformation. To obtain a sustained sinusoidal oscillation, the matrix should satisfy

$
det(A)=a d-b c=1
$

$
abs(a+d)<2
$

These conditions give a pair of complex-conjugate eigenvalues with unit magnitude, so the state evolves as a rotation rather than growing or decaying.

Different choices of $A$ lead to different oscillator structures. For example, a coupled-form oscillator can use the rotation matrix

$
A=
mat(cos(theta),-sin(theta);sin(theta),cos(theta))
$

A biquad oscillator is obtained with

$
A=
mat(k,-1;1,0)
$

$
k=2cos(theta)
$

A digital-waveguide oscillator is obtained with

$
A=
mat(k,k-1;k+1,k)
$

$
k=cos(theta)
$

Different matrix structures can therefore realize equal-amplitude or quadrature outputs with different computational costs

== 3
Q: DPW for sawtooths and its advantages over the ramp function. (2025-01-08)


A:

The direct ramp method generates a sawtooth by sampling a continuous-time linear ramp or, equivalently, by using a bipolar modulo counter. Since an ideal sawtooth is not band-limited, harmonics above the Nyquist frequency fold back into the audible band and produce strong aliasing.

The Differentiated Parabolic Wave (DPW) method reduces this problem. It first generates the trivial sawtooth $r(n)$ and squares it to obtain a piecewise parabolic waveform

$
p(n) = r^2(n)
$

The parabolic waveform is then differentiated using the first-order FIR differentiator

$
D(z) = 1 - z^(-1)
$

and the result is properly scaled to obtain a sawtooth-like signal.

The key advantage is that the spectrum of the parabolic waveform decays at about $-12$ dB/octave, so high-frequency components produce much less aliasing before differentiation. Therefore, DPW produces a sawtooth with significantly reduced aliasing compared with direct ramp sampling, while remaining computationally simple and efficient.

== 4
Q: Describe different methods for generating a sawtooth waveform. (2024-07)


A:

A sawtooth waveform can be generated in several ways.

1. The simplest method is to sample an ideal continuous-time ramp, or equivalently to use a bipolar modulo counter

$
s(n) = 2 [ n f_0 / F_s ]_("mod 1") - 1
$

This method is very simple, but it produces strong aliasing because the ideal sawtooth contains infinitely many harmonics and those above the Nyquist frequency fold back into the audible band.

2. A band-limited sawtooth can be obtained by additive synthesis, summing only the harmonics below the Nyquist frequency

$
s(n) = - sum_(k=1)^K 1/k sin(2 pi k f_0 n / F_s)
$

This strongly reduces aliasing, but its computational cost grows with the number of harmonics $K$, especially for low fundamental frequencies.

3. The Differentiated Parabolic Wave method first generates the trivial sawtooth, squares it to obtain a piecewise parabolic waveform, and then differentiates it with

$
D(z) = 1 - z^(-1)
$

The result is then properly scaled. Since the parabolic waveform has a faster spectral decay, DPW produces much less aliasing than direct ramp sampling while remaining computationally efficient.

Further aliasing reduction can be obtained by oversampling the DPW signal and then applying a low-pass decimation filter

== 5
Q: Sinusoidal oscillator:

- Derive the matrix data model of a dynamical system implementing a sinusoidal oscillator starting from trigonometric equations.
- Explain how to generalize the matrix of this model: what conditions does the matrix need to satisfy?
- Offer an interpretation of such conditions based on eigenvalue decomposition. (2024-02-09)


A:

Starting from the trigonometric identities

$
cos(phi + theta) = cos(phi) cos(theta) - sin(phi) sin(theta)
$

$
sin(phi + theta) = cos(phi) sin(theta) + sin(phi) cos(theta)
$

define the two state variables as the cosine and sine components of the oscillator. Their next values are

$
hat(x)_1 = cos(theta) x_1 - sin(theta) x_2
$

$
hat(x)_2 = sin(theta) x_1 + cos(theta) x_2
$

Hence, the oscillator can be written in matrix form as

$
mat(hat(x)_1; hat(x)_2)
=
mat(cos(theta), -sin(theta); sin(theta), cos(theta))
mat(x_1; x_2)
$

The matrix is a rotation matrix: at every iteration the state vector is rotated by the angle $theta$. Therefore, the oscillation frequency is

$
f_0 = theta F_s / (2 pi)
$

The model can be generalized to

$
mat(hat(x)_1; hat(x)_2)
=
A mat(x_1; x_2)
$

with

$
A = mat(a,b;c,d)
$

For this system to behave as a sustained oscillator, the matrix must satisfy the Barkhausen conditions

$
det(A) = a d - b c = 1
$

$
abs(a + d) < 2
$

The first condition gives unitary loop gain, while the two conditions together ensure that the eigenvalues are a complex-conjugate pair with unit magnitude.

Using eigenvalue decomposition

$
A = Q D Q^(-1)
$

we obtain

$
A^n = Q D^n Q^(-1)
$

where

$
D = mat(e^(j theta),0;0,e^(-j theta))
$

and

$
theta = arccos((a + d)/2)
$

Thus, in the eigenvector basis, the dynamics correspond to two complex-conjugate rotations in opposite directions. $Q$ maps the state into this internal space and $Q^(-1)$ maps it back to the real state space. Since the eigenvalues have unit magnitude, the oscillation neither grows nor decays

== 6
Q: Describe the Differentiated Parabolic Waveform (DPW) algorithm for reducing aliasing in discontinuous waveform generation. (2024-02-09)


A:

== 7
Q: Describe the Differentiated Parabolic Waveform (DPW) algorithm for reducing aliasing in discontinuous waveform generation. (2023-06-26)




A:


== 8
Q: Describe the matrix data model of a sinusoidal (ballistic) oscillator, and the conditions that the matrix must satisfy in order to behave like an oscillator. Offer an interpretation of such conditions based on eigenvalue decomposition. (2022-07-15)


A:



== 9
Q: Describe how to implement an oscillator in the form of a dynamical systems, in free evolution, starting from trigonometric formulas. (2022-06-24)


A:



== 10
Q: Briefly describe how to implement a generic dynamic oscillator in matrix form and describe an example oscillator that you can implement with it. (2022-01-17)


A:

A generic dynamic oscillator can be implemented with two state variables updated by a constant $2 times 2$ matrix

$
mat(hat(x)_1; hat(x)_2)
=
A mat(x_1; x_2)
$

with

$
A = mat(a,b;c,d)
$

At each iteration, the new state is obtained from the previous one by the same linear transformation. For sustained oscillation, the matrix must satisfy

$
det(A) = a d - b c = 1
$

$
abs(a + d) < 2
$

An example is the biquad oscillator

$
A = mat(k,-1;1,0)
$

with

$
k = 2 cos(theta)
$

which corresponds to the recursion

$
x(n) = k x(n-1) - x(n-2)
$

and generates a sinusoidal oscillation whose frequency is determined by $theta$

== 11
Q: Sinusoidal oscillator:

a) Derive the matrix data model of a dynamical system implementing a sinusoidal oscillator starting from trigonometric equations.

b) Explain how to generalize the matrix of this model: what conditions does the matrix need to satisfy?

c) Offer an interpretation of such conditions based on eigenvalue decomposition. (2021-07-13)


A:

== 12
Q: Briefly describe how to implement a dynamic oscillator starting from trigonometric formulas. (2020-06-17)


A:

== 13
Q: Describe the Differentiated Parabolic Waveform (DPW) algorithm for reducing aliasing in discontinuous waveform generation. (2020-06-15)


A:

== 14
Q: Describe the Differentiated Parabolic Waveform (DPW) algorithm for reducing aliasing in discontinuous waveform generation. (unknown)


A:

= Nonlinear

== 1
Q: Describe nonlinear modeling of sounds and explain why this approach is useful. Explain the differences between waveshaping and modulations. Define harmonic distortion, write a formula for it and comment it, and explain for which types of nonlinear modeling this definition has a relevant meaning. (2025-06-23)


A:

Nonlinear modeling uses nonlinear transformations to modify or generate spectral components. Unlike LTI systems, which can only change the amplitude and phase of existing components, nonlinear systems can create new frequencies. This is useful for spectral enrichment, modeling nonlinear devices such as tube amplifiers, spectral shifting, and generating complex sounds from simple signals.

Waveshaping is a memoryless nonlinear mapping: the output depends only on the current input sample

$
y(n) = F(x(n))
$

For example, a polynomial approximation can be written as

$
y(n) = sum_(i=0)^N a_i x^i (n)
$

A sinusoidal input therefore generates harmonics at integer multiples of its frequency.

Modulation instead uses one signal to modify another signal. Examples are ring modulation, amplitude modulation and frequency modulation. It mainly produces shifted spectral components or sidebands. For example, ring modulation multiplies two signals, while FM changes the instantaneous phase or frequency of a carrier.

For a sinusoidal input

$
x(n) = A cos(omega_0 n)
$

a nonlinear system may produce

$
y(n) = sum_(k=0)^N A_k cos(k omega_0 n)
$

Harmonic distortion is measured by the total harmonic distortion

$
"THD" = sqrt((sum_(k=2)^N A_k^2)/(sum_(k=1)^N A_k^2))
$

It measures the relative amount of energy contained in the generated harmonics, excluding the fundamental from the numerator. A larger THD therefore means stronger nonlinear harmonic distortion.

This definition is especially meaningful for nonlinear mappings such as waveshaping, where a sinusoidal input produces components at integer multiples of the input frequency. It is generally less meaningful for modulation techniques, because modulation can generate sidebands or inharmonic components that are not harmonics of the original sinusoid.

== 2
Q: Describe the NonLinear Modeling of sounds and explain when and why this approach is useful. Explain the differences between waveshaping and modulations. Define harmonic distortion, please write a formula for it and comment it, and explain for which types of nonlinear modeling this definition has a relevant meaning. (2022-09-07)


A:

== 3
Q: Briefly describe the frequency modulation method for sound synthesis. What are operators, and what are the interconnection options? (2022-06-24)




A:

Frequency modulation (FM) synthesis generates complex spectra by modulating the instantaneous phase or frequency of a sinusoidal carrier with another signal. With a sinusoidal modulator

$
phi(n) = I(n) sin(omega_m (n)n)
$

the synthesized signal is

$
s(n) = a(n) sin(omega_c (n)n + I(n) sin(omega_m (n)n))
$

The modulation creates sidebands at frequencies

$
abs(omega_c + k omega_m)
$

and their amplitudes are controlled by the modulation index $I$. FM synthesis is versatile, computationally efficient, and can generate rich spectra with relatively few parameters.

An operator is an oscillator or FM module used as a building block of the synthesis structure. An operator can act as a carrier, whose output contributes to the final sound, or as a modulator, whose output modulates another operator.

The main interconnection options are:

- Basic modulation: one modulator controls one carrier
- Compound modulation: several modulators are summed and jointly modulate one carrier
- Nested modulation: one modulator is itself modulated by another operator, forming a cascade
- Feedback modulation: a delayed previous output of an operator is fed back to modulate itself

Different interconnections produce different spectral structures and allow complex sounds to be generated with a small number of oscillators


== 4
Q: Describe waveshaping methods for nonlinear signal modeling/synthesis. Explain the difference between using a symmetrical or an asymmetrical nonlinear characteristic. (2022-01-17)


A:

Waveshaping is a memoryless nonlinear synthesis method: each output sample depends only on the current input sample through a nonlinear distortion function

$
y(n) = F(x(n))
$

The nonlinear characteristic can be approximated by a polynomial

$
y(n) = sum_(i=0)^N a_i x^i (n)
$

When the input is sinusoidal, the nonlinear terms generate new harmonics, so waveshaping can enrich the spectrum and produce effects such as overdrive and distortion.

With a symmetrical characteristic, the nonlinear function is odd and positive and negative input values are processed symmetrically. It mainly generates odd harmonics. It is typically approximately linear for small input amplitudes and saturates as the amplitude increases

$
F(-x) = -F(x)
$

With an asymmetrical characteristic, positive and negative input values are processed or clipped differently. The characteristic is no longer odd, so both even and odd harmonics are generated. This can model nonlinear behavior such as that of triode tubes

== 5
Q: Sound synthesis through nonlinear distortion:

a) Describe sound synthesis based on waveshaping.

b) What is the purpose of the nonlinearity in this process? How does its symmetry/asymmetry affect the result?

c) Can phase or frequency modulation be classified as a waveshaping method? Please justify your answer. (2021-07-13)


A:

a) Waveshaping is a memoryless nonlinear synthesis method in which each output sample is obtained by applying a nonlinear distortion function to the current input sample

$
y(n) = F(x(n))
$

The nonlinear function can be approximated by a polynomial

$
y(n) = sum_(i=0)^N a_i x^i (n)
$

If the input is sinusoidal, the nonlinear terms generate new harmonic components, producing a spectrally richer sound.

b) The purpose of the nonlinearity is to generate new spectral components that cannot be produced by an LTI system. It can therefore be used for spectral enrichment and for effects such as overdrive and distortion.

A symmetric characteristic is typically an odd function

$
F(-x) = -F(x)
$

so positive and negative samples are treated symmetrically and mainly odd harmonics are generated.

An asymmetric characteristic treats positive and negative samples differently, so both even and odd harmonics are generated. It can approximate nonlinear behavior such as that of triode tubes.

c) No. Phase and frequency modulation are not waveshaping methods. Waveshaping is a static memoryless mapping from the current input sample to the current output sample. In phase or frequency modulation, one signal controls the phase or frequency of an oscillator and produces sidebands. In FM, the phase is also updated recursively

$
phi(n) = phi(n - 1) + omega_c (n)n + phi_m (n)
$

Therefore, modulation is based on changing an oscillator parameter rather than applying a memoryless nonlinear function directly to an input sample


== 6
Q: Describe waveshaping methods for nonlinear signal modeling/synthesis. Explain the difference between using a symmetrical or an asymmetrical nonlinear characteristic. (2020-06-17)


A:

= Wave table and Granular

== 1
Q: Describe the sinusoidal + noise analysis model and explain how the noise envelope is extracted for synthesis. (2024-09-04)


A:

The sinusoidal + noise model represents a sound as the sum of a deterministic sinusoidal component and a stochastic noise component

$
s(t) = sum_(r=1)^R A_r (t) cos(theta_r (t)) + e(t)
$

The sinusoidal part is obtained by STFT peak detection and tracking, while $e(t)$ is the residual and is modeled as time-varying filtered white noise.

To extract the noise envelope, the sinusoidal component is first reconstructed and subtracted from the original signal, either in the frequency domain or in the time domain. The magnitude spectrum of the residual is then approximated by a piecewise-linear spectral envelope.

For synthesis, this envelope is combined with a random phase spectrum and transformed back to the time domain by IFFT. The synthesized stochastic component is finally added to the resynthesized sinusoidal component.

== 2

Q: Describe a sinusoidal wavetable oscillator and explain how to generate a wave with a different frequency if the recorded sound has to be modified. (2024-09-04)


A:

A sinusoidal wavetable oscillator pre-computes one period of a sinusoid and stores its $L$ samples in a circular table. If $T_s$ is the sampling period, the stored period is

$
T_0 = L T_s
$

To generate a sinusoid with a desired frequency $f_0$, the table index is advanced at each output sample by

$
Delta = (f_0 L) / F_s
$

where $F_s$ is the sampling frequency. If $Delta$ is fractional, interpolation between adjacent table samples is required.

For a recorded sound, one or more periods of its sustain part can be stored and cyclically read. Changing the reading increment changes the reproduced pitch, while the attack transient can be reproduced directly from the original samples.

== 3
Q: Describe the principles behind granular synthesis. What are grains and what does the granulation process consist of? What types of granulations are commonly used? (2023-09-05)


A:

Granular synthesis assumes that a sound can be represented as a sequence of many small elementary acoustic events called grains, possibly overlapping. The waveform, amplitude and temporal location of the grains determine the resulting timbre.

Granulation consists of selecting or generating short sound segments, shaping them with an amplitude envelope, and organizing and combining them in time, usually by overlap-add. The temporal organization is important to avoid discontinuities and artifacts.

Granular synthesis can use sampled sounds or abstractly generated grains. Common high-level organizations include Fourier or wavelet grids, pitch-synchronous overlapping streams (PSGS), asynchronous granular clouds (AGS), and time-granulated or sampled-sound streams. PSGS uses seamless joins such as SOLA or PSOLA, while AGS distributes grains irregularly on the time-frequency plane, often randomly within a controlled mask.

== 4
Q: Consider the problem of sound synthesis by means of signal-based approaches.

- Briefly report the idea behind the wavetable synthesis method.
- Define and describe the Synchronous Overlap and Add (SOLA) method, explaining which is the wavetable synthesis problem that it can help solving. (2023-07-19)


A:

a) Wavetable synthesis extends the wavetable-oscillator idea to sampled, non-sinusoidal waveforms. The attack can be reproduced directly, while one or more periods of the sustain part are stored in a buffer and cyclically read. The reading increment determines the reproduced pitch.

b) SOLA, Synchronous Overlap and Add, joins successive signal segments by overlapping them and adjusting their relative position so that the waveforms match well in the overlap region, then smoothly combining the overlapping parts. In wavetable synthesis, it helps reduce discontinuities and audible artifacts at loop boundaries, producing smoother and nearly seamless joins.

== 5
Q: Give a general description of granular synthesis and its practical use for the production of music. (2023-06-26)


A:


Granular synthesis represents a complex sound as a large number of short elementary acoustic events called grains, which may overlap in time. The waveform, amplitude and temporal position of the grains determine the resulting timbre.

In practice, grains can be extracted from sampled sounds or generated synthetically, shaped by an amplitude envelope, and combined using overlap-add. By controlling grain timing, density and distribution, granular synthesis can create evolving textures, noisy sounds and transformed versions of recorded material. Common organizations include pitch-synchronous streams and asynchronous granular clouds.

== 6
Q: Briefly describe how to implement a digital oscillator based on wavetable method. Explain pros and cons of such a solution and how to implement interpolation between samples. (2023-06-26)


A:

A wavetable oscillator pre-computes one period of a waveform and stores $L$ equally spaced samples in a circular table. The table is read cyclically. For a desired frequency $f_0$, the table position is advanced at each output sample by

$
Delta = (f_0 L) / F_s
$

Pros: the waveform is generated by table lookup instead of computing it sample by sample, and different frequencies can be obtained from the same table by changing $Delta$.

Cons: a finite table has limited resolution, and fractional reading positions require interpolation. A larger table gives better accuracy but requires more memory.

For linear interpolation, let the desired table position be $p = i + alpha$, where $i$ is the integer part and $0 <= alpha < 1$. Using two adjacent table samples $x[i]$ and $x[i+1]$

$
y = (1-alpha)x[i] + alpha x[i+1]
$

== 7
Q: Briefly describe how to implement a digital oscillator based on wavetable method. Explain pros and cons of such a solution and how to implement interpolation between samples. (2022-02-11)


A:

== 8
Q: Describe granular synthesis in general terms. What are grains and what does the granulation process consist of? What types of granulations are commonly used and in what situations? (2021-08-31)


A:


Granular synthesis assumes that a sound can be represented as a sequence of short elementary acoustic events called grains, possibly overlapping. The waveform, amplitude and temporal location of the grains determine the resulting timbre.

Granulation consists of selecting or generating short sound segments, shaping them with an amplitude envelope, and organizing them in time. The grains are usually windowed and combined by overlap-add. Their timing must be carefully controlled to avoid discontinuities and artifacts.

Common organizations are pitch-synchronous granular synthesis, asynchronous granular synthesis, and time-granulation of sampled sounds. Pitch-synchronous streams use seamless joins such as SOLA or PSOLA and are useful for pitched signals. Asynchronous granular synthesis distributes grains irregularly on the time-frequency plane and is useful for producing evolving sound textures and natural noisy sounds, where statistical properties are more important than the exact waveform evolution. Time-granulation is mainly used to transform recorded sounds.


= Effects

== 1
Q: Explain why comb filters cannot be usefully cascaded but allpass filters can, and state the corresponding rule for how each type should be combined. (2026-07-23)


A:

Comb filters should not be cascaded because cascading multiplies their transfer functions, so frequency peaks that are not shared by all the comb filters are cancelled. Therefore, comb filters should be combined in parallel.

Allpass filters can be cascaded because the cascade of allpass filters is still an allpass filter: their magnitude response remains flat, while their phase responses add. Therefore, allpass filters should be combined in cascade.


== 2
Q: Describe with the help of a block diagram how to implement a first-order shelving filter for digital audio equalization. Focus in particular on explaining the role of the all-pass filter in the design. (2025-06-23)


A:

A first-order shelving filter is obtained by combining a direct path with a first-order all-pass filter:

#figure(
  image("media/first-order-shelving-filters.png", width: 80%),
)

Its transfer function is

$
H(z) = 1 + H_0/2 [1 plus.minus A(z)]
$

where

$
A(z) = (a + z^(-1))/(1 + a z^(-1))
$

The plus sign gives a low-frequency shelving filter, while the minus sign gives a high-frequency shelving filter.

The all-pass filter has unit magnitude but a frequency-dependent phase response. Therefore, when its output is added to or subtracted from the direct signal, constructive or destructive interference depends on frequency. This creates the shelving transition without directly changing the magnitude inside the all-pass branch. The coefficient $a$ controls the cutoff frequency, while $H_0$ controls the amount of boost or cut



== 3
Q: Describe the equalizer pipeline, indicating which filters are used for its implementation. Explain, with the help of a block diagram, how these filters can be implemented with all-pass filters. (2024-09-04)


A:


A typical digital audio equalizer is implemented as a cascade of filters:

#figure(
  image("media/EQ-structure.png", width: 80%),
)

The low-frequency range is controlled by a low-frequency shelving filter, the mid-frequency range by a series of peaking filters, and the high-frequency range by a high-frequency shelving filter.

The first-order shelving filters can be implemented using a direct path and a first-order all-pass filter:

#figure(
  image("media/first-order-shelving-filters.png", width: 80%),
)

$
H(z) = 1 + H_0/2 [1 plus.minus A(z)]
$

$
A(z) = (a + z^(-1))/(1 + a z^(-1))
$

The plus sign gives a low-frequency shelving filter and the minus sign gives a high-frequency shelving filter. The coefficient $a$ sets the cutoff frequency, while $H_0$ sets the boost or cut.

The mid-frequency peaking filters can be implemented in the same way using a second-order all-pass filter:

#figure(
  image("media/second-order-shelving-filters.png", width: 80%),
)

$
H(z) = 1 + H_0/2 [1 - A_2(z)]
$

$
A_2(z) = (-a + d(1-a)z^(-1) + z^(-2))/(1 + d(1-a)z^(-1) - a z^(-2))
$

Here $d$ controls the center frequency, $a$ controls the bandwidth, and $H_0$ controls the gain. Thus, shelving and peaking equalizer sections are obtained by combining a direct signal with appropriately phase-shifted all-pass outputs

== 4
Q: What information can we perceptually gather from early reflections? What about late reverberations? When and how do we decide that the early reflection phase of the room impulse response turns into a late reverberation phase? (2024-02-09)


A:

Early reflections convey information about the geometry and materials of the surrounding space and about our position relative to that space.

Late reverberation conveys more global and qualitative properties of the environment, such as room size, overall absorption, and the perceived pleasantness of the reverberation.

The transition from early reflections to late reverberation occurs when the echoes become sufficiently dense that an individual deterministic description is no longer useful and a statistical description becomes appropriate. A practical rule is to take roughly the first $100$ ms as early reflections, but a better criterion is to test when the response becomes statistically diffuse. This can be done by checking Gaussianness of short-time amplitude histograms, fitting an exponential decay to the EDC, or examining the crest factor

== 5
Q: If we want to build a late reverberation scheme, what kind of elementary IIR blocks do we use and how do we combine them together? How do we control the density of echoes and the density of resonances in the late reverberation using such combinations of blocks? (2024-02-09)

A:

For late reverberation, the main elementary IIR blocks are feedback comb filters and all-pass filters.

Comb filters cannot be usefully cascaded, so several comb filters with different delay lengths are connected in parallel. All-pass filters, instead, are cascaded. A typical Schroeder structure is therefore

#raw("x(n) → parallel comb-filter bank → cascaded all-pass filters → y(n)", block: true)

The parallel comb filters generate the resonant modes and the decaying echoes, while the cascaded all-pass filters act as diffusers, increasing echo density without changing the overall magnitude response.

For $N$ parallel comb filters with delay times $tau_i$, the modal density is approximately

$
D_m = sum_i tau_i = N overline(tau)
$

and the echo density is

$
D_e = sum_i 1/tau_i approx N/overline(tau)
$

Therefore, the desired densities can be controlled by the number of comb filters and their delay lengths. Increasing $N$ increases both densities, while increasing the average delay increases modal density but decreases echo density. The delay lengths should be mutually prime or incommensurate to spread the resonant frequencies and avoid regular periodicities.

For given desired densities,

$
N approx sqrt(D_m D_e)
$

The cascaded all-pass sections further increase diffusion by expanding each input echo into many echoes


== 6
Q: Consider sound propagation in a reverberant environment. What information can we perceptually gather from early reflections? What about late reverberations? When and how do we decide that the early reflection phase of the room impulse response turns into a late reverberation phase? (2023-09-05)


A:


== 7
Q: Consider the implementation of audio effects, e.g., chorus, flanger, etc., by means of delay lines.

- Describe the general concept of delay line applied to an audio signal.
- Describe the differences among: i) an integer delay line; ii) a fractional delay line; iii) a time-varying fractional delay line.
- Which kinds of delay lines need an interpolator? Why? (2023-07-19)


A:

a) A delay line shifts an audio signal in time. For a delay of $D$ samples,

$
  y(n) = x(n-D)
$

In delay-based effects, the delayed signal may be used alone or mixed with the direct signal.

b) An integer delay line uses an integer number of samples $D in NN$ and can be implemented directly with memory or $z^(-D)$.

A fractional delay line uses a non-integer delay

$
  D = floor(D) + d, quad 0 < d < 1
$

so the desired output lies between two available samples and must be estimated by interpolation.

A time-varying fractional delay line uses a delay $D(n)$ that changes with time. It is used in effects such as chorus, flanger, and vibrato, allowing the delay to vary smoothly.

c) Integer delay lines do not need an interpolator. Fractional and time-varying fractional delay lines do need one, because the desired output generally lies between discrete-time samples. The interpolator estimates the signal value at these intermediate positions and avoids discontinuities when the delay varies

== 8
Q: Consider the problem of synthesizing a reverberated audio signal.

- Define the concept of Room Impulse Response (RIR) and highlight its component.
- Consider a rectangular room with one microphone and one sound source. Considering only first-order reflections, i.e., after one reflection, the signal does not "bounce" on walls anymore, sketch a possible RIR. Hint: ignore the floor and the ceiling. Clearly report the labels on the axes.
- Explain how it is possible to use a RIR to apply reverberation in the digital domain to a dry sound recording. (2023-07-19)


A:

a) The Room Impulse Response (RIR) is the impulse response between a sound source and a receiver in a room. It describes how an acoustic impulse propagates through the environment.

A typical RIR consists of:
- direct sound
- early reflections
- late reverberation

The direct sound arrives first, early reflections are sparse echoes produced by nearby surfaces, and late reverberation is a dense tail produced by multiple reflections.

b) If floor and ceiling are ignored, a rectangular room has four walls. Considering only first-order reflections, the RIR contains the direct sound and four reflected impulses, one from each wall. A possible RIR is

#raw("Amplitude h(t)\n    ↑\n    │       │ direct\n    │       │\n    │       │       │ wall 1\n    │       │       │      │ wall 2\n    │       │       │      │       │ wall 3\n    │       │       │      │       │      │ wall 4\n────┼───────┼───────┼──────┼───────┼──────┼────────→ time t\n            t₀      t₁     t₂      t₃     t₄", block: true)

Equivalently,

$
h(t) = a_0 delta(t-t_0) + sum_(k=1)^4 a_k delta(t-t_k)
$

where $t_0$ is the direct-path arrival time and $t_1,...,t_4$ are the arrival times of the four first-order wall reflections. Their delays and amplitudes depend on propagation distance and wall reflection losses.

c) Room reverberation is approximately a linear time-invariant process, so a dry recording can be reverberated by convolving it with the RIR

$
y(n) = x(n) ast h_"RIR"(n)
$

or

$
y(n) = sum_k h_"RIR"(k) x(n-k)
$

Thus, each impulse in the RIR generates a delayed and scaled copy of the dry signal, reproducing the direct sound, reflections, and reverberation of the room

== 9
Q: Define the Energy Decay Curve. Define the reverberation time T60 and how it can be measured from the Energy Decay Curve. (2023-06-26)


A:

The Energy Decay Curve (EDC) is a smooth and monotonically decreasing function that measures the total energy remaining in the Room Impulse Response after time $t$. It is defined by

$
h_"EDC"(t) = integral_t^infinity h^2(tau) d tau
$

The reverberation time $T_60$ is the time required for the EDC to decrease by $60$ dB from its initial value.

To measure $T_60$, the EDC is plotted in dB versus time. Since it decays approximately linearly in the dB scale, $T_60$ is the time at which the EDC reaches $-60$ dB relative to its initial level.

In practice, the noise floor may prevent observing the full $60$ dB decay. In this case, a shorter decay range can be measured and extrapolated, for example using a $40$ dB decay multiplied by $1.5$, or a $20$ dB decay multiplied by $3$

== 10
Q: Describe, with the help of a schematic representation, the main structure of a Leslie rotating speaker, providing details on the physical phenomena that characterize each element. Propose a block diagram to implement this structure with DSP technique. Carefully discuss the role of each block. (2023-06-26)


A:


== 11
Q: Describe the Feedback Delay Network scheme for reverberation modeling, with particular reference to:

- In what way does it generalize COMB filters?
- What conditions do diffusion matrices need to satisfy? (2023-06-26)


A:

a) A Feedback Delay Network (FDN) generalizes a feedback COMB filter from a scalar structure to a vector structure. Instead of one delay line and one feedback gain, an FDN uses several delay lines with different lengths and couples their outputs through a feedback matrix $A$.

#figure(
  image("media/FDN.png", width: 80%),
)

Thus, the single feedback coefficient of a COMB filter is replaced by a matrix that mixes the signals among several delay lines. This produces a much denser and more complex set of echoes and resonant modes.

b) The diffusion or feedback matrix should preferably define a lossless network before decay is introduced. For a real-valued implementation, a common sufficient condition is that $A$ is orthogonal/unitary

$
A A^T = I
$

so that it preserves signal energy. In a lossless FDN, the system poles lie on the unit circle, so the eigenmodes neither grow nor decay.

To obtain a desired reverberation decay, the lossless matrix is then combined with attenuation smaller than one, possibly frequency dependent. This allows the decay rate and reverberation time to be controlled without destroying the diffusion properties of the network

== 12
Q: How does a feedback delay network (FDN) work for modeling and implementing reverberation? In what way does it generalize COMB filters? (2022-09-07)


A:

== 13
Q: Describe in broad terms the design principles behind maximally flat fractional delay filter. (2022-06-24)


A:

A maximally flat fractional-delay FIR filter is designed so that its frequency response matches the ideal delay

$
H_"id" (omega) = e^(-i omega D)
$

as closely as possible around $omega_0 = 0$.

The design imposes that the error and its first $N$ derivatives vanish at $omega_0$

$
(d^l E(omega))/(d omega^l) |_(omega=0) = 0, quad l = 0, ..., N
$

This leads to the conditions

$
sum_(n=0)^N n^l h(n) = D^l, quad l = 0, ..., N
$

which form a set of $N+1$ linear equations. They can be written as a Vandermonde system

$
V h = v
$

and solved as

$
h = V^(-1) v
$

The resulting coefficients are equivalent to the Lagrange interpolation coefficients

$
h(n) = product_(k=0, k != n)^N (D-k)/(n-k)
$

Thus, the filter is called maximally flat because the approximation error has as many zero derivatives as possible around zero frequency

== 14
Q: Assume you are in a large room, and you want to measure its reverberation time. You have access to an audio recording device with which you initially measure the level of background noise, noise floor. Then you record the room impulse response (RIR) corresponding to the impulsive sound produced by popping a balloon. Using the signal you acquire, how do you proceed with computing the reverberation time? Please begin by defining the reverberation time, then describe the steps that you take in order to measure the reverberation time. Assume that the level of impulsive noise produced by the popping of the balloon is 35 dB above the noise floor. How do you proceed in this case? (2022-06-24)


A:

The reverberation time $T_60$ is the time required for the room sound energy to decay by $60$ dB from its initial level.

After measuring the noise floor, an impulsive sound such as a balloon pop is generated and the Room Impulse Response $h(t)$ is recorded. From the measured RIR, the Energy Decay Curve is computed as

$
h_"EDC"(t) = integral_t^infinity h^2(tau) d tau
$

The EDC is then expressed in dB. Since it decays approximately linearly in the dB scale, the decay slope can be measured and used to estimate the reverberation time.

If the impulse is only $35$ dB above the noise floor, the full $60$ dB decay cannot be measured because the EDC reaches the noise floor first. In this case, we measure a reliable $15$ dB decay time $T_15$ and extrapolate the decay to $60$ dB

$
T_60 approx 4 T_15
$

Therefore, the procedure is: measure the noise floor, record the RIR, compute the EDC, determine $T_15$ from its decay before reaching the noise floor, and estimate $T_60$ by extrapolation

== 15
Q: What information can we perceptually gather from early reflections? What about late reverberations? When and how do we decide that the early reflection phase of the room impulse response turns into a late reverberation phase? (2022-02-11)


A:

== 16
Q: Define the reverberation time. Define the T60 and describe how to measure it. Explain how to estimate it when the noise floor is too high to measure it. (2022-01-17)


A:

== 17
Q: Describe in broad terms the comb filter and the allpass filter as elementary building blocks for building and shaping a late reverberation filter. What role do they play in the design? How do you interconnect such building blocks? (2021-08-31)


A:

A feedback comb filter is an elementary IIR reverberation block. It produces a train of exponentially decaying echoes and a set of resonant modes. Its feedback gain controls the decay rate and therefore the reverberation time, while its delay length determines the spacing of echoes and resonances. However, comb filters can introduce strong spectral coloration.

An all-pass filter also produces a decaying sequence of echoes, but it has a flat magnitude response. Its main role is therefore to increase echo density and diffusion without strongly changing the overall spectral magnitude. All-pass sections are often called diffusers.

A single comb filter or all-pass filter does not provide enough echo density for a realistic late reverberation, so several blocks are combined.

Comb filters must be connected in parallel, preferably with different incommensurate delay lengths, so that their resonant modes are spread over frequency.

All-pass filters must be connected in cascade. Each stage expands the echoes generated by the previous stage and further increases diffusion.

A typical Schroeder late reverberator therefore has the structure

#raw("x(n) → parallel comb-filter bank → cascaded all-pass diffusers → y(n)", block: true)


== 18
Q: Describe in broad terms the maximally flat fractional delay filter. What are the conditions that you need to set in order to derive this filter? (2021-08-31)


A:

== 19
Q: Describe a block diagram for implementing the effect of the "Leslie" (speaker that rotates around an axis that does not pass through its membrane), using simple elements such as modulated delay lines. Start from the physical phenomena that you need to simulate and find the blocks that implement them. Finally, show how to put such blocks together. (2021-02-01)


A:

== 20
Q: What information can we perceptually gather from early reflections? What about late reverberations? When and how do we decide that the early reflection phase of the room impulse response turns into a late reverberation phase? (unknown)


A:

= KS & D'Alembert

== 1
Q: Digital string model:

a) Describe the model of a digital string based on the Karplus-Strong algorithm (use a scheme and comment on it).

b) Why do we need a fractional delay for fine-tuning such a model? Please explain that by showing what happens to the pitch of the tone generated by the KS algorithm, when adding one delay element to the delay time. (2025-07-18)


A:

a) Karplus--Strong digital string model

The Karplus--Strong algorithm is based on a feedback comb filter:

$
H(z) = 1 / (1 - g z^(-M))
$

with recursion

$
y[n] = x[n] + g y[n-M].
$

The delay length $M$ determines the fundamental frequency approximately as

$
f_0 = F_s / M.
$

For a more realistic plucked-string sound, a low-pass filter is inserted in the feedback loop so that high-frequency partials decay faster than low-frequency ones. A simple choice is

$
H_"LP" (z) = 1/2 (1 + z^(-1)).
$

The delay line is usually initialized with random values, producing a noisy transient followed by a decaying harmonic tone.

A simple scheme is:

#figure(
  image("media/KS-plucked-string-scheme.png", width: 80%),
)

b) Need for fractional delay

With an integer delay, the possible pitches are quantized because

$
f_0 = F_s / M.
$

If one delay element is added, the new pitch becomes

$
f_0^' = F_s / (M + 1).
$

Therefore, the pitch variation is

$
Delta f






= F_s / M - F_s / (M + 1)
= F_s / (M(M + 1)).
$

For example, with

$
F_s = 44 " kHz", quad M = 100,
$

we have

$
f_0 = 440 " Hz",
$

while

$
f_0' = 44000 / 101 approx 435.6 " Hz".
$

Hence,

$
Delta f approx 4.4 " Hz",
$

which is too large for fine tuning.

Therefore, a fractional-delay filter is required to obtain an effective non-integer delay $M + d$ and achieve finer pitch control.

== 2
Q: Consider the d'Alembert Equation, which governs the behavior of an ideal string or an acoustic tube. Derive a Finite Difference (FD) computational scheme for this equation. Specify the general condition that the sampling steps in space and time must satisfy. (2025-07-18)


A:

The d'Alembert equation for an ideal string or acoustic tube is

$
(partial^2 y)/(partial t^2)
=
c^2 (partial^2 y)/(partial x^2).
$

Let $T_s$ be the temporal sampling step and $X_s$ the spatial sampling step. Using centered finite differences,

$
(partial^2 y)/(partial t^2)
approx
(y[n+1,k] - 2y[n,k] + y[n-1,k]) / T_s^2
$

and

$
(partial^2 y)/(partial x^2)
approx
(y[n,k+1] - 2y[n,k] + y[n,k-1]) / X_s^2
$

Substituting them into the wave equation gives


#scale(80%)[
$
(y[n+1,k] - 2y[n,k] + y[n-1,k]) / T_s^2
=
c^2
(y[n,k+1] - 2y[n,k] + y[n,k-1]) / X_s^2
$
]


Therefore, the explicit FD recursion is

#scale(80%)[
$
y[n+1,k]
=
2y[n,k] - y[n-1,k]
+
lambda^2
(y[n,k+1] - 2y[n,k] + y[n,k-1])
$
]

where

$
lambda = (c T_s) / X_s.
$

The Friedrichs--Lewy stability condition requires

$
lambda <= 1,
$

i.e.

$
c T_s <= X_s.
$

A particularly useful choice is

$
X_s = c T_s,
$

for which $lambda = 1$ and the recursion simplifies to

$
y[n+1,k]
=
y[n,k+1] + y[n,k-1] - y[n-1,k].
$

== 3
Q: Karplus-Strong algorithm for tuning a string. (2025-01-08)

A:

The Karplus--Strong algorithm models a plucked string with a feedback comb filter. The delay line determines the oscillation period, while the feedback gain controls the decay

$
H(z) = 1 / (1 - g z^(-m))
$

For an integer delay of $m$ samples, the fundamental frequency is approximately

$
f_0 = F_s / m
$

To obtain a more realistic string decay, a low-pass filter can be inserted in the feedback loop so that high-frequency partials decay faster than low-frequency partials. With the simple averaging filter

$
H_(L P)(z) = 1/2 (1 + z^(-1))
$

an additional half-sample delay is introduced, giving

$
f_0 = F_s / (m + 1/2)
$

The delay length is quantized in integer samples, so changing it by one sample may change the pitch by more than the perceptual J N D. Fine tuning is therefore obtained by introducing a fractional delay in the feedback loop

$
M = m + delta
$

where $m$ is the integer part and $delta$ is the fractional part. The fractional-delay filter approximates a non-integer phase delay while keeping the magnitude response approximately flat, allowing finer pitch control

== 4
Q: Explain modal synthesis and illustrate it with a block diagram. (2024-07)

A:

Modal synthesis represents the vibration of a resonating object as a linear combination of independent normal modes. Each mode is modeled by a second-order resonator excited by a driving force or acoustic pressure. Therefore, the complete object can be implemented as a parallel bank of second-order resonators

$
y(n) = sum_(i=1)^N g_i q_i(n)
$

Each resonator represents one mode and is characterized by its resonance frequency, bandwidth, and gain. The input force is mapped onto the different modes according to their modal shapes, and the modal outputs are weighted and summed to obtain the vibration observed at the chosen output position

#figure(
  image("media/Model-synthesis.png", width: 80%),
)


== 5
Q: Demonstrate the trapezoidal rule for discretization, showing how it is used to map from the s-domain to the z-domain. (2024-07)

A:

The trapezoidal rule approximates the change of a continuous-time signal over one sampling interval by averaging its derivative at the two endpoints

$
x[n] - x[n - 1]
approx
T_s / 2
(
dot(x)[n] + dot(x)[n - 1]
)
$

Equivalently

$
1 / 2
(
dot(x)[n] + dot(x)[n - 1]
)
approx
(
x[n] - x[n - 1]
) / T_s
$

Taking the Z-transform gives

$
1 / 2
(
1 + z^(-1)
)
dot(X)(z)
=
1 / T_s
(
1 - z^(-1)
)
X(z)
$

Therefore, since differentiation in the s-domain corresponds to multiplication by $s$

$
s
mapsto
2 / T_s
(1 - z^(-1)) / (1 + z^(-1))
$

or, using the sampling frequency

$
F_s = 1 / T_s
$

$
s
mapsto
2 F_s
(1 - z^(-1)) / (1 + z^(-1))
$

Solving for $z$ gives the equivalent mapping

$
z
=
(1 + s T_s / 2) / (1 - s T_s / 2)
$

This is the bilinear transform obtained from the trapezoidal rule. It maps a continuous-time transfer function into a discrete-time transfer function by replacing every occurrence of $s$ with the corresponding rational function of $z$

== 6
Q: Explain the Karplus-Strong algorithm pointing out its purpose and characteristics. What kind of filter does it use? Help yourself by drawing a block diagram. How is it possible to employ it for physical modeling? Provide an example of application. (2023-09-05)


A:

The Karplus--Strong algorithm is a simple physical-modeling technique mainly used to synthesize plucked-string sounds

It is based on an IIR feedback comb filter

$
H(z) = 1 / (1 - g z^(-M))
$

with recursion

$
y[n] = x[n] + g y[n-M]
$

The delay length $M$ determines the fundamental frequency approximately as

$
f_0 = F_s / M
$

The basic comb filter produces a harmonic spectrum whose partials have approximately the same decay rate

To obtain a more realistic plucked-string behavior, a low-pass filter is inserted in the feedback loop so that high-frequency partials decay faster than low-frequency ones

A simple low-pass filter is

$
H_"LP"(z) = 1/2 (1 + z^(-1))
$

A possible block diagram is

#figure(
  image("media/KS-plucked-string-scheme.png", width: 80%),
)

The delay line can be initialized with random values, producing a noisy initial transient followed by a decaying harmonic sound

For physical modeling, the delay line represents wave propagation along a string, while the feedback loop represents repeated reflections and energy loss

A typical application is the synthesis of a plucked guitar string

== 7
Q: Consider the D'Alembert Equation, Partial Differential Equation, describing an ideal string. Write the general solution of this PDE and explain why it satisfies that PDE. How do you look for stationary waves and derive the so-called Fourier solution of this PDE? (2022-09-07)


A:

The d'Alembert equation for an ideal string is

$
(partial^2 y)/(partial t^2)
=
c^2 (partial^2 y)/(partial x^2)
$

Its general solution is the sum of two arbitrary traveling waves propagating in opposite directions

$
y(x,t)
=
y_r (c t - x)
+
y_l (c t + x)
$

The first term represents a right-going wave and the second term a left-going wave

This form satisfies the PDE because, for each traveling-wave component, the second derivative with respect to time is equal to $c^2$ times the second derivative with respect to space

For example, for

$
y_r = y_r (c t - x)
$

we obtain

$
(partial^2 y_r)/(partial t^2)
=
c^2 y_r^''
$

and

$
(partial^2 y_r)/(partial x^2)
=
y_r^''
$

therefore

$
(partial^2 y_r)/(partial t^2)
=
c^2 (partial^2 y_r)/(partial x^2)
$

The same holds for the left-going wave, and by linearity their sum is also a solution

To look for stationary waves, use separation of variables

$
y(x,t)
=
X(x) T(t)
$

Substituting this form into the wave equation gives

$
X(x) T^'' (t)
=
c^2 X^'' (x) T(t)
$

and therefore

$
(X^'' (x)) / X(x)
=
(T^'' (t)) / (c^2 T(t))
=
-k^2
$

This gives two independent ordinary differential equations

$
X''(x) + k^2 X(x) = 0
$

$
T''(t) + c^2 k^2 T(t) = 0
$

For a string fixed at both ends

$
X(0) = 0
$

$
X(L) = 0
$

The spatial solution is therefore

$
X_n (x)
=
sin(n pi x / L)
$

with

$
k_n
=
n pi / L
$

The corresponding angular frequencies are

$
omega_n
=
c k_n
=
n pi c / L
$

and

$
f_n
=
n c / (2 L)
$

The complete Fourier solution is obtained by summing all normal modes

$
y(x,t)
=
sum_(n=1)^infinity
sin(n pi x / L)
(
A_n cos(omega_n t)
+
B_n sin(omega_n t)
)
$

The coefficients $A_n$ and $B_n$ are determined by the initial displacement and initial velocity of the string

== 8
Q: Consider the d'Alembert Equation, which governs the behavior of an ideal string or an acoustic tube. Derive a Finite Difference (FD) computational scheme for this equation. Specify the general condition that the sampling steps in space and time must satisfy. (2022-07-15)

A:

== 9
Q: Describe the model of a digital string based on the Karplus-Strong algorithm (use a scheme and comment on it). Why do we need a fractional delay for fine-tuning such a model? Please explain that by showing what happens to the pitch of the tone generated by the KS algorithm, when adding one delay element to the delay line. (2022-07-15)

A:

== 10
Q: Describe the Karplus-Strong algorithms and the related issues concerning tuning. How do you overcome such issues? (2022-02-11)


A:

The Karplus--Strong algorithm is a feedback-delay model used mainly for plucked-string synthesis

Its basic structure is a feedback comb filter with delay $M$

$
H(z) = 1 / (1 - g z^(-M))
$

The fundamental frequency is approximately determined by the total loop delay

$
f_0 = F_s / M
$

To obtain a more realistic decay, a low-pass filter is inserted in the feedback loop so that high-frequency partials decay faster than low-frequency ones

A simple choice is

$
H_"LP"(z) = 1/2 (1 + z^(-1))
$

The tuning problem comes from the fact that the delay length $M$ is integer-valued, so only discrete pitch values can be obtained

If one delay element is added

$
f_0' = F_s / (M + 1)
$

and the pitch variation is

$
Delta f = F_s / M - F_s / (M + 1)
$

$
Delta f = F_s / (M(M + 1))
$

For example, with

$
F_s = 44 " kHz"
$

and

$
M = 100
$

the frequency changes from

$
440 " Hz"
$

to approximately

$
435.6 " Hz"
$

so the pitch step is about

$
4.36 " Hz"
$

which is too large for fine tuning

The problem is overcome by using a fractional-delay filter, which provides an effective non-integer delay

$
D = M + d
$

with

$
0 <= d < 1
$

This allows much finer control of the total loop delay and therefore of the generated pitch

== 11
Q: Describe the principles behind the cellular modeling method "Cordis-Anima". What are the advantages? Where is it mostly used? What are the issues associated to this approach? (2022-02-11)


A:

Cordis--Anima is a cellular physical-modeling method in which a complex vibrating object is decomposed into a network of interacting particles

The basic elements are masses, springs, and dampers

Masses represent inertia and form the nodes of the network, while springs and dampers represent the physical interactions between the nodes

Unlike standard FD methods, the physical system is first atomized into lumped elements and then each element is locally discretized

The method is modular and allows complex mechanical structures to be built by connecting simple physical blocks

Its main advantages are the intuitive physical interpretation of the elements, the modular structure, and the possibility of constructing complex or even non-standard virtual vibrating objects from simple components

It is mainly used for physical modeling of mechanical vibrating structures and for sound synthesis based on mass--spring--damper networks

A major issue is the instantaneous interdependency between forces and displacements

For example, the current displacement of a mass depends on the current force, while the current spring force simultaneously depends on the current displacement

This produces a delay-free or non-computable loop

Cordis--Anima solves this problem by forcing causality and inserting an artificial one-sample delay between the interacting Kirchhoff variables

Thus, displacements at time $n$ are computed from forces at time $n-1$, and the two-way interactions are evaluated in an interleaved way

The inserted delay makes the system computable, but it is an artificial numerical delay and does not correspond to a physical propagation delay

== 12
Q: Consider the D'Alembert Equation, Partial Differential Equation, describing an ideal string. Write the general solution of this PDE and explain why it satisfies that PDE. Derive the so-called Fourier solution of this PDE by using the condition of stationary waves. (2021-08-31)


A:

The d'Alembert equation for an ideal string is

$
(partial^2 y)/(partial t^2)
=
c^2 (partial^2 y)/(partial x^2)
$

Its general solution is the sum of two traveling waves propagating in opposite directions

$
y(x,t)
=
y_r (c t - x)
+
y_l (c t + x)
$

The first term is a right-going wave and the second term is a left-going wave

For each traveling-wave component, the second derivative with respect to time is equal to $c^2$ times the second derivative with respect to space

For example

$
(partial^2 y_r)/(partial t^2)
=
c^2 y_r^''
$

$
(partial^2 y_r)/(partial x^2)
=
y_r^''
$

Therefore

$
(partial^2 y_r)/(partial t^2)
=
c^2 (partial^2 y_r)/(partial x^2)
$

The same holds for the left-going component, and by linearity their sum also satisfies the PDE

To derive the Fourier solution, stationary waves are searched by separation of variables

$
y(x,t)
=
X(x) T(t)
$

Substituting into the wave equation gives

$
X(x) T''(t)
=
c^2 X''(x) T(t)
$

Hence

$
(X^'' (x)) / X(x)
=
(T^'' (t)) / (c^2 T(t))
=
-k^2
$

This gives

$
X^'' (x) + k^2 X(x) = 0
$

$
T^'' (t) + c^2 k^2 T(t) = 0
$

For a string fixed at both ends

$
X(0) = 0
$

$
X(L) = 0
$

The spatial solution becomes

$
X_n(x)
=
sin(n pi x / L)
$

with

$
k_n
=
n pi / L
$

The corresponding angular frequencies are

$
omega_n
=
c k_n
=
n pi c / L
$

Therefore

$
f_n
=
n c / (2 L)
$

The complete Fourier solution is the sum of all normal modes

$
y(x,t)
=
sum_(n=1)^infinity
sin(n pi x / L)
(
A_n cos(omega_n t)
+
B_n sin(omega_n t)
)
$

The coefficients $A_n$ and $B_n$ are determined by the initial displacement and initial velocity

== 13
Q: Digital string model:

a) Describe the model of a digital string based on the Karplus-Strong algorithm, use a scheme and comment on it.

b) Why do we need a fractional delay for fine-tuning such a model? Please explain that by showing what happens to the pitch of the tone generated by the KS algorithm, when adding one delay element to the delay line. (2021-07-13)


A:

a) The Karplus--Strong digital string model is based on a feedback comb filter

$
H(z) = 1 / (1 - g z^(-M))
$

with recursion

$
y[n] = x[n] + g y[n-M]
$

The delay length $M$ determines the fundamental frequency approximately as

$
f_0 = F_s / M
$

For a more realistic plucked-string sound, a low-pass filter is inserted in the feedback loop so that high-frequency partials decay faster than low-frequency ones

A simple choice is

$
H_"LP"(z) = 1/2 (1 + z^(-1))
$

A suitable block diagram is

$
x[n] -> "summer" -> H_"LP"(z) -> y[n]
$

$
y[n] -> z^(-M) -> g -> "feedback to summer"
$

The delay line is usually initialized with random values, producing a noisy attack followed by a decaying harmonic tone

b) The tuning problem is caused by the integer-valued delay length

$
f_0 = F_s / M
$

If one delay element is added, the new pitch becomes

$
f_0' = F_s / (M + 1)
$

The pitch variation is therefore

$
Delta f
=
F_s / M - F_s / (M + 1)
$

$
Delta f
=
F_s / (M(M + 1))
$

For example, with

$
F_s = 44 " kHz"
$

and

$
M = 100
$

the pitch changes from

$
440 " Hz"
$

to approximately

$
435.6 " Hz"
$

so

$
Delta f approx 4.36 " Hz"
$

This step is too large for fine tuning

The problem is overcome by using a fractional-delay filter, which allows an effective non-integer delay

$
D = M + d
$

with

$
0 <= d < 1
$

This gives a much finer control of the loop delay and therefore of the generated pitch

== 14
Q: Describe the Karplus-Strong algorithm and the related issues concerning tuning. How do you overcome such issues? (2020-06-17)

A:

= DWG & WDF

== 1
Q: A nonlinear resistor can be handled directly in the wave domain, but a nonlinear capacitor cannot.

- State why the direct approach fails for the capacitor.
- Explain the role of the mutator (across/through integration) in restoring an explicit scattering relation. (2026-07-23)


A:

A nonlinear resistor can be handled directly because its constitutive relation is memoryless

$
F(v,i) = 0
$

After the Kirchhoff-to-wave transformation, this can be converted directly into an algebraic scattering relation

$
v^- = g(v^+)
$

A nonlinear capacitor is different because its constitutive relation is between voltage and charge

$
F(v,q) = 0
$

with

$
i = dot(q)
$

Therefore it contains memory. A direct Wave Digital transformation would involve both a nonlinear operator and an integration or differentiation operator, and these operators cannot in general be interchanged. Hence the capacitor cannot be reduced directly to a memoryless scattering relation in the usual wave variables

To overcome this, special wave variables are introduced using voltage $v$ and charge $q$

$
u^+ = 1/2 (v + q/C_0)
$

$
u^- = 1/2 (v - q/C_0)
$

where $C_0$ is a reference capacitance

In the $u^+,u^-$ domain, the nonlinear capacitor becomes an algebraic relation between $v$ and $q$, so it can be treated like a memoryless nonlinear resistor and written as a nonlinear reflection law

$
u^- = g(u^+)
$

A mutator, also called an across integrator, maps the ordinary WD waves $(v^+,v^-)$ to the special waves $(u^+,u^-)$. It therefore separates the dynamic integration from the nonlinear algebraic characteristic and restores an explicit nonlinear scattering relation

For computability, the mutator parameters are chosen so that its instantaneous reflection vanishes

$
R C_0 = T_s/2
$

The dual construction for a nonlinear inductor is the through integrator

== 2
Q: Consider the Wave Digital connection tree structure of an envelope follower circuit containing a single nonlinear diode D. Identify which ports require adaptation symbols directly on the diagram. Additionally, describe the computational flow executed at each sampling step to simulate the nonlinear circuit in the WD domain. (2025-07-18)

#figure(
  image("media/enevlop-follower-circuit.png", width: 80%),
)


A:

The adaptation symbols are required at ports 3, 4, 5, 6, 7, 8, and 9. Ports 1 and 2 are not adapted. Port 3 is the adaptor port connected to the nonlinear diode, ports 4 and 7 are the adapted ports between connected adaptors, and ports 5, 6, 8, and 9 correspond to the adapted linear one-port elements. The nonlinear diode itself cannot be adapted.

At each sampling step:

- Forward scan from the leaves to the root: compute the reflected waves of the linear elements and propagate them through the adaptors toward the diode
- Nonlinear scattering at the root: from the wave incident on the diode, compute the wave reflected by the nonlinear diode
- Backward scan from the root to the leaves: propagate the reflected wave through the adaptors and compute the waves incident on the linear elements

== 3
Q: Let us consider two portions of strings of different section which are attached together and modeled using digital waveguides. Derive and describe the junction that models the interconnection of such strings in the wave digital domain. By so doing, deducing the travelling waves and writing the continuity conditions of the connection, from there derive the mathematical description of the scattering junction. (2025-06-23)

A:

For each uniform string section, the D'Alembert solution is the sum of two travelling waves

$
y_i(x,t) = y_i^r (c_i t-x) + y_i^l (c_i t+x)
$

Using velocity waves, the corresponding force waves satisfy

$
f_i^+ = Z_i v_i^+
$

$
f_i^- = -Z_i v_i^-
$

where the characteristic impedance of the string is

$
Z_i = T/c_i = sqrt(T mu_i)
$

Therefore, two string portions with different linear densities have different characteristic impedances, and the discontinuity produces scattering

At the junction, let the incoming and outgoing velocity waves be

$
a_1 = v_1^+
$

$
b_1 = v_1^-
$

$
a_2 = v_2^-
$

$
b_2 = v_2^+
$

The total velocity must be continuous across the junction

$
v_J = a_1 + b_1 = a_2 + b_2
$

The forces must also balance at the massless junction

$
Z_1(a_1-b_1) + Z_2(a_2-b_2) = 0
$

Using the velocity-continuity condition

$
b_1 = v_J-a_1
$

$
b_2 = v_J-a_2
$

the force condition gives the junction velocity

$
v_J = 2 (Z_1 a_1 + Z_2 a_2)/(Z_1+Z_2)
$

Hence the outgoing waves are

$
b_1 = (Z_1-Z_2)/(Z_1+Z_2) a_1 + (2 Z_2)/(Z_1+Z_2) a_2
$

$
b_2 = (2 Z_1)/(Z_1+Z_2) a_1 + (Z_2-Z_1)/(Z_1+Z_2) a_2
$

Defining the reflection coefficient

$
rho = (Z_1-Z_2)/(Z_1+Z_2)
$

the Kelly-Lochbaum scattering junction can be written as

$
b_1 = rho a_1 + (1-rho) a_2
$

$
b_2 = (1+rho) a_1 - rho a_2
$

Thus, a change of string impedance causes each incident travelling wave to be partly reflected and partly transmitted. If the two impedances are equal, there is no reflection

$
Z_1=Z_2 => rho=0
$

== 4
Q: A problem on free parameter in WDF. Role of Z in adaptation. (2025-01-08)


A:


In a Wave Digital Filter, the Kirchhoff variables are mapped into wave variables using a reference impedance

$
v^+ = 1/2 (v + Z i)
$

$
v^- = 1/2 (v - Z i)
$

Unlike the characteristic impedance in a digital waveguide, the parameter

$
Z
$

in a lumped WDF is a free reference parameter. It represents a change of reference frame for the wave variables and can be chosen to improve computability

For a one-port element with impedance

$
Z_e
$

the reflection coefficient is

$
rho = (Z_e-Z)/(Z_e+Z)
$

If the reference impedance is chosen as

$
Z=Z_e
$

then

$
rho=0
$

and the port is adapted, meaning that it produces no instantaneous reflection

The same principle is used in multiport adaptors. One reference impedance is chosen so that one port becomes reflection-free. For example, for a series adaptor

$
Z_3=Z_1+Z_2
$

while for a parallel adaptor

$
1/Z_3=1/Z_1+1/Z_2
$

Adaptation is therefore used to eliminate instantaneous dependencies and delay-free algebraic loops, making the WDF signal flow computable


== 5
Q: Let us consider two portions of string of different section, which are attached together and modeled using Digital Waveguides. Derive and describe the junction that models the interconnection of such strings in the waveguide domain. Do so by defining the traveling waves and writing the continuity conditions at the connection. From there derive the mathematical description of the scattering junction. (2024-02-09)


A:

For each string section, define traveling force waves from the traveling velocity waves. With string tension $T$, linear density $mu_i$, propagation speed $c_i$, characteristic impedance $Z_i$ and admittance $Y_i$

$
c_i = sqrt(T / mu_i)
$

$
Z_i = T / c_i = sqrt(T mu_i)
$

$
Y_i = 1 / Z_i
$

The force and velocity at port $i$ are written in terms of incident and reflected force waves as

$
f_i = f_i^+ + f_i^-
$

$
v_i = Y_i (f_i^+ - f_i^-)
$

At the massless connection point, force and velocity continuity give

$
f_1 = f_2 = f_J
$

$
v_1 + v_2 = 0
$

Since

$
f_i^- = f_J - f_i^+
$

substitution into the velocity continuity condition gives

$
f_J = 2 (Y_1 f_1^+ + Y_2 f_2^+) / (Y_1 + Y_2)
$

Therefore the outgoing waves are

$
f_1^- = rho f_1^+ + (1 - rho) f_2^+
$

$
f_2^- = (1 + rho) f_1^+ - rho f_2^+
$

where

$
rho = (Y_1 - Y_2) / (Y_1 + Y_2) = (Z_2 - Z_1) / (Z_1 + Z_2)
$

Hence the junction is the two-port Kelly-Lochbaum scattering junction

$
mat(f_1^-, f_2^-) = mat(rho, 1-rho; 1+rho, -rho) mat(f_1^+, f_2^+)
$

The impedance discontinuity therefore produces partial reflection and partial transmission. If $Z_1 = Z_2$, then $rho = 0$ and there is no reflection.

== 6
Q: Explain the differences between multiport junctions in Digital Waveguides and adaptors in Wave Digital Filters. (2024-02-09)


A:

In Digital Waveguides, multiport junctions model the interconnection of distributed propagation media. They enforce the physical continuity conditions and perform scattering between traveling waves. Their wave mapping depends on the physical characteristic impedances of the connected media. Junctions are normally separated by delay lines, so the resulting signal flow is naturally computable.

In Wave Digital Filters, the model is lumped and there is no spatial propagation, so two junctions may be connected without any delay between them. This can create instantaneous algebraic loops and make the signal flow non-computable.

A WDF adaptor is therefore a special junction in which one port is made reflection-free by choosing its reference resistance appropriately

$
s_(n n) = 0
$

The reference resistances in WDFs are free parameters rather than physical characteristic impedances. They are chosen to adapt ports, eliminate instantaneous reflections, and make the network computable.

Thus, DWG multiport junctions mainly model physical scattering between propagation paths, while WDF adaptors additionally use port adaptation to guarantee computability in lumped networks.

== 7
Q: Describe Digital Waveguides (DWGs) and their application to physical modeling. How do they differ from Wave Digital Filters? Is it possible to combine both approaches? If yes, how? (2023-09-05)


A:

Digital Waveguides are used for distributed-parameter physical systems described by PDEs, such as strings and acoustic tubes. Instead of discretizing the PDE directly, a DWG discretizes its general traveling-wave solution. For the 1-D wave equation

$
y(x,t) = y^+(c t-x) + y^-(c t+x)
$

the two traveling waves are implemented by delay lines. Impedance discontinuities are modeled by scattering junctions, and multiport junctions enforce continuity conditions between connected propagation paths.

Wave Digital Filters are the lumped-parameter counterpart of DWGs. They are used for systems described by ODEs or equivalent circuits. WDFs also use wave variables and scattering, but the port resistance $R$ is a free parameter rather than a physical characteristic impedance. Since lumped systems do not contain propagation delays between junctions, instantaneous algebraic loops may appear. Therefore WDFs use adapted ports and adaptors to remove instantaneous reflections and guarantee computability.

The two approaches can be combined in a hybrid WDF-DWG model. Distributed parts, such as the two portions of a string, are modeled by DWGs, while lumped or nonlinear interaction elements are modeled in the WDF domain. They are connected through compatible wave-variable ports and scattering structures. A typical example is bow-string interaction, where the string is represented by DWGs and the local nonlinear bow interaction is represented by a WDF element.

== 8
Q: Consider Wave Digital Filters (WDF).

- Briefly explain how to model a circuit using WDF, when the circuit has a resistive nonlinearity.
- How do you derive the nonlinearity in the wave digital domain starting from its Kirchhoff description?
- How does such a wave description of the nonlinearity depend on the rest of the circuit? (2023-07-19)


A:

a) A circuit with a resistive nonlinearity is first decomposed into linear elements, series and parallel interconnections, and the nonlinear resistive element

The linear part is converted into the wave digital domain by replacing the circuit elements with their wave-domain equivalents and the topological interconnections with series or parallel adaptors

The available reference impedances are chosen to adapt the ports and remove delay-free loops. After all computability constraints are satisfied, one adapted port is left for connecting the resistive nonlinearity

b) Suppose the nonlinear resistor is described in the Kirchhoff domain by

$
F(v,i)=0
$

Using the wave definitions

$
v^+ = 1/2 (v+R i)
$

$
v^- = 1/2 (v-R i)
$

we obtain

$
v=v^+ + v^-
$

$
i=(v^+-v^-)/R
$

Substituting these expressions into the nonlinear characteristic gives

$
F(v^+ + v^-,(v^+-v^-)/R)=0
$

or equivalently

$
f(v^+,v^-)=0
$

If this relation can be made explicit with respect to the reflected wave, the nonlinear element is represented in the wave domain as

$
v^- = g(v^+)
$

This is a memoryless nonlinear scattering relation

c) The wave-domain description of the nonlinearity depends on the reference impedance

$
R
$

because the Kirchhoff-to-wave transformation itself depends on this parameter

Therefore, even if the physical nonlinear characteristic

$
F(v,i)=0
$

is fixed, the corresponding wave-domain function

$
v^-=g(v^+)
$

changes when the reference impedance changes

The value of the reference impedance at the nonlinear port is determined by the WDF adaptation of the surrounding linear circuit, so the wave-domain form of the nonlinearity depends on the rest of the circuit through that adapted port impedance

== 9
Q: Derive the description of a capacitor in the Wave Digital domain. Also derive the conditions for adapting the capacitor through an appropriate choice of the parameter defining the digital waves as a function of the Kirchhoff port variables. (2022-09-07)


A:

For a capacitor

$
i(t) = C dif(v(t), t)
$

or, in the Laplace domain

$
V(s) = Z(s) I(s)
$

with

$
Z(s) = 1/(s C)
$

Define the wave variables from the Kirchhoff port variables as

$
v^+ = 1/2 (v + R i)
$

$
v^- = 1/2 (v - R i)
$

Hence

$
v = v^+ + v^-
$

$
i = (v^+ - v^-)/R
$

Using

$
V(s) = Z(s) I(s)
$

the wave-domain relation becomes

$
V^-(s) = K(s) V^+(s)
$

with

$
K(s) = (Z(s)-R)/(Z(s)+R)
$

For the capacitor

$
K(s) = (1/(s C)-R)/(1/(s C)+R)
$

Using the bilinear transform

$
s = 2/T_s (1-z^(-1))/(1+z^(-1))
$

we obtain

$
K_d (z) = (p + z^(-1))/(1 + p z^(-1))
$

where

$
p = (T_s - 2 R C)/(T_s + 2 R C)
$

In general, this filter has an instantaneous input-output dependency because of the coefficient $p$. To adapt the capacitor, this instantaneous reflection must be removed, so we impose

$
p = 0
$

Therefore

$
2 R C = T_s
$

and the required reference resistance is

$
R = T_s/(2 C)
$

With this choice

$
K_d(z) = z^(-1)
$

Thus, an adapted Wave Digital capacitor is represented by a one-sample delay

$
v^-[n] = v^+[n-1]
$

== 10
Q: Consider the following mechanical model made of a spring of stiffness coefficient K, a mass M, along with a friction with damping coefficient C. The position of the mass is described by the variable x. Derive the electrical equivalent circuit of this system and the corresponding Wave Digital Filter structure. Please make sure you specify the port-adaptation conditions, or the block adaptation conditions that make the whole WDF implementation computable. (2022-07-15)


A:

== 11
Q: Let us consider two portions of string of different section, which are attached together and modeled using digital waveguides. Derive and describe the junction that models the interconnection of such strings in the Wave Digital domain. Do so by first defining the traveling waves and writing the continuity conditions at the interconnection. From there, derive the mathematical description of the scattering junction, scattering matrix. (2022-06-24)


A:

For each string section $i=1,2$, let $mu_i$ be the linear density and $T$ the string tension. The wave velocity and characteristic impedance are

$
c_i = sqrt(T/mu_i)
$

$
Z_i = T/c_i = sqrt(T mu_i)
$

Using force and velocity as Kirchhoff variables, define the traveling waves by

$
f_i = f_i^+ + f_i^-
$

$
v_i = 1/Z_i (f_i^+ - f_i^-)
$

where $f_i^+$ is incident on the junction and $f_i^-$ is outgoing from the junction.

At the massless connection point, force and velocity continuity must hold. With port velocities oriented toward the junction

$
f_1 = f_2 = f_J
$

$
v_1 + v_2 = 0
$

Since

$
f_i^- = f_J - f_i^+
$

substitution into the velocity condition gives

$
f_J = 2 (Y_1 f_1^+ + Y_2 f_2^+)/(Y_1+Y_2)
$

where

$
Y_i = 1/Z_i
$

Therefore

$
f_1^- = rho f_1^+ + (1-rho) f_2^+
$

$
f_2^- = (1+rho) f_1^+ - rho f_2^+
$

with reflection coefficient

$
rho = (Y_1-Y_2)/(Y_1+Y_2) = (Z_2-Z_1)/(Z_1+Z_2)
$

Hence the Kelly-Lochbaum scattering junction is described by

$
mat(f_1^-; f_2^-) = mat(rho, 1-rho; 1+rho, -rho) mat(f_1^+; f_2^+)
$

The impedance discontinuity therefore causes partial reflection and transmission. If $Z_1=Z_2$, then $rho=0$ and there is no reflection

== 12
Q: Briefly describe the WDF method for modeling lumped-parameter systems. How do you define wave variables? What is the role of the reference resistance? (2022-02-11)


A:

The WDF method models a lumped-parameter physical system starting from an equivalent circuit. Circuit elements are converted into Wave Digital one-port blocks, while their series, parallel, or more general interconnections are represented by scattering junctions or adaptors. The aim is to obtain a computable signal-flow representation of the original system.

For a port described by Kirchhoff variables $v$ and $i$, the wave variables are defined as

$
a = v + Z i
$

$
b = v - Z i
$

or, equivalently with the normalization used in some slides

$
v^+ = 1/2 (v + R i)
$

$
v^- = 1/2 (v - R i)
$

The inverse transformation is

$
v = (a+b)/2
$

$
i = (a-b)/(2 Z)
$

The reference resistance $Z$ or $R$ is a free parameter associated with each port. In WDFs it is not a physical characteristic impedance. It is chosen to simplify the scattering relations, adapt elements or junction ports, eliminate instantaneous reflections, and therefore remove delay-free algebraic loops so that the resulting signal flow is computable.

== 13
Q: Let us consider two acoustic tubes of different section, which are to be joined together and modeled using digital waveguides. Derive and describe the junction that models the interconnection of such tubes in the Wave Digital domain. (2022-01-17)


A:

For a lossless cylindrical acoustic tube of cross-section $S_i$, the traveling variables are acoustic pressure and volume velocity. The characteristic impedance and admittance are

$
Z_i = rho_"air" c / S_i
$

$
Y_i = 1/Z_i = S_i/(rho_"air" c)
$

Define incident and reflected pressure waves at each side of the junction as

$
p_i = p_i^+ + p_i^-
$

$
u_i = Y_i (p_i^+ - p_i^-)
$

At the massless junction, pressure and volume flow must be continuous. Taking both port flows as directed toward the junction gives

$
p_1 = p_2 = p_J
$

$
u_1 + u_2 = 0
$

Since

$
p_i^- = p_J - p_i^+
$

substitution into the flow continuity condition gives

$
p_J = 2 (Y_1 p_1^+ + Y_2 p_2^+) / (Y_1 + Y_2)
$

Therefore the outgoing waves are

$
p_1^- = rho p_1^+ + (1-rho) p_2^+
$

$
p_2^- = (1+rho) p_1^+ - rho p_2^+
$

where the reflection coefficient is

$
rho = (Y_1-Y_2)/(Y_1+Y_2) = (S_1-S_2)/(S_1+S_2)
$

Hence the Kelly-Lochbaum scattering junction is

$
mat(p_1^-; p_2^-) = mat(rho, 1-rho; 1+rho, -rho) mat(p_1^+; p_2^+)
$

The change of tube section produces partial reflection and transmission. If $S_1=S_2$, then $rho=0$ and there is no reflection

== 14
Q: Explain the differences between multiport junctions in Digital WaveGuides and adaptors in Wave Digital Filters. (2022-01-17)


A:

In Digital Waveguides, multiport junctions model the interconnection of distributed propagation media. They enforce the physical continuity conditions and scatter traveling waves according to the characteristic impedances of the connected media. Since DWG junctions are normally separated by propagation delays, the resulting signal flow is naturally computable.

In Wave Digital Filters, the system is lumped and there is no spatial propagation delay between junctions. Directly connecting junctions can therefore create instantaneous algebraic loops and make the signal flow non-computable.

A WDF adaptor is a special junction with one reflection-free port. The reference resistance of that port is chosen so that

$
s_(n n) = 0
$

The reference resistance in a WDF is a free parameter, not a physical characteristic impedance. It is used to eliminate instantaneous reflections and guarantee computability.

Therefore, DWG multiport junctions mainly model physical scattering in distributed systems, while WDF adaptors additionally exploit adaptation to make lumped networks computable.

== 15
Q: Derive the description of a capacitor in the Wave Digital domain. Also derive the conditions for adapting the WD capacitor through an appropriate choice of the port resistance, the parameter that defines the digital waves as a function of the Kirchhoff port variables. (2021-08-31)


A:

For a capacitor

$
i(t) = C dif(v(t), t)
$

or equivalently in the Laplace domain

$
V(s) = Z(s) I(s)
$

with

$
Z(s) = 1/(s C)
$

Define the wave variables from the Kirchhoff port variables as

$
v^+ = 1/2 (v + R i)
$

$
v^- = 1/2 (v - R i)
$

Hence

$
v = v^+ + v^-
$

$
i = (v^+ - v^-)/R
$

Using the impedance relation, the capacitor in the wave domain is described by

$
V^-(s) = K(s) V^+(s)
$

with

$
K(s) = (Z(s)-R)/(Z(s)+R)
$

For the capacitor

$
K(s) = (1/(s C)-R)/(1/(s C)+R)
$

Using the bilinear transform

$
s = 2/T_s (1-z^(-1))/(1+z^(-1))
$

we obtain

$
K_d(z) = (p + z^(-1))/(1 + p z^(-1))
$

where

$
p = (T_s - 2 R C)/(T_s + 2 R C)
$

To adapt the WD capacitor, its instantaneous reflection must be eliminated, so we impose

$
p = 0
$

Therefore

$
R = T_s/(2 C)
$

and the reflection filter becomes

$
K_d(z) = z^(-1)
$

Thus, the adapted WD capacitor is simply a one-sample delay

$
v^-[n] = v^+[n-1]
$

== 16
Q: Parallel 3-port junctions in WDF theory:

a) Write the equations governing the Kirchhoff port variables of a parallel 3-port and derive the corresponding equations in the Wave Digital domain, reflected waves as a function of the incident waves.

b) In order to turn the resulting WD junction into an adaptor, what do you need to do? What are the conditions for that to happen? Why do you need adaptors? (2021-07-13)


A:

a)

For a parallel 3-port junction, the Kirchhoff continuity conditions are

$
i_1 + i_2 + i_3 = 0
$

$
v_1 = v_2 = v_3
$

Define the wave variables at each port as

$
v_i^+ = 1/2 (v_i + R_i i_i)
$

$
v_i^- = 1/2 (v_i - R_i i_i)
$

or equivalently

$
v_i = v_i^+ + v_i^-
$

$
i_i = G_i (v_i^+ - v_i^-)
$

with

$
G_i = 1/R_i
$

Using the continuity conditions, the reflected waves can be written as

$
v_1^- = (alpha_1-1)v_1^+ + alpha_2 v_2^+ + alpha_3 v_3^+
$

$
v_2^- = alpha_1 v_1^+ + (alpha_2-1)v_2^+ + alpha_3 v_3^+
$

$
v_3^- = alpha_1 v_1^+ + alpha_2 v_2^+ + (alpha_3-1)v_3^+
$

where

$
alpha_i = (2 G_i)/(G_1+G_2+G_3)
$

and

$
alpha_1 + alpha_2 + alpha_3 = 2
$

Therefore the scattering relation is

$ mat(v_1^-; v_2^-; v_3^-) =
mat(
alpha_1-1, alpha_2, alpha_3;
alpha_1, alpha_2-1, alpha_3;
alpha_1, alpha_2, alpha_3-1
)
mat(v_1^+; v_2^+; v_3^+) $

b)

To turn the junction into an adaptor, one port must be made reflection-free. If port 3 is adapted, its local reflection coefficient must vanish

$
alpha_3 - 1 = 0
$

so that

$
alpha_3 = 1
$

This gives

$
G_3 = G_1 + G_2
$

or equivalently

$
R_3 = 1/(1/R_1 + 1/R_2)
$

Thus, in a parallel adaptor, the resistance of the adapted port is the parallel combination of the other two port resistances.

Adaptors are needed because WDFs model lumped systems, so junctions may be directly connected without propagation delays. This can create instantaneous algebraic loops and make the signal flow non-computable. A reflection-free port removes the instantaneous reflection and allows junctions to be connected while preserving computability

== 17
Q: Briefly explain how to model a circuit using WDF, when the circuit has a resistive nonlinearity. How do you derive the nonlinearity in the wave digital domain starting from its Kirchhoff description? And how does this wave description of the nonlinearity depend on the rest of the circuit? If you prefer, you can discuss the specific case of a simple RLC circuit (all elements connected in series), with a nonlinear resistor. (2021-06-15)


A:

== 18
Q: Explain the differences between scattering cells in Digital WaveGuides and Wave Digital Filters. (2021-02-01)


A:

== 19
Q: Let us consider two acoustic tubes of different section, which are to be joined together and modeled using digital waveguides. Derive and describe the junction that models the interconnection of such tubes in the Wave Digital domain. (2020-06-17)

A:

== 20
Q: Briefly explain how to model a circuit using WDF, when the circuit has a resistive nonlinearity. How do you derive the nonlinearity in the wave digital domain starting from its Kirchhoff description? And how does this wave description of the nonlinearity depend on the rest of the circuit? If you prefer, you can discuss the specific case of a simple RLC circuit, all elements connected in series, with a nonlinear resistor. (unknown)


A:

A circuit with one resistive nonlinearity is modeled as a Wave Digital connection tree. The nonlinear resistor is placed at the root, the linear elements are placed at the leaves and are adapted, and the adaptor ports along the path toward the nonlinear element are made reflection-free. This removes instantaneous algebraic loops and makes the signal flow computable.

Starting from the Kirchhoff characteristic of the nonlinear resistor

$
F(v,i) = 0
$

define the wave variables

$
v^+ = 1/2 (v + R i)
$

$
v^- = 1/2 (v - R i)
$

with inverse mapping

$
v = v^+ + v^-
$

$
i = (v^+ - v^-)/R
$

Substituting these expressions into the nonlinear Kirchhoff relation gives

$
F(v^+ + v^-, (v^+ - v^-)/R) = 0
$

If this equation can be made explicit with respect to the reflected wave, the nonlinear element is represented in the WD domain as

$
v^- = g(v^+)
$

The physical nonlinear characteristic $F(v,i)=0$ belongs only to the nonlinear element, but the WD function $g$ also depends on the reference resistance $R$. This resistance is determined by the adaptation of the surrounding WDF network, so the wave-domain description of the nonlinearity depends on the rest of the circuit.

For a series RLC circuit with a nonlinear resistor, the linear $R$, $L$, and $C$ elements are adapted and combined through series adaptors. The adapted port facing the nonlinear resistor has an equivalent reference resistance determined by the series connection

$
R_"eq" = R_R + R_L + R_C
$

with

$
R_L = 2L/T_s
$

$
R_C = T_s/(2C)
$

The nonlinear scattering function is then obtained by using $R = R_"eq"$ in its wave transformation

= Sound Field & Ambisonics & Wave Field Synthesis




== 1

Q: Arbitrary-order Ambisonics is often called a 'mode-matching' method. Explain how it differs from amplitude panning, and state the key representation property that makes the encoded signals independent of both the recording and the reproduction setups. (2026-07-23)


A:

Unlike amplitude panning, which directly distributes the source signal among loudspeakers according to the desired direction, arbitrary-order Ambisonics represents and reproduces the sound field by matching its spatial modes, with all loudspeakers contributing to the reproduction.

The key property is that the sound field is encoded as expansion coefficients of a spatial basis. These coefficients describe the sound field itself, so they are independent of the microphone setup used for recording and of the loudspeaker setup used for reproduction.

== 2


Q: Discuss the concepts of internal and external sound fields. (2023-09-05)


A:

An internal sound field is a field observed in a source-free region around the origin, with the sound sources located outside that region. It is typically represented using spherical Bessel functions of the first kind, since they remain finite at the origin

$
p(r, omega) = sum_(l=0)^infinity sum_(m=-l)^l C_(l m)(omega) j_l ((omega/c) r) Y_l^m (theta, phi)
$

An external sound field is a field generated by sources located near the origin and observed in a source-free region outside them. It is typically represented using spherical Hankel functions, which describe outgoing spherical waves

$
p(r, omega) = sum_(l=0)^infinity sum_(m=-l)^l B_(l m)(omega) h_l^(2) ((omega/c) r) Y_l^m (theta, phi)
$

Thus, the distinction depends on the location of the sources relative to the source-free observation region, and this determines which radial basis functions are appropriate.


== 3

Q: Consider Wave Field Synthesis.

- Describe the main idea behind it, and its relation to the Kirchhoff-Helmholtz integral.
- What are the main limitations when it comes to implementing Wave Field Synthesis in practice? (2023-07-19)


A:

Wave Field Synthesis aims to reproduce a desired sound field over an extended listening region by using a distribution of secondary sources. Its theoretical basis is the Kirchhoff Helmholtz integral, which states that the sound field inside a source free volume can be reconstructed from the pressure and its normal derivative on the boundary. In an ideal WFS system, the required monopole and dipole source distributions on the boundary are replaced by loudspeakers driven with suitable signals.

In practice, the continuous secondary source distribution must be replaced by a finite and discrete loudspeaker array. This introduces spatial aliasing, especially at high frequencies, and truncation artifacts, which limit the region of accurate reproduction and produce diffraction from the ends of open arrays. Further approximations, such as eliminating dipoles and using real point source loudspeakers instead of ideal line sources in 2D systems, can introduce modeling reflections and amplitude errors. The reproduced field can also depend on the listener position, and listeners outside the intended reproduction plane experience additional artifacts.


== 4

Q: Describe a data-based approach for the capturing of Higher-Order Ambisonics signals in 3D. What geometry for the microphone array is usually employed? What are the limitations of this geometry with respect to the number of microphones, their placement and the frequency range of operation? (2022-09-07)


A:

In a data-based 3D HOA approach, the sound field is captured with an array of omnidirectional pressure microphones and represented by spherical-harmonic coefficients. The continuous spherical-harmonic analysis integral is approximated by a weighted finite sum of the microphone signals

$
hat(alpha)_(n m)(omega) = 1 / j_n((omega/c)R) sum_(q=1)^(Q_e) p(R, theta_q, phi_q, omega) Y_n^(-m)(theta_q, phi_q) w_q
$

A spherical microphone array is usually employed because it provides similar properties for all directions of sound incidence. For a sound field bandlimited to order $N$, at least $(N+1)^2$ microphones are required in principle. With equiangular placement, microphones become more densely packed near the poles and more microphones are required

$
Q_e >= (2N-1)^2
$

The operating frequency range is limited by the spherical Bessel functions in the analysis formula. The array radius $R$ should therefore be chosen so that

$
j_n((omega/c)R) != 0
$

for all required orders and frequencies. Since spherical Bessel functions of order $n>0$ have a bandpass character, the usable frequency range is limited. In practice, microphones are often mounted on a rigid sphere, whose scattering and diffraction can enlarge the operating frequency range.



== 5

Q: Describe the physical principles on which relies the Wave Field Synthesis method. How would you describe an ideal Wave Field Synthesis system, assuming that there are no limitations in terms of realizability? (2022-01-17)


A:

Wave Field Synthesis relies on Huygens' principle and on the Kirchhoff Helmholtz integral. Huygens' principle states that every point on a propagating wavefront can be regarded as a secondary source generating spherical waves. The Kirchhoff Helmholtz integral states that the sound field inside a source free volume can be reconstructed from the sound pressure and its normal derivative on the boundary.

An ideal WFS system would surround the listening volume with a continuous distribution of secondary sources on its boundary. Using the Kirchhoff Helmholtz formulation, monopole sources would reproduce the contribution associated with the pressure gradient, while dipole sources would reproduce the contribution associated with the pressure. The secondary sources would be driven with the exact boundary signals so that the desired sound field is reconstructed inside the whole volume.



== 6

Q: Describe the basic principles behind the traditional first-order Ambisonics method in 3D, with particular emphasis on the assumption needed to derive the method. What is the peculiarity of the first-order Ambisonics loudspeaker filters? Describe the B format for Ambisonics capturing. (unknown)


A:

Traditional first order Ambisonics represents a 3D sound field by truncating its spherical harmonic expansion to order one. This gives four components: one omnidirectional pressure component and three directional components associated with the x, y, and z directions.

Its traditional derivation assumes that the loudspeakers are sufficiently far from the listener so that their fields can be approximated as plane waves. Under this far field assumption, the decoding coefficients depend mainly on the loudspeaker directions rather than on frequency. Therefore, the loudspeaker filters have the peculiarity of being simple frequency independent gains.

For capturing, first order Ambisonics commonly uses the B format. It contains four signals: W is the pressure signal obtained from an omnidirectional microphone, while X, Y, and Z are directional figure of eight signals along the x, y, and z axes respectively.


== 7

Q: Provide a comparison between Wave Field Synthesis and Higher-Order Ambisonics with specific reference to the nature of the approximations and their consequences on the reproduced sound field. In both cases, assume to consider a 2D rendering system characterized by a uniform circular array of loudspeakers. (unknown)


A:

In Wave Field Synthesis, the ideal continuous distribution of secondary sources on the circular boundary is approximated by a finite set of loudspeakers. This spatial sampling produces spatial aliasing, which distorts the spatial structure of the reproduced field and becomes more severe as frequency increases. With a complete circular array there is no end truncation as in an open linear array, but the use of real point source loudspeakers in a two dimensional system can still introduce amplitude errors.

In Higher Order Ambisonics, the main approximation is instead a truncation of the cylindrical harmonic expansion to a finite order $M$. The reproduced field therefore matches only a finite number of spatial modes. For a uniform circular array, at least $2M+1$ loudspeakers are required

$
Q >= 2M+1
$

With sufficient spatial sampling, no errors are introduced in the retained modes $m=-M,...,M$. The approximation error mainly appears in the higher spatial modes, so the reproduction is accurate only within a limited listening region. Increasing the order and the number of loudspeakers enlarges this region and extends the usable frequency range.

Thus, WFS is mainly affected by spatial sampling of a continuous source distribution, producing spatial aliasing, whereas HOA is mainly affected by modal truncation, producing a limited region in which the sound field is accurately represented.


= Perception & Binaural rendering




== 1

Q: What is HRIR? How does it differ from BRIR? Briefly explain, using a block diagram, how you would implement an HRTF-based binaural rendering system. (2025-07-18)


A:

HRIR (Head-Related Impulse Response) is the time-domain impulse response from a sound source at a given direction to one ear. It describes the filtering caused mainly by the listener's head, torso, and pinnae. Its Fourier transform is the HRTF

$
H_(L,R)(f, theta, phi) = cal(F){h_(L,R)(t, theta, phi)}
$

BRIR (Binaural Room Impulse Response) also includes the acoustic response of the room, such as reflections and reverberation. Therefore, a BRIR is generally much longer and depends not only on the source direction but also on the source and listener positions and on the room.

An HRTF-based binaural renderer filters the source signal with the direction-dependent left- and right-ear HRIRs:

$
x(t) -> h_L (t, theta, phi) -> y_L (t)
$

$
x(t) -> h_R (t, theta, phi) -> y_R (t)
$

with

$
y_L(t) = x(t) ast h_L(t, theta, phi)
$

$
y_R(t) = x(t) ast h_R(t, theta, phi)
$

The two resulting signals are reproduced through the left and right headphone channels. If the source or the listener moves, the HRIR/HRTF pair is updated according to the relative source direction.


== 2
Q: What are the main auditory cues that we use in sound perception in a reverberant environment? Please discuss their role in perception of distance and direction. (2023-09-05)


A:

The main auditory cues for sound perception in a reverberant environment are:

- Interaural Time Difference (ITD), Interaural Level Difference (ILD), and spectral cues, which are mainly used for direction perception. ITD is especially important at low frequencies, ILD at high frequencies, while spectral modifications produced by the pinnae help determine elevation and resolve front-back ambiguities.

- The precedence effect helps preserve the perceived direction of the direct sound in the presence of early reflections. When the direct sound arrives first, localization is mainly dominated by this first wavefront rather than by later reflections.

- Sound level is an important distance cue: in general, a lower received level suggests a larger source distance, although this cue depends on knowing or estimating the source strength.

- The direct-to-reverberant energy ratio is one of the most important distance cues in rooms. As the source moves farther away, the direct sound decreases while the reverberant field changes much less, so the direct-to-reverberant ratio decreases.

- Reverberation itself also contributes to distance perception: a larger relative amount of reverberant energy generally makes a source appear farther away.


== 3

Q: Consider the problem of binaural rendering.

- Describe what is the Head-Related Transfer Function (HRTF).
- Explain how it can be used for binaural rendering.
- Explain how it is possible to take into account a virtual environment. (2023-07-19)


A:

a) The Head-Related Transfer Function (HRTF) is the direction-dependent acoustic transfer function from a sound source to the listener's left or right ear. It includes the filtering effects of the head, torso, and pinnae, and contains localization cues such as ITD, ILD, and spectral modifications. Its time-domain counterpart is the HRIR

$
H_(L,R)(f, theta, phi) = cal(F){h_(L,R)(t, theta, phi)}
$

b) For binaural rendering, the source signal is filtered with the left- and right-ear HRTFs corresponding to the desired source direction. In the time domain, this is implemented by convolution with the corresponding HRIRs

$
y_L(t) = x(t) ast h_L (t, theta, phi)
$

$
y_R(t) = x(t) ast h_R (t, theta, phi)
$

The two outputs are reproduced through headphones. If the source or listener moves, the HRTFs are updated according to the relative direction.

c) A virtual environment can be taken into account by adding the direct sound, reflections, and reverberation of the virtual room. Each propagation path can be rendered using the HRTF corresponding to its arrival direction, with the proper delay and attenuation. Alternatively, the complete response can be represented by left and right Binaural Room Impulse Responses (BRIRs), and the source can be convolved with them.


== 4

Q: Define the Head-Related Transfer Function (HRTF) and explain when and how it is used. (2022-02-11)


A:

The Head-Related Transfer Function (HRTF) is the direction-dependent acoustic transfer function from a sound source to the listener's left or right ear. It describes the filtering effects produced by the head, torso, and pinnae, and therefore contains important spatial cues such as ITD, ILD, and spectral modifications. Its time-domain counterpart is the Head-Related Impulse Response (HRIR)

$
H_(L,R)(f, theta, phi) = cal(F){h_(L,R)(t, theta, phi)}
$

HRTFs are used mainly for binaural rendering over headphones. To create the perception of a virtual sound source at a desired direction, the source signal is filtered separately with the left- and right-ear HRTFs corresponding to that direction. In the time domain, this is implemented by convolution with the corresponding HRIRs

$
y_L(t) = x(t) ast h_L (t, theta, phi)
$

$
y_R(t) = x(t) ast h_R (t, theta, phi)
$

The two resulting signals are reproduced through the left and right headphone channels. If the source or listener moves, the selected HRTFs must be updated according to the relative direction.


== 5

Q: Discuss in broad terms the primary auditory cues for spatial audio perception, both in free-field and in reverberant environments. (2021-08-31)


A:

In free-field conditions, the main auditory cues for spatial perception are:

- Interaural Time Difference (ITD): the difference in arrival time between the two ears, mainly important for localization at low frequencies.
- Interaural Level Difference (ILD): the difference in sound level between the ears due to the acoustic shadow of the head, mainly important at high frequencies.
- Spectral cues: direction-dependent filtering produced mainly by the pinnae, head, and torso. They are particularly important for elevation perception and for resolving front-back ambiguities.
- Sound level: the level of the direct sound generally decreases with increasing source distance, so it can provide a distance cue when the source strength is known or can be estimated.

In reverberant environments, these cues are still present, but reflections and reverberation introduce additional information:

- The precedence effect makes the first-arriving direct sound dominate the perceived direction, reducing the influence of later reflections on localization.
- The direct-to-reverberant energy ratio is an important distance cue. As source distance increases, the direct sound becomes weaker relative to the reverberant field, so a smaller direct-to-reverberant ratio generally indicates a larger distance.
- The overall amount and characteristics of reverberation also contribute to distance perception, with a relatively stronger reverberant component generally producing the perception of a more distant source.

== 6

Q: Describe the binaural rendering method based on capturing signals with an array of microphones arranged on a rigid surface, motion-tracked binaural. Comment on a possible strategy to include a feedback of head movement and on how to interpolate microphone signals. (unknown)


A:

The motion-tracked binaural method uses a microphone array distributed over a rigid surface, typically a rigid sphere, to capture the surrounding sound field. Each microphone records the signal corresponding to one spatial sampling direction.

For binaural reproduction, two microphone signals are selected so that their positions on the rigid surface correspond approximately to the current left- and right-ear directions of the listener. These two signals are then reproduced through the left and right headphone channels.

Head-motion feedback can be included by using a head tracker. The tracked head orientation is converted into the corresponding rotation of the virtual ear positions on the microphone array. When the listener rotates the head, the selected microphone directions are updated in the opposite direction relative to the captured sound field, so that the auditory scene remains stable in space.

Since the desired ear directions usually do not coincide exactly with microphone positions, interpolation between neighboring microphone signals is needed. A simple strategy is to use the signals from the nearest microphones and compute a weighted interpolation according to their angular distance from the desired direction. With a denser array, this interpolation becomes more accurate and spatial artifacts are reduced.


= Stereophony and Panning

== 1

Q: Sine law of stereophony. --- The target is a plane wave from direction $theta$, with phase $angle(p)_"target" (x, 0, omega) = omega / c sin theta x$. Equate it to the linearized phase of the loudspeaker pair and derive the sine panning law. Then solve it for the gain ratio $g_L / g_R$. (2026-07-23)


A:

For the two loudspeakers at angles $plus.minus theta_1$, the linearized phase near the origin is

$
angle p(x, 0, omega) approx frac(g_R - g_L, g_R + g_L) frac(omega, c) sin(theta_1) x
$

The target plane wave from direction $theta$ has phase

$
angle p_"target" (x, 0, omega) = frac(omega, c) sin(theta) x
$

Equating the two phases gives

$
frac(g_R - g_L, g_R + g_L) frac(omega, c) sin(theta_1) x
=
frac(omega, c) sin(theta) x
$

Therefore, the sine panning law is

$
sin(theta) = frac(g_R - g_L, g_R + g_L) sin(theta_1)
$

Letting $r = g_L / g_R$

$
sin(theta) = frac(1-r, 1+r) sin(theta_1)
$

and solving for the gain ratio gives

$
frac(g_L, g_R)
=
frac(sin(theta_1) - sin(theta), sin(theta_1) + sin(theta))
$



== 2

Q: Describe the differences between the following three kinds of representation of the sound field used both in the recording phase of a sound scene and in the reproduction phase: channel-based approach, transform-domain approach and object-based approach. (2022-09-07)


A:

- *Channel-based approach:* the loudspeaker signals themselves are stored and transmitted. The representation is directly tied to a specific loudspeaker layout, so essentially the same layout must be used during reproduction.

- *Transform-domain approach:* the sound field is represented using a set of basis functions rather than loudspeaker signals. At reproduction, a decoding stage converts this representation into signals suitable for the actual loudspeaker layout.

- *Object-based approach:* each virtual source is stored and transmitted separately together with metadata, such as its position or spatial layout. At reproduction, a rendering stage uses this information to generate the loudspeaker signals for the available playback system.

Thus, channel-based representations are tied to a fixed loudspeaker configuration, while transform-domain and object-based representations require reproduction-side processing and are less directly tied to a specific loudspeaker layout.




== 3

Q: Describe the principles of two-channel stereophony and derive the sine law of stereophony. Make sure you list the assumptions that you make for this derivation. (2022-06-24)


A:


Two-channel stereophony creates a virtual source between two loudspeakers by introducing suitable level and/or time differences between their signals

$
d_L(t) = g_L s(t - tau_L), quad d_R(t) = g_R s(t - tau_R)
$

For the sine law, amplitude panning is considered, so $tau_L = tau_R = 0$

The assumptions are:
- the two loudspeakers are placed symmetrically at angles $-theta_1$ and $+theta_1$
- the loudspeakers are in the far field of the listener, so their fields can be approximated as plane waves
- the listener is on the $x$ axis, i.e. $y = 0$
- the listener is very close to the origin, so $k_x x << 1$
- therefore the small-angle approximations $tan(z) approx z$ and $arctan(z) approx z$ can be used

The two loudspeaker fields on the $x$ axis are

$
p_R(x, omega) = g_R e^(j k_x x), quad
p_L(x, omega) = g_L e^(-j k_x x)
$

where

$
k_x = frac(omega, c) sin(theta_1)
$

Their superposition is

$
p(x, 0, omega)
=
(g_R + g_L) cos(k_x x)
+
j (g_R - g_L) sin(k_x x)
$

Hence its phase is

$
angle p(x, 0, omega)
=
arctan (
frac(g_R - g_L, g_R + g_L)
tan(k_x x)
)
$

Near the origin this becomes

$
angle p(x, 0, omega)
approx
frac(g_R - g_L, g_R + g_L)
frac(omega, c) sin(theta_1) x
$

The target is a plane wave arriving from direction $theta$, whose phase is

$
angle p_"target"(x, 0, omega)
=
frac(omega, c) sin(theta) x
$

Equating the two phases gives the sine law of stereophony

$
sin(theta)
=
frac(g_R - g_L, g_R + g_L)
sin(theta_1)
$

Thus, two loudspeakers at $plus.minus theta_1$ locally approximate, around the sweet spot, a plane wave arriving from direction $theta$


== 4

Q: Describe Vector-Based Amplitude Panning (VBAP) and the corresponding panning functions. (2021-07-13)


A:

Vector-Based Amplitude Panning (VBAP) extends amplitude panning to multichannel loudspeaker systems. For each virtual source, the pair of adjacent loudspeakers surrounding the desired source direction is selected, and only this pair is active. In 3D, a triplet of loudspeakers is used instead.

Assuming the loudspeakers are in the far field, let the virtual source direction be

$
v =
mat(
  cos(theta);
  sin(theta)
)
$

For two adjacent loudspeakers at directions $theta_n$ and $theta_(n+1)$

$
v = M g
$

with

$
g =
mat(
  g_n;
  g_(n+1)
)
$

and

$
M =
mat(
  cos(theta_n), cos(theta_(n+1));
  sin(theta_n), sin(theta_(n+1))
)
$

The loudspeaker gains are obtained from

$
g = M^(-1) v
$

For $theta_n <= theta <= theta_(n+1)$, the panning functions are

$
g_n(theta)
=
frac(
  sin(theta_(n+1) - theta),
  sin(theta_(n+1) - theta_n)
)
$

$
g_(n+1)(theta)
=
frac(
  sin(theta - theta_n),
  sin(theta_(n+1) - theta_n)
)
$

All other loudspeakers have zero gain

$
g_nu(theta) = 0
quad "for all other loudspeakers"
$



= Others 

== 1

Q: Two equal masses $m$ are coupled as

$
  m dot.double(x)_1 + k x_1 + k(x_1 - x_2) = 0,
  quad
  m dot.double(x)_2 + k x_2 + k(x_2 - x_1) = 0.
$

where $x_1$ and $x_2$ are the position of the masses along the $x$ axis. Using the change of variables

$
  mat(q_1, q_2) = mat(1, 1; 1, -1) mat(x_1, x_2),
$

show the system decouples into $dot.double(q)_1 = -omega_0^2 q_1$ and $dot.double(q)_2 = -3 omega_0^2 q_2$ with $omega_0^2 = k / m$, and identify the two modal frequencies. (2026-07-23)


A:


= 2026-09-08

== 1

Q: Fractional delay can be implemented with an FIR (e.g. truncated/windowed sinc, Lagrange) or with an allpass filter (Thiran). State the principal advantage and the principal drawback of the allpass realization compared with the FIR one in the context of a feedback synthesis loop.


== 2

Q: In a Cordis--Anima cellular model, masses and links are interconnected by their K-variables (force/displacement). A direct interconnection creates “non-computable” (delay-free) loops. (a) Explain plainly why such loops are a problem for a sample-by-sample simulation. (b) State the standard fix and the price paid for it.


== 3

Q: Show that, for a comb cell of delay $m$ samples ($m T_s$ seconds) to produce a 60 dB decay in time $T_60$, the feedback gain must satisfy

$
g = 10^(-frac(3 m T_s, T_60)).
$

Why does the identical relation hold for an allpass cell?


== 4

Q: For the across-integration mutator, with $tau equiv R C$, the Laplace relations are $V^- + tau s U^+ = V^+ + tau s U^-$ together with the wave/charge constraints. Define

$
H(s) = frac(1 - tau s, 1 + tau s)
$

and derive

$
V^- = H(s) V^+ + (1 - H(s)) U^-.
$

Then give the computability condition in discrete time.


== 5

Q: In Vector-Based Amplitude Panning, a virtual source in direction

$
v = mat(sin theta; cos theta)^T
$

is rendered by the two adjacent loudspeakers $n, n + 1$ at angles $theta_n, theta_(n+1)$ through $v = M g$ with

$
g = mat(g_n; g_(n+1))^T
$

and

$
M = mat(sin theta_n, sin theta_(n+1); cos theta_n, cos theta_(n+1)).
$

Solve for $g = M^(-1) v$ and show

$
g_n = frac(sin(theta_(n+1) - theta), sin(theta_(n+1) - theta_n)),
quad
g_(n+1) = frac(sin(theta - theta_n), sin(theta_(n+1) - theta_n)).
$
