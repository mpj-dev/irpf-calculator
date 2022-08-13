defmodule IRPFCalculator.Segment do
  @enforce_keys [:min, :max, :rate]
  defstruct [:min, :max, :rate]
end
