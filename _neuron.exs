## Setup - Install Nx
Mix.install([{:nx, "~> 0.2"}])

## Neuron module
defmodule Neuron do
  alias __MODULE__

  defstruct weights: [], bias: 0.0, learning_rate: 0.05

  @type t :: %Neuron{
          weights: [Nx.Tensor.t()],
          bias: float,
          learning_rate: float
        }

  @type input :: [float, ...]
  @type inputs :: [input, ...]
  @type output :: float
  @type outputs :: [float, ...]

  @doc """
  Create a new Neuron
  """
  @spec new(pos_integer, float) :: t()
  def new(nb_inputs, learning_rate \\ 0.05) do
    %Neuron{
      weights: Nx.random_uniform({nb_inputs}),
      bias: Nx.tensor(:rand.uniform() - 0.5),
      learning_rate: learning_rate
    }
  end

  @doc """
  Activate the neuron and return the corresponding output
  """
  @spec activate(t(), input()) :: output()
  def activate(neuron, inputs) do
    do_activate(neuron, Nx.tensor(inputs))
  end

  @doc """
  Train a neuron
  """
  @spec train(t(), inputs(), outputs(), non_neg_integer) :: t()
  def train(neuron, inputs, outputs, max_iteration \\ 50) do
    inputs_size = length(inputs)

    Enum.reduce(1..max_iteration, neuron, fn _i, n ->
      Enum.reduce(0..(inputs_size - 1), n, fn i, n2 ->
        input = Enum.at(inputs, i)
        expected = Enum.at(outputs, i)

        learn(n2, input, expected)
      end)
    end)
  end

  @doc """
  Activate a neuron and print his outputs
  """
  @spec debug(t(), inputs()) :: :ok
  def debug(neuron, inputs) do
    inputs_size = length(inputs)

    Enum.each(0..(inputs_size - 1), fn i ->
      input = Enum.at(inputs, i)
      output = Neuron.activate(neuron, input)
      IO.puts("#{inspect(input)} > #{inspect(output)}")
    end)
  end

  ## Private functions

  defp do_activate(%Neuron{weights: weights, bias: bias}, inputs) do
    inputs
    |> Nx.dot(weights)
    |> Nx.add(bias)
    |> Nx.to_number()
    |> threshold()
  end

  defp learn(neuron, inputs_, expected_) do
    %Neuron{weights: weights, bias: bias, learning_rate: learning_rate} = neuron
    inputs = Nx.tensor(inputs_)
    expected = Nx.tensor(expected_)

    output = neuron |> do_activate(inputs) |> Nx.tensor()
    delta = Nx.subtract(expected, output)

    if Nx.to_number(delta) == 0.0 do
      neuron
    else
      new_weights =
        weights
        |> Nx.add(learning_rate)
        |> Nx.multiply(delta)
        |> Nx.multiply(inputs)

      new_bias =
        bias
        |> Nx.add(learning_rate)
        |> Nx.multiply(delta)

      %Neuron{neuron | weights: new_weights, bias: new_bias}
    end
  end

  ## Activation functions
  defp threshold(value) do
    if value > 0.5, do: 1.0, else: 0.0
  end
end
