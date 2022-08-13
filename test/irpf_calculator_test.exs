defmodule IRPFCalculatorTest do
  use ExUnit.Case

  describe "calc" do
    test "lowest segment" do
      assert IRPFCalculator.calc(0) == 0
      assert IRPFCalculator.calc(5_000) == 950
    end

    test "mid segments" do
      assert IRPFCalculator.calc(13_000) == 2497.5
      assert IRPFCalculator.calc(60_100) == 17_946.5
    end

    test "highest segment" do
      assert IRPFCalculator.calc(500_000) == 219_901.5
    end

    test "negative numbers" do
      assert IRPFCalculator.calc(-1) == 0
    end

    test "strings are parsed" do
      assert IRPFCalculator.calc("5000") == 950
    end
  end
end
