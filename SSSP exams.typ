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
  #align(center)[作者：#link("https://github.com/worldedge1933")[\@worldedge1933]]

  #v(0.6em)
  #align(center)[2026-06-10]
]


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



= 2025-07-18















== 6

Q: What is HRIR? How does it differ from BRIR? Briefly explain, using a block diagram, how you would implement an HRTF-based binaural rendering system. (2025-07-18)


A:




= 2023-09-05

















== 7

Q: Discuss the concepts of internal and external sound fields. (2023-09-05)


A:



= 2023-07-19












== 4

Q: Consider the problem of binaural rendering.

- Describe what is the Head-Related Transfer Function (HRTF).
- Explain how it can be used for binaural rendering.
- Explain how it is possible to take into account a virtual environment. (2023-07-19)


A:






== 7

Q: Consider Wave Field Synthesis.

- Describe the main idea behind it, and its relation to the Kirchhoff-Helmholtz integral.
- What are the main limitations when it comes to implementing Wave Field Synthesis in practice? (2023-07-19)


A:


= 2022-09-07









== 5

Q: Describe the differences between the following three kinds of representation of the sound field used both in the recording phase of a sound scene and in the reproduction phase: channel-based approach, transform-domain approach and object-based approach. (2022-09-07)


A:



== 6

Q: Describe a data-based approach for the capturing of Higher-Order Ambisonics signals in 3D. What geometry for the microphone array is usually employed? What are the limitations of this geometry with respect to the number of microphones, their placement and the frequency range of operation? (2022-09-07)


A:



= 2022-06-24













== 6

Q: Describe the principles of two-channel stereophony and derive the sine law of stereophony. Make sure you list the assumptions that you make for this derivation. (2022-06-24)


A:



= 2022-02-11











== 6

Q: Define the Head-Related Transfer Function (HRTF) and explain when and how it is used. (2022-02-11)


A:



= 2022-01-17









== 6

Q: Describe the physical principles on which relies the Wave Field Synthesis method. How would you describe an ideal Wave Field Synthesis system, assuming that there are no limitations in terms of realizability? (2022-01-17)


A:



= 2021-08-31














== 6

Q: Discuss in broad terms the primary auditory cues for spatial audio perception, both in free-field and in reverberant environments. (2021-08-31)


A:



= 2021-07-13











== 5

Q: Describe Vector-Based Amplitude Panning (VBAP) and the corresponding panning functions. (2021-07-13)


A:



= unknown








== 4

Q: Describe the binaural rendering method based on capturing signals with an array of microphones arranged on a rigid surface, motion-tracked binaural. Comment on a possible strategy to include a feedback of head movement and on how to interpolate microphone signals. (unknown)


A:



== 5

Q: Describe the basic principles behind the traditional first-order Ambisonics method in 3D, with particular emphasis on the assumption needed to derive the method. What is the peculiarity of the first-order Ambisonics loudspeaker filters? Describe the B format for Ambisonics capturing. (unknown)


A:



== 6

Q: Provide a comparison between Wave Field Synthesis and Higher-Order Ambisonics with specific reference to the nature of the approximations and their consequences on the reproduced sound field. In both cases, assume to consider a 2D rendering system characterized by a uniform circular array of loudspeakers. (unknown)


A:


= Oscillator and DPW

== 1

Q: Describe the matrix data model of a sinusoidal (ballistic) oscillator, and the conditions that the matrix must satisfy in order to behave like an oscillator. Offer an interpretation of such conditions based on eigenvalue decomposition. (2025-07-18)


A:

== 2

Q: Sinusoidal oscillator:

- Derive the matrix data model of a dynamical system implementing a sinusoidal oscillator starting from trigonometric equations.
- Explain how to generalize the matrix of this model: what conditions does the matrix need to satisfy?
- Offer an interpretation of such conditions based on eigenvalue decomposition. (2024-02-09)


A:

== 3

Q: Describe the Differentiated Parabolic Waveform (DPW) algorithm for reducing aliasing in discontinuous waveform generation. (2024-02-09)


A:

== 4

Q: Describe the Differentiated Parabolic Waveform (DPW) algorithm for reducing aliasing in discontinuous waveform generation. (2023-06-26)




A:

== 5

Q: Give a general description of granular synthesis and its practical use for the production of music. (2023-06-26)


A:

== 6

