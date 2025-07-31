UART VLSI Project


This project implements a **UART (Universal Asynchronous Receiver Transmitter)** in Verilog HDL, targeting FPGA or ASIC synthesis and simulation. It includes waveform generation for testing and debugging.

---

## 🧠 Project Description

UART is a serial communication protocol widely used for interfacing peripherals in embedded and VLSI systems. This project focuses on:

- RTL Design of UART Transmitter and Receiver
- Testbenches for simulation
- Waveform output (`waveform.vcd`) for verification

---

## 📁 Project Structure

```

uart-vlsi-project/
│
├── uart\_tx.v          # UART Transmitter module
├── uart\_rx.v          # UART Receiver module
├── uart\_top.v         # Top module combining TX and RX
├── uart\_tb.v          # Testbench for simulation
├── waveform.vcd       # (Generated during simulation - large file, not pushed to GitHub)
├── README.md          # Project documentation
├── .gitignore         # Ignoring large files like .vcd
└── LICENSE            # (Optional) Open-source license

````

---

## ⚙️ How to Run

### 1. Using Icarus Verilog + GTKWave:
```bash
iverilog -o uart_tb uart_tb.v uart_tx.v uart_rx.v uart_top.v
vvp uart_tb
gtkwave waveform.vcd
````

Make sure to install:

* [Icarus Verilog](http://iverilog.icarus.com/)
* [GTKWave](http://gtkwave.sourceforge.net/)

---

## ❗ Note

> `waveform.vcd` is over 100MB and **not tracked** by Git due to GitHub's file size limit. You must generate it locally using the testbench.

---

## ✅ To-Do

* [ ] Parameterize baud rate and clock
* [ ] Add parity bit support
* [ ] FPGA synthesis constraints

---

## 🧑‍💻 Author

* [Your Name](https://github.com/yourusername)

---

## 📄 License

This project is open-source under the MIT License – see the [LICENSE](LICENSE) file for details.

```

---

Let me know if you want a version tailored for a **university submission**, **GitHub Pages**, or **professional resume use**.
```
