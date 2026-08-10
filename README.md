# AVR Lab

This folder is for learning bare-metal AVR assembly with an Arduino Uno R3.

## Planned learning path

1. Write and assemble a tiny AVR program, then inspect the generated machine code and disassembly.
2. Later, compile the program, flash it to the Uno, and verify its behavior on the board.

The first stage is software-only. Hardware access and flashing will wait until explicitly requested.

## Project layout

Each experiment has its own folder under `projects/`. Build output is kept in
that project's `build/` directory.

Build the default blink project:

```sh
./compile
```

Build and flash it through a specific serial port:

```sh
./flash /dev/ttyACM0
```

Pass a source path to select a different project:

```sh
./compile projects/loop/loop.S
./flash /dev/ttyACM0 projects/loop/loop.S
```
