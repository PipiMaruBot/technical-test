# Technical Test: Entertainment #17 2026 March 13
**Name:** Albert González Álvarez / 
**Date:** 17/03/2026

## 1) What do you think the lead engineer is worried about?
- **Implementation:** Translating the algorithms between different enviroments, for example, it would be a problem if we lose that mathematic complexity while being integrated in a backend enviroment.
- **Robustness:** Ensure that the work is not only correct, but also efficient in order to perform multiple task like monitoring multiple satelites simultaniuously.
- **Team and time:** Poor hand-over can slow down the workflow and create bottlenecks during development.

## 2) What would be your recommendation to mitigate the risks he is worried about?
In order to ensure a fluid transition of the work to an operative envirement it would be nice to:
- **Validation process:** The algorithm is independent of commercial libraries in his final implementation.
- **Defining how the data is send:**
  - Define units.
  - Define reference systems ( ECEF, ECI, etc).
  - Text or binary data format like JSON.

## 3) What do you think are the responsibilities of each of the teams?
- **Team 1:** The objective is to guarantee the precision of the model developed. They are responsible for prototyping, design, and physical validation of the algorithms.
- **Team 2:** The objective is to ensure system robustness, real-time monitoring, handle unexpected errors and the  integration of the project. They are responsible for the implementation of the operational version.

## 4) What and how do you think that team 1 should provide the input to team 2?
To ensure the backend team can successfully implement an operational version of the project, Team 1 must provide:
- **Description Document:** Technical documentation where all the underlying logic, mathematical equations and flowcharts are explained.
- **Reference code in Octave:** Team 1 should provide a script that has been tested before in order to test results, also provide validation data with in and out examples ( for example: "With this sensor the algorith should have this exact result").



