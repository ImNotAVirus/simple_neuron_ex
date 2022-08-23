Code.require_file("_neuron.exs")

## Logical AND Constants
inputs = [
  [0.0, 0.0],
  [0.0, 1.0],
  [1.0, 0.0],
  [1.0, 1.0]
]

outputs = [0.0, 1.0, 1.0, 1.0]

## Code
input_size = inputs |> Enum.at(0) |> length()
neuron = Neuron.new(input_size)

# Print before learning
IO.puts("Before learning:")
Neuron.debug(neuron, inputs)
IO.puts("")

# Learning (50 iteration for each input)
trained_neuron = Neuron.train(neuron, inputs, outputs)

# Print after learning
IO.puts("After learning:")
Neuron.debug(trained_neuron, inputs)
