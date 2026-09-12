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
  #align(center)[DAAP exams]
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

本笔记为非官方的 DAAP 课程考试题目整理，仅供学习与复习参考。题目来自米兰理工大学（Politecnico di Milano）《Sound analysis, synthesis and processing》课程模块 Digital audio analysis and processing 的历年考试，并按课程主题归类编排；目前尽可能收录了自 2022 年以来的试卷内容。

答案均为个人整理与撰写，可能存在错误或遗漏；如与课程讲义、教师说明或当年试题不一致，请以官方资料为准。

自 2026 年 7 月起，试题风格出现较大变化，考察知识点改变且计算类题目明显增多。因此，本笔记另完整收录了 2026 年 7 月和 9 月两套试卷（未附答案），供复习时参考。

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


= STFT, vocoder

== 1


Q: You want to analyze the sound of a saxophone using a Short-Time analysis scheme (STFT). Your goal is to localize and extract the spectral lines, and track them over time. Knowing that the frequency of the lowest note of a tenor sax is approximately 2/3 of that of an alto sax, of the two instruments which one will be more computationally demanding for this application and why? In particular, if M is the length of the window used for the alto sax, how long will the same window need to be in the case of the tenor sax and why? Does a similar reasoning apply to the accuracy of peak localization? Please explain why. (2023-06-26)


A:



The *tenor saxophone* is more computationally demanding.

For a harmonic instrument, adjacent harmonics are spaced by the fundamental frequency $f_0$. To resolve the spectral lines, the STFT window must be long enough so that the window main lobe is narrower than this spacing. The resolution condition is

$
  M >= (L F_s) / f_0
$

where $L$ depends on the chosen window type.

Since the lowest note of the tenor sax is approximately

$
  f_(0,\ "tenor") = 2/3 f_(0,\ "alto"),
$

the required window length is

$
  M_"tenor"
  = (L F_s) / f_(0,\ "tenor")
  = (L F_s) / ((2/3) f_(0,\ "alto"))
  = 3/2 (L F_s) / f_(0,\ "alto")
  = 3/2 M.
$

Therefore, if the alto sax uses a window of length $M$, the tenor sax needs a window of length

$
  M_"tenor" = 3/2 M.
$

Thus, the tenor sax is more computationally demanding because each STFT frame requires a longer window and usually a longer FFT.

The same reasoning does *not* directly apply to peak localization accuracy. Resolution of nearby spectral lines depends mainly on the window length and the main-lobe width. Peak localization accuracy depends more on the FFT frequency grid and interpolation methods, such as zero-padding or parabolic interpolation. Therefore, the tenor sax needs a longer window to resolve its harmonics, but peak localization accuracy can be improved without necessarily increasing the physical window length by the same factor.

== 2


Q: Briefly describe how the phase vocoder works and explain how to obtain the control signals from the outputs of the filters that form the analysis filterbank. (2023-06-26)


A:

A *phase vocoder* is an analysis/synthesis system based on a filterbank. The input signal is decomposed into narrow frequency subbands. For each subband, the system estimates time-varying sinusoidal parameters, mainly amplitude and phase or instantaneous frequency. These parameters are then used as control signals to drive a bank of oscillators for resynthesis.

For the $k$-th analysis channel, assuming there is at most one sinusoid in the subband, the filter output can be modeled as

$
  x_k (t) = a_k (t) cos(omega_k t + phi_k (t)),
$

where $omega_k$ is the center frequency of the channel, $a_k(t)$ is the amplitude envelope, and $phi_k(t)$ is the phase modulation.

To obtain the control signals, we first compute the analytic signal of the filter output, for example using the Hilbert transform:

$
  x_k^a (t) = a_k (t) e^(j(omega_k t + phi_k (t))).
$

The amplitude control signal is obtained from the magnitude:

$
  a_k (t) = abs(x_k^a (t)).
$

The phase control signal can be obtained from the phase of the analytic signal:

$
  phi_k (t) = angle(x_k^a (t)) - omega_k t.
$

In practice, the phase vocoder usually uses the instantaneous frequency deviation instead of the phase itself:

$
  Delta omega_k (t) = d/(d t) phi_k (t).
$

Using the baseband equivalent signal

$
  x_k^m (t) = x(t) + j y(t),
$

the instantaneous frequency deviation can be computed as

$
  Delta omega_k (t)
  = (x dot(y) - y dot(x)) / (x^2 + y^2).
$

Thus, each analysis filter produces two main control signals:

$
  a_k (t)
$

and

$
  omega_k + Delta omega_k (t).
$

These control the amplitude and frequency of the corresponding oscillator in the synthesis bank.

== 3


Q: Explain how the Short-Time Fourier Transform (STFT) can be interpreted as a filterbank. Describe the relationship that exists between the window of the STFT and the frequency response of the filters in the equivalent filterbank. (2022-06-24)


A:

The *Short-Time Fourier Transform (STFT)* can be interpreted as a *filterbank* because each STFT frequency bin measures the output of a bandpass filter centered at a different frequency.

In the STFT, the signal is first multiplied by a time-shifted window and then transformed by the Fourier transform:

$
  X_m(omega) = sum_n x(n) w(n - m) e^(-j omega n).
$

For a discrete frequency bin $omega_k$, this becomes

$
  X_m(omega_k) = sum_n x(n) w(n - m) e^(-j omega_k n).
$

This can be viewed as filtering the input signal with a filter whose impulse response is related to the analysis window modulated by a complex exponential. Therefore, each STFT bin corresponds to one filter in an equivalent analysis filterbank.

The relationship between the STFT window and the filter frequency response is that the Fourier transform of the window determines the shape of each filter. The filter centered at frequency $omega_k$ has a frequency response equal to the window spectrum shifted to $omega_k$:

$
  H_k(omega) = W(omega - omega_k).
$

Thus, the same window produces all the filters in the filterbank; each filter is just a frequency-shifted version of the window spectrum.

This means that the choice of window controls the properties of the equivalent filterbank. A longer window gives narrower filters and better frequency resolution, but poorer time resolution. A shorter window gives wider filters and better time resolution, but poorer frequency resolution. Therefore, in the STFT filterbank interpretation, time resolution and frequency resolution are conflicting requirements.
== 4


Q: Describe (with formulas) how the phase vocoder works and explain how to obtain the control signals from the output of the filters that form the analysis filterbank. (2022-06-24)


A:

== 5


Q: Describe the difference between the concepts of resolution, accuracy in spectral peak estimation (magnitude and frequency) for the sinusoidal analysis based on Short-Time Fourier Transform. Which parameters of the system (window length, window shape, FFT length) affect what, and why? (2022-02-11)


A:

*Resolution* is the ability to separate two close sinusoidal peaks. It mainly depends on the main-lobe width of the STFT window:

$
  B_w = (L F_s) / M.
$

Two peaks separated by $Delta f$ are resolved if

$
  B_w <= Delta f,
$

so

$
  M >= (L F_s) / Delta f.
$

Thus, increasing the window length $M$ improves frequency resolution. The window shape also matters: different windows have different values of $L$ and different side-lobe levels.

