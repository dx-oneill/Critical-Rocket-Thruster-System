# Critical Rocket Thruster System (SPARK Ada)

This repository contains a safety-critical control system for regulating a rocket’s thrust and pressure, implemented in **SPARK Ada**. The project was developed as part of university coursework for CSC313 (Critical Systems), focusing on reliability, formal verification, and real-time control.


## Project Description

This project implements a **safety-critical control system** for regulating a rocket's thrust and internal pressure using **SPARK Ada**.

The thrust level is based on the rocket's altitude, ensuring optimal performance and stability during flight.  
It also continuously monitors internal system pressure. If the pressure exceeds a predefined safety threshold, the system automatically opens a valve to release excess pressure and prevent potential failure.

This dual functionality — **thrust regulation** and **pressure failsafe** — is vital to maintaining operational safety and mitigating the risk of catastrophic events during rocket operation.


## File Structure

- `src/` — All SPARK Ada source code (including runtime wrappers)
- `main.gpr` — GNAT project file for building

## Technologies

- SPARK Ada (formal verification with contracts)
- GNATprove (static analysis and proof)
- GNAT Community Edition
- Ada runtime components (Text_IO wrappers, integer I/O extensions)