Q: Describe how to implement an oscillator in the form of a dynamical systems, in free evolution, starting from trigonometric formulas. (2022-06-24)


A:

== 7

Q: Briefly describe how to implement a generic dynamic oscillator in matrix form and describe an example oscillator that you can implement with it. (2022-01-17)


A:

== 8

Q: Sinusoidal oscillator:

a) Derive the matrix data model of a dynamical system implementing a sinusoidal oscillator starting from trigonometric equations.

b) Explain how to generalize the matrix of this model: what conditions does the matrix need to satisfy?

c) Offer an interpretation of such conditions based on eigenvalue decomposition. (2021-07-13)


A:

== 9

Q: Describe the Differentiated Parabolic Waveform (DPW) algorithm for reducing aliasing in discontinuous waveform generation. (unknown)


A:

= Nonlinear

== 1

Q: Describe the NonLinear Modeling of sounds and explain when and why this approach is useful. Explain the differences between waveshaping and modulations. Define harmonic distortion, please write a formula for it and comment it, and explain for which types of nonlinear modeling this definition has a relevant meaning. (2022-09-07)


A:

== 2

Q: Briefly describe the frequency modulation method for sound synthesis. What are operators, and what are the interconnection options? (2022-06-24)




A:

== 3

Q: Describe waveshaping methods for nonlinear signal modeling/synthesis. Explain the difference between using a symmetrical or an asymmetrical nonlinear characteristic. (2022-01-17)


A:

== 4

Q: Sound synthesis through nonlinear distortion:

a) Describe sound synthesis based on waveshaping.

b) What is the purpose of the nonlinearity in this process? How does its symmetry/asymmetry affect the result?

c) Can phase or frequency modulation be classified as a waveshaping method? Please justify your answer. (2021-07-13)


A:

= Wave table and Granular

== 1

Q: Describe the principles behind granular synthesis. What are grains and what does the granulation process consist of? What types of granulations are commonly used? (2023-09-05)


A:

== 2

Q: Consider the problem of sound synthesis by means of signal-based approaches.

- Briefly report the idea behind the wavetable synthesis method.
- Define and describe the Synchronous Overlap and Add (SOLA) method, explaining which is the wavetable synthesis problem that it can help solving. (2023-07-19)


A:

== 3

Q: Briefly describe how to implement a digital oscillator based on wavetable method. Explain pros and cons of such a solution and how to implement interpolation between samples. (2023-06-26)


A:



== 4

Q: Describe granular synthesis in general terms. What are grains and what does the granulation process consist of? What types of granulations are commonly used and in what situations? (2021-08-31)


A:


= Effects

== 1

Q: What information can we perceptually gather from early reflections? What about late reverberations? When and how do we decide that the early reflection phase of the room impulse response turns into a late reverberation phase? (2024-02-09)


A:

== 2

Q: If we want to build a late reverberation scheme, what kind of elementary IIR blocks do we use and how do we combine them together? How do we control the density of echoes and the density of resonances in the late reverberation using such combinations of blocks? (2024-02-09)

A:

== 3

Q: Consider sound propagation in a reverberant environment. What information can we perceptually gather from early reflections? What about late reverberations? When and how do we decide that the early reflection phase of the room impulse response turns into a late reverberation phase? (2023-09-05)


A:

== 4

Q: What are the main auditory cues that we use in sound perception in a reverberant environment? Please discuss their role in perception of distance and direction. (2023-09-05)


A:

== 5

Q: Consider the problem of synthesizing a reverberated audio signal.

- Define the concept of Room Impulse Response (RIR) and highlight its component.
- Consider a rectangular room with one microphone and one sound source. Considering only first-order reflections, i.e., after one reflection, the signal does not "bounce" on walls anymore, sketch a possible RIR. Hint: ignore the floor and the ceiling. Clearly report the labels on the axes.
- Explain how it is possible to use a RIR to apply reverberation in the digital domain to a dry sound recording. (2023-07-19)


A:

== 6

Q: Consider the implementation of audio effects, e.g., chorus, flanger, etc., by means of delay lines.

- Describe the general concept of delay line applied to an audio signal.
- Describe the differences among: i) an integer delay line; ii) a fractional delay line; iii) a time-varying fractional delay line.
- Which kinds of delay lines need an interpolator? Why? (2023-07-19)


A:

== 7