*Accuracy* is how close the estimated peak frequency and magnitude are to the true values. It mainly depends on the FFT sampling grid. If the FFT length is $N$, the bin spacing is

$
  F_s / N,
$

so the peak frequency error can be about

$
  plus.minus F_s / (2 N).
$

Increasing $N$ by zero-padding improves peak localization accuracy, but it does *not* improve true resolution, because the window main lobe is unchanged.

Magnitude accuracy is also improved by zero-padding or parabolic interpolation, because the sampled FFT bins get closer to the true maximum of the peak.

In short:

$
  M -> "resolution"
$

$
  "window shape" -> "main-lobe width and side-lobe level"
$

$
  N -> "peak estimation accuracy"
$


== 6


Q: Short-Time Fourier Transform (STFT)

a) Define and describe the STFT and explain how to use it in practice.

b) Knowing that you need to analyze signals that can be considered as stationary within a window lasting 20ms, how would you select the window (shape and length) and the sampling frequency in order to guarantee resolving the partials of a harmonic sound whose fundamental is at 100Hz?

c) Explain the need of zero padding and oversampling. Knowing that you need to localize frequencies with an accuracy that is above our limits of perception, what oversampling factor would you choose? (2023-04-28)


A:

a) The *STFT* analyzes the local spectrum of a signal by applying a sliding window and computing an FFT for each frame:

$
  X_m (omega) = sum_n x(n) w(n - m) e^(-j omega n)
$

In practice, the signal is split into overlapping frames, multiplied by a window, and transformed with the FFT to obtain a time-frequency representation.

b) For a harmonic sound with

$
  f_0 = 100 " Hz",
$

the partial spacing is

$
  Delta f = 100 " Hz".
$

To resolve partials:

$
  B_w <= Delta f,
  quad B_w = (L F_s) / M.
$

Since the signal is stationary only for

$
  20 " ms",
$

we need

$
  M / F_s <= 0.02.
$

A rectangular window has $L = 2$, so it requires

$
  M >= (2 F_s) / 100 = 0.02 F_s.
$

Thus a *20 ms rectangular window* is suitable. Hamming or Blackman would need longer windows, so they would violate the 20 ms stationarity assumption.

Choose $F_s$ according to the highest partial to analyze:

$
  F_s >= 2 f_"max".
$

c) Zero padding increases the FFT length $N$, giving a denser frequency grid. It improves peak localization accuracy, but not true resolution.

The maximum frequency error is approximately

$
  epsilon_f = +- F_s / (2 N).
$

To be below perception threshold, require

$
  F_s / (2 N) <= "JND".
$

For $f_0 = 100 " Hz"$, take

$
  "JND" approx 3 " Hz".
$

So

$
  N >= F_s / 6.
$

With $F_s = 50 " kHz"$ and $M = 1000$, this gives

$
  N >= 8333,
  quad N / M approx 8.3.
$

So I would choose an oversampling factor of about *8 to 10*.

== 7


Q: Consider a pitch detection system based on the ability of resolving sinusoidal peaks. You want to estimate the pitch of a singer whose lower fundamental frequency is 150 Hz. Consider a sampling frequency of 48 kHz, and the possibility of using a rectangular (L=2) or a Hamming (L=4) window.

- Which is the minimum acceptable window length measured in samples?
- How long is this window in seconds?
- Which is the error (in Hz) introduced on peak localization using this window? (unknown)


A:

For a harmonic signal, the minimum spacing between partials is

$
  Delta f = f_0 = 150 " Hz".
$

The resolution condition is

$
  M >= (L F_s) / f_0 .
$

For the rectangular window, $L = 2$:

$
  M >= (2 dot 48000) / 150 = 640 " samples".
$

For the Hamming window, $L = 4$:

$
  M >= (4 dot 48000) / 150 = 1280 " samples".
$

The minimum acceptable choice is therefore the *rectangular window* with

$
  M = 640 " samples".
$

Its duration is

$
  T = M / F_s = 640 / 48000 = 0.0133 " s".
$

So the window is about

$
  13.3 " ms".
$

If the FFT length is equal to the window length, $N = M = 640$, the peak localization error is approximately

$
  epsilon_f = +- F_s / (2 N)
  = +- 48000 / (2 dot 640)
  = +- 37.5 " Hz".
$

Therefore, the minimum window length is $640$ samples, its duration is $13.3 " ms"$, and the peak localization error is about $+-37.5 " Hz"$.
== 8


Q: a) When designing a spectral analysis scheme through Short-Time Fourier Transform (STFT), what parameters do we act on in order to guarantee a sufficient peak localization accuracy? If the signal to analyze has a fundamental frequency of 200Hz and the window shape you can use is a triangular one, how long must the window be to guarantee resolving peaks in the spectral representation? Please justify your answer.

b) What oversampling factor would you choose in order to make sure that the peaks are localized with sufficient accuracy? Please explain how you proceed. (2022-04-29)


A:

a) For peak localization accuracy, we mainly act on the FFT length $N$, using zero-padding / oversampling, and possibly interpolation. The window length $M$ and window shape mainly affect spectral resolution.

For a harmonic signal,

$
  Delta f = f_0 = 200 " Hz".
$

To resolve peaks:

$
  B_w <= Delta f,
  quad B_w = (L F_s) / M.
$

For a triangular window, $L approx 4$, so

$
  M >= (4 F_s) / 200 = F_s / 50.
$

Equivalently, the window duration must be

$
  M / F_s >= 1 / 50 = 0.02 " s" = 20 " ms".
$

So the triangular window must be at least *20 ms* long.

b) The peak localization error is approximately

$
  epsilon_f = +- F_s / (2 N).
$

To make it smaller than the perceptual limit, we require

$
  F_s / (2 N) <= "JND".
$

For

$
  f_0 = 200 " Hz" < 600 " Hz",
$

the slides give

$
  "JND" = 3 " Hz".
$

Therefore,

$
  F_s / (2 N) <= 3
$

so

$
  N >= F_s / 6.
$

From part a), using a triangular window with $L = 4$:

$
  M >= (4 F_s) / 200 = F_s / 50.
$

Thus the oversampling factor must satisfy

$
  N / M >= (F_s / 6) / (F_s / 50)
  = 50 / 6
  approx 8.33.
$

So I would choose an oversampling factor larger than 8, for example *10* or the next convenient power-of-two FFT size.

= Scaling

== 1


Q: Describe how implement pitch scaling using a splicing-based method (in the time domain). (2023-06-26)



A:

A splicing-based pitch scaler works in the time domain by using a circular buffer of length $N$ . The input signal is written with a write index $i$ , which advances by one sample:

$ i <- (i + 1) mod N $

The output is read with a read index $j$ , which advances by a fractional pitch factor $alpha$ :

$ j <- (j + alpha) mod N $

If $alpha > 1$ , the read index moves faster than the write index, so the signal is read faster and the pitch increases. Some splices are repeated when $j$ passes $i$ .

