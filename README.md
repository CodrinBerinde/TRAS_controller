# TRAS Nonlinear Controller

A nonlinear controller for the Twin Rotor Aerodynamical System, by **Berinde Codrin** and **Daisa Petru**.

Technical University of Cluj-Napoca, Faculty of Automation and Computer Science
Automation and Applied Informatics, year 3 · Control Engineering 2 · June 2026
Coordinating professors: Cristina Mureșan, Marcian Mihai

> **This page is only the opening of the story.** The project lives in the documentation, which has the model, the proofs, the controller design and the results on the real device: **[TRAS_Nonlinear_Controller.pdf](TRAS_Nonlinear_Controller.pdf)**. If you are here, you should read that.

---

## What this is

A one-semester project, done by two students, for what we consider one of the most relevant (and, some of us would say, most beautiful) subjects in our field: control engineering.

The lab had several devices available for projects. We picked the TRAS because it is a multiple-input-multiple-output, highly nonlinear system, which is to say, not an easy one. The job was to do the physical modeling, the identification, and finally, the real goal, a discrete controller for it.

## The device

The TRAS is an educational robot made by INTECO Krakow, controlled in real time from Matlab & Simulink. It has a fixed support with a mobile arm attached at an articulation point. There is a rotor at each end of the arm: the main rotor and the tail rotor.

The articulation is really two rotations that can happen at the same time. The arm can swing about the vertical axis (the *azimuth* angle) and it can tilt about a horizontal axis that turns along with it (the *pitch* angle). To a first approximation the main rotor handles the tilt and the tail rotor handles the swing. A sliding counterbalance on a small perpendicular arm sets the gravitational torque.

The device measures pitch, azimuth and the speed of both rotors every 10 ms. The only things we can command are the two rotor voltages, applied as a PWM signal. The goal is to make the pitch and azimuth follow a reference.

## What's in the documentation

- A physical model of the arm in both planes, with the simplifications we made and the one we most regret (the coupling between the two motions)
- Grey box identification of the rotors and the gravity parameters
- A controller built with feedback linearization, as a nested structure: an inner loop for the rotors and an outer loop for the angles
- A proof of why the controller needs its own integrator even though the linearized process already has one
- Tests on the real device: step to zero, flicking the arm with a hand, and tracing circles in space with the tip of the arm

## Code

The Matlab & Simulink project is in this repository. The Simulink diagram mirrors the controller structure from the documentation almost block for block, so the documentation is the best guide to it.

---

For all the details, **please read the documentation**: [TRAS_Nonlinear_Controller.pdf](TRAS_Nonlinear_Controller.pdf).