Q: Describe the Feedback Delay Network scheme for reverberation modeling, with particular reference to:

- In what way does it generalize COMB filters?
- What conditions do diffusion matrices need to satisfy? (2023-06-26)


A:

== 8

Q: Describe, with the help of a schematic representation, the main structure of a Leslie rotating speaker, providing details on the physical phenomena that characterize each element. Propose a block diagram to implement this structure with DSP technique. Carefully discuss the role of each block. (2023-06-26)


A:


== 9

Q: Define the Energy Decay Curve. Define the reverberation time T60 and how it can be measured from the Energy Decay Curve. (2023-06-26)


A:

== 10

Q: How does a feedback delay network (FDN) work for modeling and implementing reverberation? In what way does it generalize COMB filters? (2022-09-07)


A:


== 11

Q: Describe in broad terms the design principles behind maximally flat fractional delay filter. (2022-06-24)


A:

== 12

Q: Assume you are in a large room, and you want to measure its reverberation time. You have access to an audio recording device with which you initially measure the level of background noise, noise floor. Then you record the room impulse response (RIR) corresponding to the impulsive sound produced by popping a balloon. Using the signal you acquire, how do you proceed with computing the reverberation time? Please begin by defining the reverberation time, then describe the steps that you take in order to measure the reverberation time. Assume that the level of impulsive noise produced by the popping of the balloon is 35 dB above the noise floor. How do you proceed in this case? (2022-06-24)


A:

== 13

Q: What information can we perceptually gather from early reflections? What about late reverberations? When and how do we decide that the early reflection phase of the room impulse response turns into a late reverberation phase? (2022-02-11)


A:

== 14

Q: Define the reverberation time. Define the T60 and describe how to measure it. Explain how to estimate it when the noise floor is too high to measure it. (2022-01-17)


A:

== 15

Q: Describe in broad terms the maximally flat fractional delay filter. What are the conditions that you need to set in order to derive this filter? (2021-08-31)


A:

== 16

Q: Describe in broad terms the comb filter and the allpass filter as elementary building blocks for building and shaping a late reverberation filter. What role do they play in the design? How do you interconnect such building blocks? (2021-08-31)


A:

== 17

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
H_"LP"(z) = 1/2 (1 + z^(-1)).
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
f_0' = F_s / (M + 1).
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


== 4

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


== 5

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


== 6

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



== 7

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


== 8

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




= DWG & WDF

== 1

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


== 2

Q: Let us consider two portions of string of different section, which are attached together and modeled using Digital Waveguides. Derive and describe the junction that models the interconnection of such strings in the waveguide domain. Do so by defining the traveling waves and writing the continuity conditions at the connection. From there derive the mathematical description of the scattering junction. (2024-02-09)


A:

For each string section, define traveling force waves from the traveling velocity waves. With string tension $T$, linear density $mu_i$, propagation speed $c_i$, characteristic impedance $Z_i$ and admittance $Y_i$

$ c_i = sqrt(T / mu_i) $

$ Z_i = T / c_i = sqrt(T mu_i) $

$ Y_i = 1 / Z_i $

The force and velocity at port $i$ are written in terms of incident and reflected force waves as

$ f_i = f_i^+ + f_i^- $

$ v_i = Y_i (f_i^+ - f_i^-) $

At the massless connection point, force and velocity continuity give

$ f_1 = f_2 = f_J $

$ v_1 + v_2 = 0 $

Since

$ f_i^- = f_J - f_i^+ $

substitution into the velocity continuity condition gives

$ f_J = 2 (Y_1 f_1^+ + Y_2 f_2^+) / (Y_1 + Y_2) $

Therefore the outgoing waves are

$ f_1^- = rho f_1^+ + (1 - rho) f_2^+ $

$ f_2^- = (1 + rho) f_1^+ - rho f_2^+ $

where

$ rho = (Y_1 - Y_2) / (Y_1 + Y_2) = (Z_2 - Z_1) / (Z_1 + Z_2) $

Hence the junction is the two-port Kelly-Lochbaum scattering junction

$ mat(f_1^-, f_2^-) = mat(rho, 1-rho; 1+rho, -rho) mat(f_1^+, f_2^+) $

The impedance discontinuity therefore produces partial reflection and partial transmission. If $Z_1 = Z_2$, then $rho = 0$ and there is no reflection.