If $alpha < 1$ , the read index moves slower, so the signal is read more slowly and the pitch decreases. Some splices are skipped when $i$ passes $j$ .

Because jumps between splices can create discontinuities, the splice boundaries are smoothed by overlapping the end of one segment with the beginning of the next and applying cross-fading. Interpolation is also needed because $j$ usually has fractional sample positions.

Thus, pitch scaling is obtained by changing the relative speed of reading and writing, while cross-fading reduces audible splice artifacts.

== 2


Q: Briefly describe in general terms the process of pitch scaling based on splicing. Specify, in particular, the differences between SOLA and PSOLA, and in which situations each one of them should be employed. (2022-06-24)


A:

Pitch scaling based on splicing divides the signal into short time-domain segments. To change pitch, segments are rearranged, repeated, or skipped, and then recombined by overlap-add with cross-fading to avoid clicks. By changing the spacing of the reconstructed segments, the apparent periodicity changes, hence the pitch changes.

SOLA chooses splice positions by waveform similarity. It shifts each segment until the overlap with the previous one has maximum correlation. It is general and can be used for many audio signals, especially when no reliable pitch marks are available, but it may also shift formants together with pitch.

PSOLA is pitch-synchronous. It assumes that pitch marks, such as glottal pulses in speech, are known. It extracts short windows centered on these marks and overlap-adds them at new positions. This changes the density of pitch periods while keeping the vocal-tract response almost unchanged, so formants are better preserved.

Therefore, SOLA should be used for generic quasi-periodic audio or when pitch marks are not available. PSOLA should be used mainly for voiced speech or monophonic signals with clear pitch marks, especially when preserving voice formants is important.
== 3


Q: Describe the duality principle that exists between time scaling and pitch scaling. Do so with the help of a block diagram, specifying the conditions of validity. (2022-04-29)


A:

#figure(
  image("media/duality.png", width: 100%),
)

The duality principle says that time scaling and pitch scaling can be obtained from each other by adding a time-warping, i.e. a resampling stage.


with the condition:

$ alpha(t) = (d T(t))/(d t) $



The idea is that the first stage changes the duration without changing the spectral components, while the inverse time warping restores the original time axis. The remaining effect is a scaling of the instantaneous frequencies by $alpha(t)$ .

For a constant factor $alpha$ , one can use:

$ T(t) = alpha t $

so that:

$ alpha = (d T)/(d t) $


== 4


Q: Explain what it means to apply time-scaling to an audio signal, highlighting the difference with respect to time-warping (or resampling). Consider a sinusoid at 1kHz that lasts 2 second, describe the signal you obtain by applying time scaling with factor 2. (unknown)

A:

Time-scaling means changing the temporal evolution, or duration, of an audio signal without changing its spectral components. Ideally, the sound becomes longer or shorter, but its pitch is preserved.

Time-warping, or resampling, is different: it directly stretches or compresses the time axis. Because time and frequency are linked, this also changes the frequencies. Slowing down by resampling lowers the pitch, while speeding up raises the pitch.

For example, consider a sinusoid:

$ x(t) = sin(2 pi 1000 t) $

lasting $2$ seconds. If ideal time-scaling with factor $2$ is applied, the output lasts $4$ seconds, but it is still a $1 "kHz"$ sinusoid:

$ y(t) = sin(2 pi 1000 t) $

for $0 <= t < 4$ .

If instead simple time-warping by factor $2$ were used, the signal would also last $4$ seconds, but the frequency would become $500 "Hz"$ . This is not ideal time-scaling, because the pitch changes.

== 5

Q: Define Pitch Scaling for periodic signals by writing, discussing and justifying the related formulation. (2023-04-28)


A:

For a periodic signal, pitch is related to the fundamental period $T_0$ , or equivalently to the fundamental frequency:

$ f_0 = 1 / T_0 $

A pitch scaling by factor $alpha$ means changing the fundamental frequency to:

$ f'_0 = alpha f_0 $

or, equivalently, changing the period to:

$ T'_0 = T_0 / alpha $

If the signal is written as a harmonic sum:

$ x(t) = sum_k A_k cos(2 pi k f_0 t + phi_k) $

then the ideal pitch-scaled signal is:

$ y(t) = sum_k A_k cos(2 pi k alpha f_0 t + phi'_k) $

Thus all harmonic frequencies are multiplied by $alpha$ , while the amplitudes $A_k$ are kept unchanged. If $alpha > 1$ , the pitch increases and the period becomes shorter. If $alpha < 1$ , the pitch decreases and the period becomes longer.

This formulation is justified because, for periodic signals, pitch perception mainly depends on the repetition rate. Therefore changing the spacing between periods changes the perceived pitch. In practice, methods such as PSOLA implement this by extracting short segments around pitch marks and overlap-adding them with a new spacing $T'_0$ .

== 6


Q: Explain how to implement Time Warping (resampling) in the frequency domain (using the STFT). Discuss an alternative method in the time domain and explain when it would be recommendable to opt for it instead of working in the frequency domain. (2022-02-11)


A:

Yes. In an STFT-based implementation, phase handling is essential.

After computing the STFT, the phase is known only modulo $2 pi$ , so phase unwrapping is needed to estimate the correct instantaneous frequency in each frequency bin. Then, after the time-warping/resampling mapping, the synthesis phase must be rebuilt by integrating these instantaneous frequencies along the new time axis.

Thus the procedure is:

$ x(t) -> "STFT analysis" -> |X(t_a, Omega_k)|, angle X(t_a, Omega_k) $

Then unwrap the phase to estimate $omega_k(t_a)$ . After frequency-axis scaling or time mapping, compute the new synthesis phase:

$ phi_k(t_s) = phi_k(t_s - Delta t_s) + omega_k(t_a) Delta t_s $

Finally, reconstruct the signal by inverse STFT and overlap-add.

Without phase unwrapping and phase reconstruction, adjacent STFT frames may have inconsistent phases, producing phase jumps and audible artifacts.

= Wiener filter and noise reduction

== 1


Q: Describe the Dolby noise reduction method in general terms, and its areas of application. Also describe Dolby from the perspective of Wiener filtering. (2023-06-26)


A:

Dolby is a noise-reduction coding method for reducing wideband tape hiss. Its
principle is similar to high-frequency pre-emphasis/de-emphasis:

- during recording, high frequencies are boosted, especially for weak sounds;
- during playback, the same frequencies are attenuated by the same amount, so
  the wanted signal is restored while the added hiss is reduced.

For loud sounds, where the SNR is already high, little or no reduction is
applied to avoid distortion and loss of fidelity. Dolby B gives up to about
10 dB high-frequency boost/reduction for weak sounds; Dolby C is essentially
two Dolby B systems in cascade and reduces white noise by about 20 dB.

Its application area is analog audio recording, especially magnetic
tape/cassette systems, where tape hiss and limited dynamic range are important
problems.

From the Wiener-filtering viewpoint, Dolby can be interpreted as a
signal-dependent spectral attenuation method. In background-noise removal, with

$
  x(n) = s(n) + v(n)
$

and uncorrelated signal and noise, the optimal Wiener filter is

$
  W(omega) = P_s(omega) / (P_s(omega) + P_v(omega)).
$

Thus frequencies dominated by noise are attenuated, while frequencies dominated
by the signal are left nearly unchanged. Dolby follows the same qualitative
idea in the high-frequency band: weak/high-noise components are treated more
strongly, while loud/high-SNR components are preserved.
== 2


Q: List the differences between the Steepest descent and Least Mean Square (LMS) algorithms for iteratively solving the Wiener-Hopf equations. Focus on the main pros and cons of both methods. (2022-06-24)


A:

The Wiener-Hopf equations define the optimum filter coefficients by
$ bold(R) bold(w)_o = bold(p) $. Iterative methods avoid the direct matrix
inversion $ bold(w)_o = bold(R)^(-1) bold(p) $.

#table(
  columns: (1fr, 1fr, 1fr),
  [Aspect], [Steepest descent], [LMS],
  [Gradient],
  [Uses the true gradient of the MSE surface, e.g. $ nabla J = 2 bold(R) bold(w) - 2 bold(p) $.],
  [Uses an instantaneous estimate of the gradient from the current samples $ bold(u)(n) $ and $ e(n) $.],

  [Statistics],
  [Requires knowledge or estimation of $ bold(R) $ and $ bold(p) $.],
  [Does not explicitly require $ bold(R) $ and $ bold(p) $; it updates directly from data.],

  [Update principle],
  [Moves the coefficients in the direction of the negative gradient of the error-performance surface.],
  [Implements the same idea adaptively, typically after computing $ y(n) $ and $ e(n) $.],

  [Main advantage],
  [More deterministic and directly linked to the exact MSE surface; convergence is toward the Wiener solution if the statistics are correct.],
  [Simple, practical, and suitable when signal statistics are unknown or time-varying.],

  [Main drawback],
  [Needs second-order statistics, so it is less practical for adaptive real-time filtering.],
  [Gradient is noisy because it is sample-based; convergence fluctuates around the optimum and depends on the step size.],
)

In summary, steepest descent is closer to the exact solution of the Wiener-Hopf system but requires statistical knowledge; LMS is an approximation that sacrifices exactness for simplicity and adaptivity.


== 3


Q: Describe how to incorporate Wiener Filter principles (in the frequency domain) into an adaptive scheme (Short-Time Spectral Attenuation). Do so with the help of a diagram and comment the various components. (2023-04-28)



A:

#figure(
  image("media/ST Spectrum Attenuation.png", width: 100%),
)

For background noise removal, the observed signal is modeled as

$
  x(n) = s(n) + v(n),
$

where $s(n)$ is the target signal and $v(n)$ is additive noise. The
assumptions are that $s(n)$ and $v(n)$ are independent, and that an estimate
of the noise power spectrum $P_v(omega)$ is available.

In the frequency domain, the Wiener solution is obtained from the Wiener-Hopf
equation:

$
  W(omega) = P_"sx"(omega) / P_x(omega).
$

Since $s(n)$ and $v(n)$ are uncorrelated:

$
  P_"sx"(omega) = P_s(omega)
$

and

$
  P_x(omega) = P_s(omega) + P_v(omega).
$

Therefore:

$
  W(omega) = P_s(omega) / (P_s(omega) + P_v(omega)).
$

This can be incorporated in an adaptive short-time scheme by estimating the
spectra frame by frame:

= LPC and audio restoration

== 1


Q: You need to restore an audio signal exhibiting occasional noise bursts (click-like disturbances) of duration 20 to 50 samples and stationary background noise (hissing noise). Describe, with the help of a block diagram, the whole restoration process, and make sure you specify the order of the individual blocks. Briefly describe the various blocks and offer a synthetic description of how you would estimate the involved parameters and filters. (2022-06-24)


A:


The clean signal is modeled locally as an AR/LPC process:

$
  s(n) = sum_(k = 1)^P a_k s(n - k) + e(n),
$

where $e(n)$ is white Gaussian innovation. The observed signal $x(n)$ contains
localized corrupted samples, described by the indicator $i(n)$.

Block diagram:

#figure(
  image("media/click restoration.png", width: 100%),
)


The restoration is iterative. Starting from an initial mask $i(n)$, estimate
the AR parameters $a_k$ from the samples considered clean, by ML/least-squares
minimization of the prediction error. Then, using these parameters, apply the
prediction-error filter

$
  A(z) = 1 - sum_(k = 1)^P a_k z^(-k)
$

to emphasize unpredictable click bursts and suppress the predictable audio
component. Threshold the residual to update $i(n)$ and group detected samples
into bursts of about $20$--$50$ samples.

Repeat parameter estimation and detection until $a_k$ and $i(n)$ no longer
change significantly. Finally, reconstruct the corrupted intervals by LSAR
interpolation: treat the detected samples as unknowns and choose them so as to
minimize the AR prediction-error energy over the whole block, using the known
samples before and after the gap.

The stationary hiss is handled as part of the innovation/background noise level
when estimating the model; the localized bursts are restored by the AR
detection and gap-filling chain.
== 2


Q: Define the "shaping", "whitening" and "prediction" filters, describe how they are related to one another and discuss their role in the context of infinite memory Linear Predictive Coding (LPC). (2022-02-11)


A:

In LPC, the current sample is predicted from past samples:

$
  hat(s)(n) = sum_(k = 1)^p a_k s(n - k),
$

with prediction error

$
  e(n) = s(n) - hat(s)(n).
$

The *prediction filter* is

$
  P(z) = sum_(k = 1)^p a_k z^(-k),
$

so that

$
  hat(S)(z) = P(z) S(z).
$

The *whitening* or *inverse filter* is

$
  A(z) = 1 - P(z) = 1 - sum_(k = 1)^p a_k z^(-k).
$

It produces the residual:

$
  E(z) = A(z) S(z).
$

The *shaping* or *forward filter* is the inverse of the whitening filter:

$
  H(z) = 1 / A(z),
$

so that

$
  S(z) = H(z) E(z).
$

Thus, the three filters are directly related:

$
  A(z) = 1 - P(z)
$

and

$
  H(z) = 1 / A(z).
$

The prediction filter estimates the predictable part of the signal, the
whitening filter removes this predictable/correlated part and leaves the error
signal, and the shaping filter reconstructs a signal with the same spectral
shape from the residual.

In infinite-memory LPC, the predictor uses all past samples. By the
orthogonality principle, the optimum prediction error is uncorrelated with all
past samples, and its autocorrelation becomes a Dirac delta; therefore the
residual is white noise. In this case, $A(z)$ is a true whitening filter and
contains all correlation/spectral-envelope information of $s(n)$. Feeding white
noise with the same variance into $H(z) = 1 / A(z)$ produces a signal with the
same power spectrum as the original.

== 3


Q: Discuss the power spectrum matching property of Linear Predictive Coding (LPC). In particular, the role of the memory of the linear prediction. Can the resulting LPC spectrum be considered a good spectral envelope estimator? Motivate your answer. (2022-02-11)


