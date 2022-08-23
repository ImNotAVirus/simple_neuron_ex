# Simple Neuron

This repo contains a simple Neuron written in Elixir using [Nx](https://github.com/elixir-nx/nx).

## Requirements

    - Elixir v1.13.3
    - Tested with OTP 24

## Usage

    > git clone https://github.com/ImNotAVirus/simple_neuron_ex
    > cd simple_neuron_ex

    > elixir elixir logical_and.exs
    Before learning:
    [0.0, 0.0] > 0.0
    [0.0, 1.0] > 0.0
    [1.0, 0.0] > 0.0
    [1.0, 1.0] > 0.0

    After learning:
    [0.0, 0.0] > 0.0
    [0.0, 1.0] > 0.0
    [1.0, 0.0] > 0.0
    [1.0, 1.0] > 1.0

    > elixir elixir logical_or.exs
    Before learning:
    [0.0, 0.0] > 0.0
    [0.0, 1.0] > 1.0
    [1.0, 0.0] > 0.0
    [1.0, 1.0] > 1.0

    After learning:
    [0.0, 0.0] > 0.0
    [0.0, 1.0] > 1.0
    [1.0, 0.0] > 1.0
    [1.0, 1.0] > 1.0

## Notes

The code is not very clean nor very optimized at the moment.
