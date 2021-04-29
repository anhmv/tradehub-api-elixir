defmodule Tradehub.Network.Mainnet do
  @moduledoc """
  Mainnet API Client for Tradehub API
  """

  use HTTPoison.Base

  @mainnet Application.fetch_env!(:tradehub, :mainnet)

  def process_request_url(url) do
    @mainnet <> url
  end

  def process_response_body(body) do
    body
    |> Jason.decode!()
  end
end