A:

In LPC, the signal is modeled through the all-pole shaping filter

$
  H(z) = 1 / A(z),
  quad
  A(z) = 1 - sum_(k = 1)^p a_k z^(-k).
$

The LPC spectrum is therefore

$
  abs(S_"LPC" (e^(j omega)))^2 =
  abs(H(e^(j omega)))^2 D_p,
$

where $D_p$ is the prediction-error variance.

For infinite-memory linear prediction, the predictor uses all past samples. By
the orthogonality principle, the optimum prediction error has autocorrelation
equal to a Dirac delta, hence it is white. Therefore all correlation
information of the signal is contained in $A(z)$, and the original power
spectrum can be exactly reconstructed from the shaping filter and the error
variance.

For finite prediction order $p$, the error is only flattened, not perfectly
white. Increasing $p$ monotonically decreases the mean-square prediction error,
so the LPC spectrum matches the signal power spectrum more closely as $p$
grows.

Using Parseval,

$
  epsilon_n =
  1 / (2 pi) integral_(-pi)^pi
  abs(S_n(e^(j omega)))^2 / abs(H_n(e^(j omega)))^2 dif omega.
$

Thus LPC minimizes a weighted spectral mismatch. Frequencies where the signal
spectrum is large contribute more to the error, so LPC fits spectral peaks
better than spectral valleys.

Hence the LPC spectrum can be considered a good spectral envelope estimator,
because an envelope should mainly track the peaks/formants rather than the fine
valleys. However, the order $p$ must be chosen properly: small $p$ gives a
smoother envelope, while large $p$ also starts fitting valleys and fine
spectral structure.

== 4


Q: Describe the idea behind Linear Predictive Coding (LPC) and formulate it in terms of a Wiener filtering problem with the help of a block diagram. Highlight the main modifications required to the classical Wiener filter scheme. (2023-04-28)


A:

#figure(
  image("media/Wiener LPC.png", width: 100%),
)


LPC assumes that a sample of a discrete-time signal can be approximated by a
linear combination of its past samples:

$
  hat(s)(n) = sum_(k = 1)^p a_k s(n - k),
$

so the prediction error is

$
  e(n) = s(n) - hat(s)(n)
  = s(n) - sum_(k = 1)^p a_k s(n - k).
$

The goal is to find the predictor coefficients $a_k$ that minimize the
mean-squared prediction error:

$
  min_(a_k) E abs(s(n) - hat(s)(n))^2.
$

This can be formulated as a Wiener filtering problem:

$
  [s(n - 1), s(n - 2), ..., s(n - p)]
  arrow.r
  [W(z) = sum_(k = 0)^(p - 1) a_(k + 1) z^(-k)]
  arrow.r
  hat(s)(n)
$

$
  e(n) = s(n) - hat(s)(n).
$

The desired response is the current sample $s(n)$, while the filter input is
made of past samples of the same signal. Therefore, unlike the classical Wiener
scheme, the input and desired response are not two different signals: the
signal $s(n)$ provides both the data to the filter and the desired output. The
identified Wiener filter is not a generic filtering system, but the prediction
filter whose coefficients are the LPC parameters.

With the autocorrelation

$
  r(i) = E(s(n) s(n - i)),
$

the Wiener-Hopf equations become

$
  sum_(k = 1)^p a_k r(i - k) = r(i),
  quad i = 1, 2, ..., p.
$

Thus the cross-correlation needed by the Wiener filter coincides with the
autocorrelation of $s(n)$. For non-stationary signals, LPC is applied on
short-time frames, where the signal is assumed approximately stationary.
== 5


Q: Describe the general characteristics of disturbances such as scratches or crackles on audio recordings coming from vinyl records. How do you use AR modeling for detecting and localizing such disturbances? Please describe with the help of a block diagram the general scheme, and how to select the relative threshold. (2022-04-29)


A:

Disturbances from vinyl records are #emph[local degradations]:
finite-duration defects at random positions, affecting only localized samples.
They are perceived as ticks, scratches and crackles. Crackling is a
high-density sequence of small, closely spaced impulses due to material
granularity; scratches are more localized impulses with a steep transient
followed by mechanical oscillation. Click bursts may last about 1--200 samples
at 44.1 kHz, with very variable amplitude; most samples remain undegraded.

A common additive model is

$
  x(n) = s(n) + i(n) v(n),
$

where $s(n)$ is the clean audio, $v(n)$ the localized disturbance, and $i(n) in {0,1}$ indicates corrupted samples.

Detection using AR modeling assumes that, over a short frame, $s(n)$ is a
stationary AR process:

$
  s(n) = sum_(k = 1)^P a_k s(n - k) + e(n).
$

Apply the prediction-error filter

$
  H(z) = 1 - sum_(k = 1)^P a_k z^(-k)
$

to the corrupted signal:

$
  e_d(n) = x(n) - sum_(k = 1)^P a_k x(n - k).
$

The predictable musical component is reduced, while localized noise-like clicks
are emphasized. A block scheme is:

$
  x(n)
  arrow.r
  ["AR prediction-error filter " H(z)]
  arrow.r
  e_d(n)
  arrow.r
  ["threshold"]
  arrow.r
  hat(i)(n).
$

The decision rule is

$
  hat(i)(n) =
  cases(
    1, abs(e_d(n)) > k sigma_e,
    0, abs(e_d(n)) <= k sigma_e,
  )
$

where $sigma_e^2$ is the AR innovation variance. The relative threshold $k$ is
chosen from the peak magnitudes and the model order $P$: increasing $k$
reduces false positives but increases missed detections, while decreasing $k$
does the opposite. Since the AR filter spreads a click over about $P$ samples,
the threshold must account for this loss of temporal localization.
== 6


Q: Linear Predictive Coding (LPC):

a) Describe how LPC can be used for speech coding.

b) Briefly describe the LPC-based algorithms for both encoding and decoding, focus on the role of the shaping filter and the choice of the excitation signals used for the speech synthesis.

c) Why is such a model so effective for speech signal compression? (2022-04-29)


A:

`a)` LPC models speech by assuming that, in a short-time segment, each sample
is predictable from past samples:

$
  s_n(m) approx sum_(k = 1)^p a_k(n) s_n(m - k) + e_n(m).
$

Equivalently, speech is generated by a source-filter model:

$
  H_n(z) = 1 / A_n(z),
$

$
  A_n(z) = 1 - sum_(k = 1)^p a_k(n) z^(-k),
$

where $e_n(m)$ is the excitation source at the glottis and $H_n(z)$, the
all-pole shaping filter, represents the vocal tract.

`b)` Encoding:

$
  s_n(m)
  arrow.r
  ["LPC analysis"]
  arrow.r
  [a_k(n), G, "voiced/unvoiced decision"]
$

For each short segment, estimate the LPC coefficients by minimizing the
short-time prediction error, usually from the short-time autocorrelation and
the Wiener-Hopf equations. Instead of transmitting all samples, transmit the
LPC parameters, a gain/error variance, and information about the excitation.

