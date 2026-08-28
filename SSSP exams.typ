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


== 2

Q: Digital string model:

a) Describe the model of a digital string based on the Karplus-Strong algorithm (use a scheme and comment on it).

b) Why do we need a fractional delay for fine-tuning such a model? Please explain that by showing what happens to the pitch of the tone generated by the KS algorithm, when adding one delay element to the delay time. (2025-07-18)


A:

== 5

Q: Consider the d'Alembert Equation, which governs the behavior of an ideal string or an acoustic tube. Derive a Finite Difference (FD) computational scheme for this equation. Specify the general condition that the sampling steps in space and time must satisfy. (2025-07-18)


A:


== 3

Q: Explain the Karplus-Strong algorithm pointing out its purpose and characteristics. What kind of filter does it use? Help yourself by drawing a block diagram. How is it possible to employ it for physical modeling? Provide an example of application. (2023-09-05)


A:


== 2

Q: Consider the D'Alembert Equation, Partial Differential Equation, describing an ideal string. Write the general solution of this PDE and explain why it satisfies that PDE. How do you look for stationary waves and derive the so-called Fourier solution of this PDE? (2022-09-07)


A:


== 2

Q: Describe the Karplus-Strong algorithms and the related issues concerning tuning. How do you overcome such issues? (2022-02-11)


A:



== 3

Q: Describe the principles behind the cellular modeling method "Cordis-Anima". What are the advantages? Where is it mostly used? What are the issues associated to this approach? (2022-02-11)


A:




== 2

Q: Consider the D'Alembert Equation, Partial Differential Equation, describing an ideal string. Write the general solution of this PDE and explain why it satisfies that PDE. Derive the so-called Fourier solution of this PDE by using the condition of stationary waves. (2021-08-31)


A:



== 3

Q: Digital string model:

a) Describe the model of a digital string based on the Karplus-Strong algorithm, use a scheme and comment on it.

b) Why do we need a fractional delay for fine-tuning such a model? Please explain that by showing what happens to the pitch of the tone generated by the KS algorithm, when adding one delay element to the delay line. (2021-07-13)


A:



= DWG & WDF

== 4

Q: Consider the Wave Digital connection tree structure of an envelope follower circuit containing a single nonlinear diode D. Identify which ports require adaptation symbols directly on the diagram. Additionally, describe the computational flow executed at each sampling step to simulate the nonlinear circuit in the WD domain. (2025-07-18)


A:

== 5

Q: Let us consider two portions of string of different section, which are attached together and modeled using Digital Waveguides. Derive and describe the junction that models the interconnection of such strings in the waveguide domain. Do so by defining the traveling waves and writing the continuity conditions at the connection. From there derive the mathematical description of the scattering junction. (2024-02-09)


A:



== 4

Q: Explain the differences between multiport junctions in Digital Waveguides and adaptors in Wave Digital Filters. (2024-02-09)


A:




== 6

Q: Describe Digital Waveguides (DWGs) and their application to physical modeling. How do they differ from Wave Digital Filters? Is it possible to combine both approaches? If yes, how? (2023-09-05)


A:


== 5

Q: Consider Wave Digital Filters (WDF).

- Briefly explain how to model a circuit using WDF, when the circuit has a resistive nonlinearity.
- How do you derive the nonlinearity in the wave digital domain starting from its Kirchhoff description?
- How does such a wave description of the nonlinearity depend on the rest of the circuit? (2023-07-19)


A:




== 3

Q: Derive the description of a capacitor in the Wave Digital domain. Also derive the conditions for adapting the capacitor through an appropriate choice of the parameter defining the digital waves as a function of the Kirchhoff port variables. (2022-09-07)


A:





== 4

Q: Let us consider two portions of string of different section, which are attached together and modeled using digital waveguides. Derive and describe the junction that models the interconnection of such strings in the Wave Digital domain. Do so by first defining the traveling waves and writing the continuity conditions at the interconnection. From there, derive the mathematical description of the scattering junction, scattering matrix. (2022-06-24)


A:





== 4

Q: Briefly describe the WDF method for modeling lumped-parameter systems. How do you define wave variables? What is the role of the reference resistance? (2022-02-11)


A:





== 2

Q: Let us consider two acoustic tubes of different section, which are to be joined together and modeled using digital waveguides. Derive and describe the junction that models the interconnection of such tubes in the Wave Digital domain. (2022-01-17)


A:





== 4

Q: Explain the differences between multiport junctions in Digital WaveGuides and adaptors in Wave Digital Filters. (2022-01-17)


A:



== 4

Q: Derive the description of a capacitor in the Wave Digital domain. Also derive the conditions for adapting the WD capacitor through an appropriate choice of the port resistance, the parameter that defines the digital waves as a function of the Kirchhoff port variables. (2021-08-31)


A:


== 4

Q: Parallel 3-port junctions in WDF theory:

a) Write the equations governing the Kirchhoff port variables of a parallel 3-port and derive the corresponding equations in the Wave Digital domain, reflected waves as a function of the incident waves.

b) In order to turn the resulting WD junction into an adaptor, what do you need to do? What are the conditions for that to happen? Why do you need adaptors? (2021-07-13)


A:


== 2

Q: Briefly explain how to model a circuit using WDF, when the circuit has a resistive nonlinearity. How do you derive the nonlinearity in the wave digital domain starting from its Kirchhoff description? And how does this wave description of the nonlinearity depend on the rest of the circuit? If you prefer, you can discuss the specific case of a simple RLC circuit, all elements connected in series, with a nonlinear resistor. (unknown)


A:



