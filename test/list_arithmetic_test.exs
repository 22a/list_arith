defmodule ListArithmeticTest do
  use ExUnit.Case, async: true
  doctest ListArithmetic

  describe "ListArithmetic.inc/1" do
    test "simple single digit increment" do
      assert ListArithmetic.inc([1]) == [2]
    end

    test "simple negative single digit increment" do
      assert ListArithmetic.inc([-2]) == [-1]
    end

    test "overflow single digit increment" do
      assert ListArithmetic.inc([9]) == [1,0]
    end

    test "overflow negative single digit increment" do
      assert ListArithmetic.inc([-1,0]) == [-9]
    end

    test "zero increment" do
      assert ListArithmetic.inc([0]) == [1]
    end

    test "negative 1 to zero increment" do
      assert ListArithmetic.inc([-1]) == [0]
    end

    test "more complex full cascade" do
      assert ListArithmetic.inc([9,9,9,9,9]) == [1,0,0,0,0,0]
    end

    test "more complex partial cascade" do
      assert ListArithmetic.inc([9,9,5,9,9]) == [9,9,6,0,0]
    end
  end

  describe "ListArithmetic.inc/2" do
    test "simple single digit increment" do
      assert ListArithmetic.inc([1], 3) == [2]
    end

    test "simple negative single digit increment" do
      assert ListArithmetic.inc([-2], 3) == [-1]
    end

    test "base 3 overflow single digit increment" do
      assert ListArithmetic.inc([2], 3) == [1,0]
    end

    test "base 5 overflow negative single digit increment" do
      assert ListArithmetic.inc([-1,0], 5) == [-4]
    end

    test "base 5 zero increment" do
      assert ListArithmetic.inc([0], 5) == [1]
    end

    test "base 4 negative 1 to zero increment" do
      assert ListArithmetic.inc([-1], 4) == [0]
    end

    test "more complex full cascade in base 9" do
      assert ListArithmetic.inc([8,8,8,8,8], 9) == [1,0,0,0,0,0]
    end

    test "more complex partial cascade in base 8" do
      assert ListArithmetic.inc([7,7,5,7,7], 8) == [7,7,6,0,0]
    end

    test "incompatible base (too low)" do
      assert_raise FunctionClauseError, fn ->
        ListArithmetic.inc([2], 1)
      end
    end

    test "incompatible base (too high)" do
      assert_raise FunctionClauseError, fn ->
        ListArithmetic.inc([2], 64)
      end
    end
  end
end