Decoding / synthesis:

$
  e'_n(m)
  arrow.r
  ["times " G]
  arrow.r
  [H_n(z) = 1 / A_n(z)]
  arrow.r
  s'_n(m)
$

The decoder reconstructs speech by feeding an excitation $e'_n(m)$ into the
shaping filter. For voiced segments, use a train of pulses as excitation; for
unvoiced segments, use white noise. The shaping filter imposes the spectral
envelope/vocal-tract characteristics on this excitation.

`c)` The model is effective for compression because speech has strong
short-time predictability and can be represented by a parsimonious
source-filter model. Most correlation and spectral-envelope information is
stored in the LPC filter coefficients, while the excitation can be represented
very simply. Therefore only a small set of parameters per frame must be encoded
instead of the whole waveform.
== 7


Q: In the context of restoration of local degradations, describe how clicks can be detected using an autoregressive filter. (unknown)


A:
== 8


Q: Describe the source-filter interpretation of linear predictive coding (LPC) and define the three main filters that characterize LPC. How are the filters related to one another in the context of the infinite-memory LP? (unknown)


A:

LPC models a signal sample as a linear combination of its past samples plus an
excitation:

$
  s(n) = sum_(k = 1)^p a_k s(n - k) + G u(n).
$

Taking the z-transform gives the source-filter model

$
  S(z) = P(z) S(z) + G U(z),
$

$
  H(z) = frac(S(z), G U(z)) = frac(1, A(z)),
$

where the excitation source $u(n)$, scaled by $G$, is passed through an
all-pole shaping filter $H(z)$ to generate $s(n)$.

The three main LPC filters are:

$
  P(z) = sum_(k = 1)^p a_k z^(-k)
$

the prediction filter, producing

$
  hat(S)(z) = P(z) S(z).
$

$
  A(z) = 1 - sum_(k = 1)^p a_k z^(-k) = 1 - P(z)
$

the inverse or whitening filter, producing the prediction error

$
  E(z) = A(z) S(z).
$

$
  H(z) = frac(1, A(z))
$

the forward or shaping filter, reconstructing/shaping the signal as

$
  S(z) = H(z) E(z).
$

In infinite-memory linear prediction, the optimum prediction error is white:
its autocorrelation is a Dirac delta. Thus $A(z)$ is a true whitening filter
and extracts all correlation information of $s(n)$ into the filter. The shaping
filter $H(z) = 1 / A(z)$ is its inverse, so feeding the residual, or any white
noise with the same variance, into $H(z)$ produces a signal with the same
power spectrum. Hence:

$
  A(z) = 1 - P(z),
  quad H(z) = frac(1, A(z)),
$

$
  E(z) = A(z) S(z),
  quad S(z) = H(z) E(z).
$

= Microphone arrays

== 1


Q: Describe the narrow-band model employed by the spatial methods for DOA estimation. What further simplifying assumptions are required by those algorithms? (2023-06-26)


A:

The source is modeled as narrow-band around a known carrier $omega_c$:

$
  s(n) = alpha(n) cos(omega_c n + phi(n))
$

Using an $L$-sample STFT window and evaluating only at $omega = omega_c$, with
$alpha(n)$ and $phi(n)$ almost constant inside the window, the signal becomes the
complex base-band quantity

$
  s(t) := S_t (omega_c) approx alpha(t) e^(j phi(t)).
$

A propagation delay is therefore represented only as a phase rotation. For
microphone $k$:

$
  y_k (t) = H_k (omega_c) s(t) e^(-j omega_c tau_k) + e_k (t)
$

For one source, the array model is

$
  bold(y)(t) = bold(a)(theta) s(t) + bold(e)(t),
$

where $bold(a)(theta)$ collects the microphone responses and the
delay-dependent phase terms. With $N$ sources, linear propagation gives

$
  bold(y)(t) = bold(A) bold(s)(t) + bold(e)(t).
$

The further simplifying assumptions are:

- far-field sources, so wavefronts are planar and each source is described only by its DOA;
- sources and microphones lie on the same plane, giving a 2D geometry;
- no reverberation, no dispersion, and homogeneous propagation.

For the ULA model, microphones are identical, omnidirectional, uniformly
spaced, and the array is calibrated. Parametric methods additionally assume
known $N < M$, full-rank source covariance, spatially white i.i.d. sensor noise
with identical variance, noise uncorrelated with sources, and distinct
DOAs/spatial frequencies.

== 2


Q: We want to estimate the direction of arrival of a sound of known bandwidth using a Uniform Linear Array of microphones. What is the maximum distance between the microphones that we can use? Why? (2022-06-24)


A:

For a ULA, the maximum microphone spacing is

$
  d_"max" = lambda_"min" / 2 = c / (2 f_"max")
$

where $f_"max"$ is the highest frequency in the sound bandwidth and

$
  lambda_"min" = c / f_"max"
$

is the shortest wavelength.

Reason: the microphones sample the acoustic field in space. To avoid spatial
aliasing, the spatial frequency must satisfy

$
  abs(omega_s) <= pi.
$

Since

$
  omega_s = 2 pi (d sin theta) / lambda,
$

the worst case is $abs(sin theta) = 1$, giving

$
  d <= lambda / 2.
$

For a broadband sound, this condition must hold for the shortest wavelength,
hence for the highest frequency in the bandwidth.

== 3


Q: Given the single-source array model and the corresponding spatial filtering formulation, derive and describe the Delay-and-sum (DAS) beamformer algorithm for DOA estimation. Please, explicitly write the minimization problem involved, its solution, and the definition of the DAS pseudo-spectrum. (2022-02-11)


A:

From the single-source array model

$
  bold(y) (t) = bold(a)(theta) s(t) + bold(e) (t),
$

a spatial filter forms

$
  y_F (t) = bold(h)^H bold(y) (t).
$

For a target direction $theta$, DAS designs a spatial band-pass filter that
passes that direction undistorted:

$
  bold(h)^H (theta) bold(a)(theta) = 1.
$

Assuming spatially white input, i.e.

$
  bold(R) = bold(I)_M,
$

the filter is obtained from

$
  bold(h)(theta) = arg min_(bold(h)) bold(h)^H bold(h)
  quad "subject to" quad
  bold(h)^H (theta) bold(a)(theta) = 1.
$

The solution is

$
  bold(h)(theta)
  = (bold(a)(theta)) / (bold(a)^H (theta) bold(a)(theta))
  = (bold(a)(theta)) / M.
$

Thus DAS applies pure-delay weights that re-phase the microphone signals
according to the tested propagation delays: signals from $theta$ add
constructively, while other directions are attenuated.

The filtered output power is

$
  E abs(y_F (t))^2
  = bold(h)^H (theta) bold(R) bold(h)(theta)
  = (bold(a)^H (theta) bold(R) bold(a)(theta)) / M^2.
$

Using the sample covariance matrix $hat(bold(R))$, the DAS pseudo-spectrum is

$
  p(theta) = (bold(a)^H (theta) hat(bold(R)) bold(a)(theta)) / M^2,
  quad theta in [-pi/2, pi/2].