== 3

Q: Explain the differences between multiport junctions in Digital Waveguides and adaptors in Wave Digital Filters. (2024-02-09)


A:

In Digital Waveguides, multiport junctions model the interconnection of distributed propagation media. They enforce the physical continuity conditions and perform scattering between traveling waves. Their wave mapping depends on the physical characteristic impedances of the connected media. Junctions are normally separated by delay lines, so the resulting signal flow is naturally computable.

In Wave Digital Filters, the model is lumped and there is no spatial propagation, so two junctions may be connected without any delay between them. This can create instantaneous algebraic loops and make the signal flow non-computable.

A WDF adaptor is therefore a special junction in which one port is made reflection-free by choosing its reference resistance appropriately

$ s_(n n) = 0 $

The reference resistances in WDFs are free parameters rather than physical characteristic impedances. They are chosen to adapt ports, eliminate instantaneous reflections, and make the network computable.

Thus, DWG multiport junctions mainly model physical scattering between propagation paths, while WDF adaptors additionally use port adaptation to guarantee computability in lumped networks.


== 4

Q: Describe Digital Waveguides (DWGs) and their application to physical modeling. How do they differ from Wave Digital Filters? Is it possible to combine both approaches? If yes, how? (2023-09-05)


A:

Digital Waveguides are used for distributed-parameter physical systems described by PDEs, such as strings and acoustic tubes. Instead of discretizing the PDE directly, a DWG discretizes its general traveling-wave solution. For the 1-D wave equation

$ y(x,t) = y^+(c t-x) + y^-(c t+x) $

the two traveling waves are implemented by delay lines. Impedance discontinuities are modeled by scattering junctions, and multiport junctions enforce continuity conditions between connected propagation paths.

Wave Digital Filters are the lumped-parameter counterpart of DWGs. They are used for systems described by ODEs or equivalent circuits. WDFs also use wave variables and scattering, but the port resistance $R$ is a free parameter rather than a physical characteristic impedance. Since lumped systems do not contain propagation delays between junctions, instantaneous algebraic loops may appear. Therefore WDFs use adapted ports and adaptors to remove instantaneous reflections and guarantee computability.

The two approaches can be combined in a hybrid WDF-DWG model. Distributed parts, such as the two portions of a string, are modeled by DWGs, while lumped or nonlinear interaction elements are modeled in the WDF domain. They are connected through compatible wave-variable ports and scattering structures. A typical example is bow-string interaction, where the string is represented by DWGs and the local nonlinear bow interaction is represented by a WDF element.


== 5

Q: Consider Wave Digital Filters (WDF).

- Briefly explain how to model a circuit using WDF, when the circuit has a resistive nonlinearity.
- How do you derive the nonlinearity in the wave digital domain starting from its Kirchhoff description?
- How does such a wave description of the nonlinearity depend on the rest of the circuit? (2023-07-19)


A:

A circuit with one resistive nonlinearity is modeled as a Wave Digital connection tree. The nonlinear one-port is placed at the root, the linear one-port elements are the leaves and are adapted, and the internal adaptor ports along the path to the root are made reflection-free. This removes instantaneous algebraic loops and makes the structure computable.

Starting from the Kirchhoff description of the nonlinear element

$ F(v,i) = 0 $

define the wave variables

$ v^+ = 1/2 (v + R i) $

$ v^- = 1/2 (v - R i) $

with inverse mapping

$ v = v^+ + v^- $

$ i = (v^+ - v^-)/R $

Substituting into the Kirchhoff characteristic gives

$ F(v^+ + v^-, (v^+ - v^-)/R) = 0 $

If this relation is explicitable with respect to the reflected wave, it can be written as

$ v^- = g(v^+) $

which is the nonlinear scattering relation used in the WD domain.

The wave-domain nonlinearity depends on the reference resistance $R$. Therefore the physical Kirchhoff characteristic $F(v,i)=0$ is intrinsic to the nonlinear element, but its WD scattering function $g$ depends on the port resistance chosen by the surrounding WDF network. In a connection tree, this resistance is determined by the adaptation of the rest of the circuit.


== 6

Q: Derive the description of a capacitor in the Wave Digital domain. Also derive the conditions for adapting the capacitor through an appropriate choice of the parameter defining the digital waves as a function of the Kirchhoff port variables. (2022-09-07)


A:

