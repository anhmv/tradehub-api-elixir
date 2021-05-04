defmodule Tradehub.Ticker do
  @moduledoc """
  Enable features to work with tickers endpoints.
  """

  @doc """
  Requests candlesticks for the given market.

  ## Parameters

  - **market**: the market symbols: e.g `swth_eth1`
  - **resolution**: the candlestick period in minutes, possible values are: 1, 5, 30, 60, 360, 1440
  - **from**: the start of time range for data in epoch `seconds`
  - **to**: the end of time range for data in epoch `seconds`

  ## Examples

      iex> Tradehub.Ticker.candlesticks("swth_eth1", 5, 1610203000, 1610203000)

  """

  @spec candlesticks(String.t(), integer, integer, integer) ::
          {:ok, list(Tradehub.candlestick())} | {:error, HTTPoison.Error.t()}

  def candlesticks(market, resolution, from, to) do
    case Tradehub.get(
           Application.fetch_env!(:tradehub, :public_ticker_candlesticks),
           params: %{
             market: market,
             resolution: resolution,
             from: from,
             to: to
           }
         ) do
      {:ok, response} -> {:ok, response.body}
      other -> other
    end
  end

  @doc """
  Requests prices of the given market.

  ## Examples

      iex> Tradehub.Ticker.prices("swth_eth1")

  """

  @spec prices(String.t()) :: {:ok, Tradehub.ticker_prices()} | {:error, HTTPoison.Error.t()}

  def prices(market) do
    case Tradehub.get(
           Application.fetch_env!(:tradehub, :public_ticker_prices),
           params: %{market: market}
         ) do
      {:ok, response} -> {:ok, response.body}
      other -> other
    end
  end

  @doc """
  Requests latest statistics information about the given market or all markets

  ## Examples

      iex> Tradehub.Ticker.market_stats
      iex> Tradehub.Ticker.market_stats("swth_eth1")

  """

  @spec market_stats(nil) ::
          {:ok, list(Tradehub.market_stats())} | {:error, HTTPoison.Error.t()}
  @spec market_stats(String.t()) ::
          {:ok, list(Tradehub.market_stats())} | {:error, HTTPoison.Error.t()}

  def market_stats(market \\ nil) do
    case Tradehub.get(
           Application.fetch_env!(:tradehub, :public_ticker_market_stats),
           params: %{market: market}
         ) do
      {:ok, response} -> {:ok, response.body}
      other -> other
    end
  end
end