$

The DOA estimates are the directions corresponding to the highest peaks of
$p(theta)$.


== 4


Q: Explain why, when using parametric methods, we need the number of microphones to be larger than the number of sources. In addition, explain why we need to know the number of sources. (2022-02-11)


A:

Parametric methods use the covariance model

$
  R = A R_s A^H + sigma^2 I_M,
$

where $A$ is an $M times N$ propagation matrix. To separate the signal and
noise subspaces, $A$ must have full column rank:

$
  op("rank")(A) = N.
$

This requires

$
  N < M,
$

i.e. the number of microphones must be larger than the number of sources.
Otherwise, there is not enough spatial information to distinguish the $N$
propagation vectors and to obtain a non-empty noise subspace.

The number of sources $N$ must be known because the eigendecomposition of $R$
is split into two parts:

- the first $N$ eigenvectors form the signal subspace $U$;
- the remaining $M - N$ eigenvectors form the noise subspace $V$.

Methods such as MUSIC then use $V$ and estimate the DOAs as the $N$ highest
peaks of the pseudo-spectrum. Therefore, without knowing $N$, we cannot decide
how many eigenvectors correspond to sources and how many peaks/DOAs must be
selected.


== 5


Q: Describe a Uniform Linear Array (ULA) and sketch its configuration. Then, discuss how the problem of estimating the DOA of a narrow-band signal can be recast into a spatial frequency estimation problem. (2023-04-28)


A:

#figure(
  image("media/ULAmodel.png", width: 100%),
)

A Uniform Linear Array (ULA) is an array made of $M$ identical
omnidirectional microphones, uniformly spaced by a distance $d$ and placed on a
straight line. The first microphone is usually chosen as reference.

For a single narrow-band source with DOA $theta$, the delay at the $k$-th
microphone is

$
  tau_k = ((k - 1) d sin(theta)) / c,
  quad theta in [-pi/2, pi/2],
$

where $c$ is the speed of sound. Since the microphones are identical and
omnidirectional, the propagation vector becomes

$
  a(theta) = [
    1,
    e^(-j omega_c d sin(theta) / c),
    ...,
    e^(-j (M - 1) omega_c d sin(theta) / c),
  ]^T.
$

The terms of this vector are samples, along the array, of a complex sinusoid.
Therefore, the DOA estimation problem can be rewritten as the estimation of the
spatial frequency

$
  omega_s = omega_c (d sin(theta)) / c.
$

Thus, each DOA $theta$ corresponds to a spatial frequency $omega_s$.
Estimating the DOA of a narrow-band signal is therefore equivalent to
estimating the frequency of a complex sinusoid sampled in space by the
microphones.

== 6


Q: Discuss the spatial resolution of the delay-and-sum beamformer algorithm. In particular, explain how to choose the parameters of a Uniform Linear Array (ULA) in order to correctly resolve two signals impinging on the array from directions $theta_1$ and $theta_2$, respectively. (2023-04-28)


A:

The spatial resolution of the delay-and-sum beamformer is determined by the
width of the main lobe of its spatial response. A narrower main lobe gives
better capability to distinguish two close DOAs.

For a ULA with $M$ microphones and spacing $d$, the aperture is

$
  l = (M - 1) d
$

and the main-lobe width is approximately

$
  lambda / (l abs(cos theta)).
$

If two sources arrive from $theta_1$ and $theta_2$, with angular separation

$
  Delta theta = abs(theta_2 - theta_1),
$

then, around the frontal direction $theta approx 0 degree$, they can be
resolved by the DAS pseudo-spectrum only if

$
  Delta theta > lambda / l.
$

Equivalently, the ULA aperture should be chosen such that

$
  l > lambda / Delta theta,
$

that is,

$
  (M - 1) d > lambda / Delta theta.
$

At the same time, the microphone spacing must satisfy the anti-aliasing
condition

$
  d <= lambda / 2.
$

Therefore, to correctly resolve the two signals, one should use the largest
admissible spacing $d <= lambda / 2$ and choose enough microphones $M$ so that
the aperture is large enough. If the resolution condition is satisfied, the
pseudo-spectrum shows two distinct peaks at $theta_1$ and $theta_2$;
otherwise, only one peak appears between them, leading to inconsistent DOA
estimation.
== 7


Q: What is the difference between Delay-And-Sum beamformer and the Capon method for DOA estimation? Which are the pros and cons of both techniques? (2022-04-29)


A:

Delay-and-Sum (DAS) and Capon are both spatial filtering methods: for each
trial direction $theta$, they design weights $h(theta)$ such that the signal
from that direction is passed without distortion:

$
  h^H (theta) a(theta) = 1.
$

In DAS, the design assumes spatially white data, i.e.

$
  R = I_M,
$

and solves

$
  h(theta) = arg min_h h^H h
  quad "s.t." quad
  h^H (theta) a(theta) = 1,
$

whose solution is

$
  h(theta) = a(theta) / (a^H (theta) a(theta)) = a(theta) / M.
$

The DAS pseudo-spectrum is

$
  p(theta) = (a^H (theta) hat(R) a(theta)) / M^2.
$

Its weights are pure delays: the microphone signals are re-phased and summed,
producing constructive interference for the steered direction and destructive
interference for other directions.

In Capon, the minimization uses the actual data covariance matrix:

$
  h(theta) = arg min_h h^H R h
  quad "s.t." quad
  h^H (theta) a(theta) = 1,
$

with solution

$
  h(theta) = (R^(-1) a(theta)) / (a^H (theta) R^(-1) a(theta)).
$

The Capon pseudo-spectrum is

$
  p(theta) = 1 / (a^H (theta) hat(R)^(-1) a(theta)).
$

Thus, instead of attenuating energy uniformly from all possible directions,
Capon tries to attenuate the actual interfering sources present in the data.

Pros and cons:

- DAS is simple, data-independent, and its spatial response is easy to compute.
  However, its resolution is limited by the main-lobe width, which depends on
  the array aperture, and its performance is lower.
- Capon is adaptive, since its weights and spatial response depend on the
  covariance matrix. Its resolution is not fixed but data-dependent, and its
  performance is slightly superior to DAS. However, it relies on the sample
  covariance matrix and is therefore more data-dependent.
== 8


Q: Explain why, when using parametric methods, we need the number of microphones to be larger than the number of sources. In addition, explain why we need to know the number of sources. (2022-04-29)


A:
== 9


Q: Consider a uniform linear microphone array (ULA) localizing an acoustic source using delay and sum beamformer (DAS). The source is emitting a single tone at 2 kHz, compute the maximum distance between two consecutive microphones in the array in order to correctly localize the source. Explain how to localize the source using DAS, in particular, how the pseudospectrum is computed. Finally, explain the difference between DAS and the Capon method. (unknown)


A:

For a ULA, to avoid spatial aliasing the microphone spacing must satisfy

$
  d <= lambda / 2,
$

where

$
  lambda = c / f_c.
$

Since the slides use