For a capacitor

$ i(t) = C dif(v(t), t) $

or, in the Laplace domain

$ V(s) = Z(s) I(s) $

with

$ Z(s) = 1/(s C) $

Define the wave variables from the Kirchhoff port variables as

$ v^+ = 1/2 (v + R i) $

$ v^- = 1/2 (v - R i) $

Hence

$ v = v^+ + v^- $

$ i = (v^+ - v^-)/R $

Using

$ V(s) = Z(s) I(s) $

the wave-domain relation becomes

$ V^-(s) = K(s) V^+(s) $

with

$ K(s) = (Z(s)-R)/(Z(s)+R) $

For the capacitor

$ K(s) = (1/(s C)-R)/(1/(s C)+R) $

Using the bilinear transform

$ s = 2/T_s (1-z^(-1))/(1+z^(-1)) $

we obtain

$ K_d(z) = (p + z^(-1))/(1 + p z^(-1)) $

where

$ p = (T_s - 2 R C)/(T_s + 2 R C) $

In general, this filter has an instantaneous input-output dependency because of the coefficient $p$. To adapt the capacitor, this instantaneous reflection must be removed, so we impose

$ p = 0 $

Therefore

$ 2 R C = T_s $

and the required reference resistance is

$ R = T_s/(2 C) $

With this choice

$ K_d(z) = z^(-1) $

Thus, an adapted Wave Digital capacitor is represented by a one-sample delay

$ v^-[n] = v^+[n-1] $



== 7

Q: Let us consider two portions of string of different section, which are attached together and modeled using digital waveguides. Derive and describe the junction that models the interconnection of such strings in the Wave Digital domain. Do so by first defining the traveling waves and writing the continuity conditions at the interconnection. From there, derive the mathematical description of the scattering junction, scattering matrix. (2022-06-24)


A:

For each string section $i=1,2$, let $mu_i$ be the linear density and $T$ the string tension. The wave velocity and characteristic impedance are

$ c_i = sqrt(T/mu_i) $

$ Z_i = T/c_i = sqrt(T mu_i) $

Using force and velocity as Kirchhoff variables, define the traveling waves by

$ f_i = f_i^+ + f_i^- $

$ v_i = 1/Z_i (f_i^+ - f_i^-) $

where $f_i^+$ is incident on the junction and $f_i^-$ is outgoing from the junction.

At the massless connection point, force and velocity continuity must hold. With port velocities oriented toward the junction

$ f_1 = f_2 = f_J $

$ v_1 + v_2 = 0 $

Since

$ f_i^- = f_J - f_i^+ $

substitution into the velocity condition gives

$ f_J = 2 (Y_1 f_1^+ + Y_2 f_2^+)/(Y_1+Y_2) $

where

$ Y_i = 1/Z_i $

Therefore

$ f_1^- = rho f_1^+ + (1-rho) f_2^+ $

$ f_2^- = (1+rho) f_1^+ - rho f_2^+ $

with reflection coefficient

$ rho = (Y_1-Y_2)/(Y_1+Y_2) = (Z_2-Z_1)/(Z_1+Z_2) $

Hence the Kelly-Lochbaum scattering junction is described by

$ mat(f_1^-; f_2^-) = mat(rho, 1-rho; 1+rho, -rho) mat(f_1^+; f_2^+) $

The impedance discontinuity therefore causes partial reflection and transmission. If $Z_1=Z_2$, then $rho=0$ and there is no reflection





== 8

Q: Briefly describe the WDF method for modeling lumped-parameter systems. How do you define wave variables? What is the role of the reference resistance? (2022-02-11)


A:

The WDF method models a lumped-parameter physical system starting from an equivalent circuit. Circuit elements are converted into Wave Digital one-port blocks, while their series, parallel, or more general interconnections are represented by scattering junctions or adaptors. The aim is to obtain a computable signal-flow representation of the original system.

For a port described by Kirchhoff variables $v$ and $i$, the wave variables are defined as

$ a = v + Z i $

$ b = v - Z i $

or, equivalently with the normalization used in some slides

$ v^+ = 1/2 (v + R i) $

$ v^- = 1/2 (v - R i) $

The inverse transformation is

$ v = (a+b)/2 $

$ i = (a-b)/(2 Z) $

