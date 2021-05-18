defmodule Tradehub.Tx.MsgSetLeverage do
  use Tradehub.Tx.Type

  def type, do: "leverage/MsgSetLeverage"

  @type t :: %__MODULE__{
          market: String.t(),
          leverage: String.t(),
          originator: String.t()
        }

  defstruct [:market, :leverage, :originator]

  def validate!(message) do
    if blank?(message.market), do: raise(Tradehub.Tx.MsgInvalid, message: "Market is required")
    if blank?(message.leverage), do: raise(Tradehub.Tx.MsgInvalid, message: "Leverage is required")
    if blank?(message.originator), do: raise(Tradehub.Tx.MsgInvalid, message: "Originator is required")

    message
  end
end