$
  c approx 340 "m/s"
$

and the tone frequency is

$
  f_c = 2000 "Hz",
$

$
  lambda = 340 / 2000 = 0.17 "m"
$

so

$
  d_"max" = lambda / 2 = 0.085 "m" = 8.5 "cm".
$

For DAS, for each candidate direction $theta$, build the steering vector of the
ULA:

$
  a(theta) = [
    1,
    e^(-j omega_c d sin theta / c),
    ...,
    e^(-j (M - 1) omega_c d sin theta / c),
  ]^T.
$

DAS chooses weights that pass undistorted the target direction:

$
  h^H (theta) a(theta) = 1
$

and, assuming spatially white input

$
  R = I_M,
$

solves

$
  h(theta) = arg min_h h^H h
  quad "subject to" quad
  h^H a(theta) = 1.
$

The solution is

$
  h(theta) = a(theta) / (a^H (theta) a(theta)) = a(theta) / M.
$

The beamformer re-phases the microphone signals according to the propagation
delays: signals from direction $theta$ add constructively, while other
directions tend to interfere destructively. The DAS pseudo-spectrum is the
output power as a function of the scanned direction:

$
  p_"DAS"(theta) = (a^H (theta) hat(R) a(theta)) / M^2,
  quad theta in [-pi/2, pi/2],
$

where

$
  hat(R) = 1 / K sum_(t = 1)^K y(t) y^H (t)
$

is the sample covariance matrix. The source DOA is estimated as the direction
corresponding to the highest peak of $p_"DAS"(theta)$.

The difference with Capon is in the filter design. DAS assumes $R = I_M$, so
its weights do not depend on the data and attenuate all non-target directions
uniformly. Capon instead solves

$
  h(theta) = arg min_h h^H R h
  quad "subject to" quad
  h^H a(theta) = 1,
$

giving

$
  h(theta) = (R^(-1) a(theta)) / (a^H (theta) R^(-1) a(theta)).
$

Its pseudo-spectrum is

$
  p_"Capon"(theta) = 1 / (a^H (theta) hat(R)^(-1) a(theta)).
$

Thus Capon is data-dependent: it tries to attenuate the actual interfering sources impinging on the array. Its resolution is not constant but depends on the data, and its performance is slightly superior to DAS.

== 10


Q: Briefly describe the MUSIC (Multiple Signal Classification) method for the localization of sources based on microphone arrays. (2023-06-26)

A:


= 2026-09-08

== 1

Q: A monophonic flute note of duration $2.0 " s"$ is analyzed with Spectral Modeling Synthesis. The deterministic model is

$
  s(t) = sum_(r=1)^R A_r(t) cos(theta_r(t)) + e(t),
$

where the residual $e(t) = h_t * u(t)$ is modeled as filtered white noise, summarized per frame by a spectral envelope. The analysis uses a frame hop of $256$ samples at $F_s = 44.1 " kHz"$, the note is harmonic with fundamental $f_0 = 880 " Hz"$, and the analysis bandwidth extends to $22.05 " kHz"$.

(a) The deterministic part is stored as amplitude and frequency trajectories, one pair per partial. How many harmonic partials $R$ lie within the analysis band, and how many analysis frames cover the $2.0 " s"$ note?

(b) The player wants the note slowed to $3.0 " s"$ (a time-stretch factor of $1.5$) with no change in pitch. Explain, separately for the deterministic and the stochastic components, how SMS achieves this. Why is the residual handled with a random phase at resynthesis, and why would simply replaying the original samples slower fail?

(c) Contrast SMS with a plain phase vocoder for this task: give one signal feature of a flute note for which the sines+noise split gives SMS a clear advantage, and name the synthesis blocks the slides assign to each of the two SMS branches.


== 2

Q: A 2-tap noise canceller has $w(n) = mat(0.5; -0.2)$, step size $mu = 0.1$, current tap input $u(n) = mat(1; 2)$, and desired response $d(n) = 0.4$. Carry out one LMS iteration: (a) compute $y(n)$; (b) compute $e(n)$; (c) compute $w(n + 1)$.


== 3

Q: Write the ideal time-scaled signal $x'(t')$ in the sinusoidal model under a TWF $t' = T(t)$. Explain in words why the amplitude at time $t'$ is read from the original signal at $t = T^(-1)(t')$, and why the instantaneous frequency is unchanged.


== 4

Q: A signal has $r(0) = 1$, $r(1) = 0.5$, $r(2) = 0.25$. For $p = 2$: (a) write $R$ and $r$ and solve $R a = r$; (b) compute $D_p$ and $G_p$; (c) write the resulting inverse filter $A(z)$.


== 5

Q: Apply a length-3 median filter to

$
  x = {2, 80, 6, 3, 5, 4},
$

using boundary extension by repeating the end samples. Show all intermediate windows.


= 2026-07-23

== 1

Q: A recording of a sustained vocal duet is analyzed with the goal of separating the two singers’ fundamentals and estimating their frequencies accurately. The signal is sampled at $F_s = 48 " kHz"$. The two fundamentals lie close together, at approximately $f_1 = 196 " Hz"$ and $f_2 = 220 " Hz"$ (a musical interval of roughly a whole tone).

Part (a) — Resolution. You analyze the signal with a Hamming window (type $L = 4$). What is the minimum window length $M$ (in samples and in milliseconds) required to resolve the two fundamentals according to the main-lobe criterion $B_w <= Delta$? Repeat for a rectangular window ($L = 2$) and comment on the trade-off involved in the choice.

Part (b) — Localization accuracy via zero-padding. Suppose the just-noticeable difference (JND) that you want your frequency estimate to respect is $3 " Hz"$. Using the relation $Delta f = plus.minus F_s / (2 N)$ for the peak-localization error of a length-$N$ FFT, determine the minimum FFT length $N$ needed to bring the localization error within the JND. Compare $N$ to the window length $M$ found in part (a) for the Hamming case and state the resulting oversampling (zero-padding) factor. Briefly explain why resolution and localization accuracy are distinct problems requiring distinct remedies.


== 2

Q: Define time scaling and pitch scaling of an audio signal. For each, state precisely which characteristic of the signal is altered and which is preserved, and why the two are difficult to separate for a general signal.


== 3

Q: In the adaptive noise-cancellation scheme the primary input is a mixture of target signal plus interference, and a reference microphone captures the interference. (a) Identify what plays the role of $d(n)$ and of $u(n)$. (b) Explain, via the orthogonality principle, why the error signal $e(n)$ ends up containing the target signal rather than the noise.


== 4

Q: State precisely the optimization problem solved by the Wiener filter. In particular: (a) write the cost function $J$ being minimized; (b) explain why the criterion is called minimum mean-square error; and (c) explain why, for a stationary input, the optimal filter is linear and time-invariant.


== 5

Q: The data model assumes the sources lie in the far field. (a) State what this implies for the shape of the wavefronts reaching the array. (b) Explain why, under this assumption, each source is characterized by a single direction of arrival rather than a full position, and what other simplifications (geometry, propagation) accompany it.