The reference resistance $Z$ or $R$ is a free parameter associated with each port. In WDFs it is not a physical characteristic impedance. It is chosen to simplify the scattering relations, adapt elements or junction ports, eliminate instantaneous reflections, and therefore remove delay-free algebraic loops so that the resulting signal flow is computable.




== 9

Q: Let us consider two acoustic tubes of different section, which are to be joined together and modeled using digital waveguides. Derive and describe the junction that models the interconnection of such tubes in the Wave Digital domain. (2022-01-17)


A:

For a lossless cylindrical acoustic tube of cross-section $S_i$, the traveling variables are acoustic pressure and volume velocity. The characteristic impedance and admittance are

$ Z_i = rho_"air" c / S_i $

$ Y_i = 1/Z_i = S_i/(rho_"air" c) $

Define incident and reflected pressure waves at each side of the junction as

$ p_i = p_i^+ + p_i^- $

$ u_i = Y_i (p_i^+ - p_i^-) $

At the massless junction, pressure and volume flow must be continuous. Taking both port flows as directed toward the junction gives

$ p_1 = p_2 = p_J $

$ u_1 + u_2 = 0 $

Since

$ p_i^- = p_J - p_i^+ $

substitution into the flow continuity condition gives

$ p_J = 2 (Y_1 p_1^+ + Y_2 p_2^+) / (Y_1 + Y_2) $

Therefore the outgoing waves are

$ p_1^- = rho p_1^+ + (1-rho) p_2^+ $

$ p_2^- = (1+rho) p_1^+ - rho p_2^+ $

where the reflection coefficient is

$ rho = (Y_1-Y_2)/(Y_1+Y_2) = (S_1-S_2)/(S_1+S_2) $

Hence the Kelly-Lochbaum scattering junction is

$ mat(p_1^-; p_2^-) = mat(rho, 1-rho; 1+rho, -rho) mat(p_1^+; p_2^+) $

The change of tube section produces partial reflection and transmission. If $S_1=S_2$, then $rho=0$ and there is no reflection



== 10

Q: Explain the differences between multiport junctions in Digital WaveGuides and adaptors in Wave Digital Filters. (2022-01-17)


A:

In Digital Waveguides, multiport junctions model the interconnection of distributed propagation media. They enforce the physical continuity conditions and scatter traveling waves according to the characteristic impedances of the connected media. Since DWG junctions are normally separated by propagation delays, the resulting signal flow is naturally computable.

In Wave Digital Filters, the system is lumped and there is no spatial propagation delay between junctions. Directly connecting junctions can therefore create instantaneous algebraic loops and make the signal flow non-computable.

A WDF adaptor is a special junction with one reflection-free port. The reference resistance of that port is chosen so that

$ s_(n n) = 0 $

The reference resistance in a WDF is a free parameter, not a physical characteristic impedance. It is used to eliminate instantaneous reflections and guarantee computability.

Therefore, DWG multiport junctions mainly model physical scattering in distributed systems, while WDF adaptors additionally exploit adaptation to make lumped networks computable.

== 11

Q: Derive the description of a capacitor in the Wave Digital domain. Also derive the conditions for adapting the WD capacitor through an appropriate choice of the port resistance, the parameter that defines the digital waves as a function of the Kirchhoff port variables. (2021-08-31)


A:

For a capacitor

$ i(t) = C dif(v(t), t) $

or equivalently in the Laplace domain

$ V(s) = Z(s) I(s) $

with

$ Z(s) = 1/(s C) $

Define the wave variables from the Kirchhoff port variables as

$ v^+ = 1/2 (v + R i) $

$ v^- = 1/2 (v - R i) $

Hence

$ v = v^+ + v^- $

$ i = (v^+ - v^-)/R $

Using the impedance relation, the capacitor in the wave domain is described by

$ V^-(s) = K(s) V^+(s) $

with

$ K(s) = (Z(s)-R)/(Z(s)+R) $

For the capacitor

$ K(s) = (1/(s C)-R)/(1/(s C)+R) $

Using the bilinear transform

$ s = 2/T_s (1-z^(-1))/(1+z^(-1)) $

we obtain

$ K_d(z) = (p + z^(-1))/(1 + p z^(-1)) $

where

$ p = (T_s - 2 R C)/(T_s + 2 R C) $

To adapt the WD capacitor, its instantaneous reflection must be eliminated, so we impose

$ p = 0 $

Therefore

