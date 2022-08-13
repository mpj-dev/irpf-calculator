###########################
# Tag segments:
#
# 0      -  12.450   -> 19%
# 12.450 -  20.200   -> 24%
# 20.200 -  35.200   -> 30%
# 35.200 -  60.000   -> 37%
# 60.000 - 300.000   -> 45%
# 300.000+           -> 47%
###########################

defmodule IRPFCalculator do
  alias IRPFCalculator.Segment

  @fake_infinity 999_999_999

  @segments [
    %Segment{min: 300_000, max: @fake_infinity, rate: 0.47},
    %Segment{min: 60_000, max: 300_000, rate: 0.45},
    %Segment{min: 35_200, max: 60_000, rate: 0.37},
    %Segment{min: 20_200, max: 35_200, rate: 0.30},
    %Segment{min: 12_450, max: 20_200, rate: 0.24},
    %Segment{min: 0, max: 12_450, rate: 0.19}
  ]

  def calc(amount) when is_binary(amount) do
    Float.parse(amount)
      |> elem(0)
      |> calc
  end

  def calc(amount) when not is_number(amount), do: calc(0)

  def calc(amount) when amount < 0, do: calc(0)

  def calc(amount), do: do_calc(amount, @segments)

  ####################
  # Private
  ####################

  defp do_calc(amount, [%Segment{} = s | segments]) when amount >= s.min do
    (amount - s.min) * s.rate + do_calc(s.min, segments)
  end

  defp do_calc(amount, [%Segment{} = s | segments])
    when amount < s.min and amount < s.max,
    do: do_calc(amount, segments)

  defp do_calc(amount, [%Segment{} = s | segments]) when amount < s.min do
    (s.max - s.min) * s.rate + do_calc(s.min, segments)
  end

  defp do_calc(_, []), do: 0
end
