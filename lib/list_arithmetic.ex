defmodule ListArithmetic do
  @moduledoc """
  Documentation for ListArithmetic.
  """

  @doc """
  Increment a base 10 digit list.

  ## Examples

      iex> ListArithmetic.inc([5])
      [6]
      iex> ListArithmetic.inc([-5])
      [-4]
      iex> ListArithmetic.inc([1,0])
      [1,1]
      iex> ListArithmetic.inc([1,9])
      [2,0]

  """
  def inc(list) do
    inc(list, 10)
  end

  @doc """
  Increment a digit list with base 2 .. 10.

  ## Examples

      iex> ListArithmetic.inc([5], 9)
      [6]
      iex> ListArithmetic.inc([-5], 8)
      [-4]
      iex> ListArithmetic.inc([3], 4)
      [1,0]
      iex> ListArithmetic.inc([1,7], 8)
      [2,0]

  """
  def inc(list, base) when (base in 2..10) do
    inc(list, base, 1)
  end

  defp inc(list, base, increment) do
    {is_negative, formatted_list} = decode_list(list)
    diff = if is_negative, do: -increment, else: increment
    res = apply_op(formatted_list, base, diff)
    encode_list({is_negative, res})
    |> strip_superfluous_zero
  end

  defp strip_superfluous_zero([0|tail]) when tail != [] do
    tail
  end
  defp strip_superfluous_zero(list) do
    list
  end

  defp decode_list([head|tail]) do
    is_negative = head < 0
    reversed_list = [abs(head)|tail]
                    |> Enum.reverse
    {is_negative, reversed_list}
  end

  defp encode_list({is_negative, [head|tail]}) do
    new_head = if is_negative, do: -head, else: head

    [new_head|tail]
    |> Enum.reverse
  end

  defp apply_op([], _base, diff) do
    [diff]
  end
  defp apply_op([head|tail], base, diff) do
    new = head + diff
    cond do
      new < 0 ->
        [(new + base) | apply_op(tail, base, -1)]
      new >= base ->
        [(new - base) | apply_op(tail, base, 1)]
      true ->
        [new|tail]
    end
  end
end