$ R = T_s/(2 C) $

and the reflection filter becomes

$ K_d(z) = z^(-1) $

Thus, the adapted WD capacitor is simply a one-sample delay

$ v^-[n] = v^+[n-1] $

== 12

Q: Parallel 3-port junctions in WDF theory:

a) Write the equations governing the Kirchhoff port variables of a parallel 3-port and derive the corresponding equations in the Wave Digital domain, reflected waves as a function of the incident waves.

b) In order to turn the resulting WD junction into an adaptor, what do you need to do? What are the conditions for that to happen? Why do you need adaptors? (2021-07-13)


A:

a)

For a parallel 3-port junction, the Kirchhoff continuity conditions are

$ i_1 + i_2 + i_3 = 0 $

$ v_1 = v_2 = v_3 $

Define the wave variables at each port as

$ v_i^+ = 1/2 (v_i + R_i i_i) $

$ v_i^- = 1/2 (v_i - R_i i_i) $

or equivalently

$ v_i = v_i^+ + v_i^- $

$ i_i = G_i (v_i^+ - v_i^-) $

with

$ G_i = 1/R_i $

Using the continuity conditions, the reflected waves can be written as

$ v_1^- = (alpha_1-1)v_1^+ + alpha_2 v_2^+ + alpha_3 v_3^+ $

$ v_2^- = alpha_1 v_1^+ + (alpha_2-1)v_2^+ + alpha_3 v_3^+ $

$ v_3^- = alpha_1 v_1^+ + alpha_2 v_2^+ + (alpha_3-1)v_3^+ $

where

$ alpha_i = (2 G_i)/(G_1+G_2+G_3) $

and

$ alpha_1 + alpha_2 + alpha_3 = 2 $

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

$ alpha_3 - 1 = 0 $

so that

$ alpha_3 = 1 $

This gives

$ G_3 = G_1 + G_2 $

or equivalently

$ R_3 = 1/(1/R_1 + 1/R_2) $

Thus, in a parallel adaptor, the resistance of the adapted port is the parallel combination of the other two port resistances.

Adaptors are needed because WDFs model lumped systems, so junctions may be directly connected without propagation delays. This can create instantaneous algebraic loops and make the signal flow non-computable. A reflection-free port removes the instantaneous reflection and allows junctions to be connected while preserving computability

== 13

Q: Briefly explain how to model a circuit using WDF, when the circuit has a resistive nonlinearity. How do you derive the nonlinearity in the wave digital domain starting from its Kirchhoff description? And how does this wave description of the nonlinearity depend on the rest of the circuit? If you prefer, you can discuss the specific case of a simple RLC circuit, all elements connected in series, with a nonlinear resistor. (unknown)


A:

A circuit with one resistive nonlinearity is modeled as a Wave Digital connection tree. The nonlinear resistor is placed at the root, the linear elements are placed at the leaves and are adapted, and the adaptor ports along the path toward the nonlinear element are made reflection-free. This removes instantaneous algebraic loops and makes the signal flow computable.

Starting from the Kirchhoff characteristic of the nonlinear resistor

$ F(v,i) = 0 $

define the wave variables

$ v^+ = 1/2 (v + R i) $

$ v^- = 1/2 (v - R i) $

with inverse mapping

$ v = v^+ + v^- $

$ i = (v^+ - v^-)/R $

Substituting these expressions into the nonlinear Kirchhoff relation gives

$ F(v^+ + v^-, (v^+ - v^-)/R) = 0 $

If this equation can be made explicit with respect to the reflected wave, the nonlinear element is represented in the WD domain as

$ v^- = g(v^+) $

The physical nonlinear characteristic $F(v,i)=0$ belongs only to the nonlinear element, but the WD function $g$ also depends on the reference resistance $R$. This resistance is determined by the adaptation of the surrounding WDF network, so the wave-domain description of the nonlinearity depends on the rest of the circuit.

For a series RLC circuit with a nonlinear resistor, the linear $R$, $L$, and $C$ elements are adapted and combined through series adaptors. The adapted port facing the nonlinear resistor has an equivalent reference resistance determined by the series connection

$ R_"eq" = R_R + R_L + R_C $

with

$ R_L = 2L/T_s $

$ R_C = T_s/(2C) $

The nonlinear scattering function is then obtained by using $R = R_"eq"$ in its wave transformation


