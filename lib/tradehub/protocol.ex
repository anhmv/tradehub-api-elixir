defmodule Tradehub.Protocol do
  @moduledoc """
  This module provides a set of functionalities to retreive information from the tradehub protocol.
  """

  @doc """
  Requests Cosmos RPC status endpoint

  ## Examples

      iex> Tradehub.Protocol.status

  """

  @spec status :: {:ok, Tradehub.protocol_status()} | {:error, HTTPoison.Error.t()}

  def status do
    case Tradehub.get(Application.fetch_env!(:tradehub, :public_protocol_status)) do
      {:ok, response} -> {:ok, response.body}
      other -> other
    end
  end

  @doc """
  Get the block time in format HH:MM:SS.ZZZZZZ.

  ## Examples

      iex> Tradehub.Protocol.block_time
  """

  @spec block_time :: {:ok, String.t()} | {:error, HTTPoison.Error.t()}

  def block_time do
    case Tradehub.get(Application.fetch_env!(:tradehub, :public_protocol_block_time)) do
      {:ok, response} -> {:ok, response.body}
      other -> other
    end
  end

  @doc """
  Get all validators, includes active, unbonding, and unbonded validators.

  ## Examples

      iex> Tradehub.Protocol.validators

  """

  @spec validators :: {:ok, list(Tradehub.validator())} | {:error, HTTPoison.Error.t()}

  def validators do
    case Tradehub.get(Application.fetch_env!(:tradehub, :public_protocol_validators)) do
      {:ok, response} -> {:ok, response}
      other -> other
    end
  end

  @doc """
  Requests delegation rewards of the given account

  ## Examples

      iex> Tradehub.Protocol.delegation_rewards("swth1945upvdn2p2sgq7muyhfmygn3fu740jw9l73du")

  """

  @spec delegation_rewards(String.t()) :: {:ok, Tradehub.delegation_rewards()} | {:error, HTTPoison.Error.t()}

  def delegation_rewards(account) do
    case Tradehub.get(
           Application.fetch_env!(:tradehub, :public_protocol_rewards),
           params: %{account: account}
         ) do
      {:ok, response} -> {:ok, response.body}
      other -> other
    end
  end

  @doc """
  Requests latest blocks or specific blocks that match the requested parameters.

  ## Parameters

  - **before_id**: before block height
  - **after_id**: after block height
  - **order_by**: not specified yet
  - **proposer**: tradehub validator consensus starting with `swthvalcons1` on mainnet and `tswthvalcons1` on testnet
  - **limit**: limit the responded result, values greater than 200 have no effect and a maximum of 200 results are returned.

  ## Examples

      iex> Tradehub.Protocol.blocks

  """

  @spec blocks(nil, nil, nil, nil, nil) :: {:ok, list(Tradehub.block())} | {:error, HTTPoison.Error.t()}
  @spec blocks(integer, integer, String.t(), String.t(), integer) ::
          {:ok, list(Tradehub.block())} | {:error, HTTPoison.Error.t()}

  def blocks(before_id \\ nil, after_id \\ nil, order_by \\ nil, proposer \\ nil, limit \\ nil) do
    case Tradehub.get(
           Application.fetch_env!(:tradehub, :public_protocol_blocks),
           params: %{
             before_id: before_id,
             after_id: after_id,
             order_by: order_by,
             proposer: proposer,
             limit: limit
           }
         ) do
      {:ok, response} -> {:ok, response.body}
      other -> other
    end
  end

  @doc """
  Requests latest transactions or filtered transactions based on the filter params.

  ## Parameters

  - **address**: tradehub switcheo address starts with `swth1` on mainnet and `tswth1` on testnet.
  - **msg_type**: filtered by `msg_type`, allowed values can be fetch with `Tradehub.Protocol.transaction_types`
  - **height**: filter transactions at a specific height
  - **start_block**: filter transactions after block
  - **end_block**: filter transactions before block
  - **before_id**: filter transactions before id
  - **after_id**: filter transactions after id
  - **order_by**: TODO
  - **limit**: limit by 200, values above 200 have no effects.

  ## Examples

      iex> Tradehub.Protocol.transactions

  """

  @spec transactions(nil, nil, nil, nil, nil, nil, nil, nil, nil) ::
          {:ok, list(Tradehub.transaction())} | {:error, HTTPoison.Error.t()}
  @spec transactions(
          String.t(),
          String.t(),
          String.t(),
          String.t(),
          String.t(),
          String.t(),
          String.t(),
          String.t(),
          String.t()
        ) :: {:ok, list(Tradehub.transaction())} | {:error, HTTPoison.Error.t()}

  def transactions(
        address \\ nil,
        msg_type \\ nil,
        height \\ nil,
        start_block \\ nil,
        end_block \\ nil,
        before_id \\ nil,
        after_id \\ nil,
        order_by \\ nil,
        limit \\ nil
      ) do
    case Tradehub.get(
           Application.fetch_env!(:tradehub, :public_protocol_transactions),
           params: %{
             address: address,
             msg_type: msg_type,
             height: height,
             start_block: start_block,
             end_block: end_block,
             before_id: before_id,
             after_id: after_id,
             order_by: order_by,
             limit: limit
           }
         ) do
      {:ok, response} -> {:ok, response.body}
      other -> other
    end
  end

  @doc """
  Get a transaction by providing a hash

  ## Examples

      iex> Tradehub.Protocol.transaction("A93BEAC075562D4B6031262BDDE8B9A720346A54D8570A881E3671FEB6E6EFD4")

  """

  @spec transaction(String.t()) :: {:ok, Tradehub.transaction()} | {:error, HTTPoison.Error.t()}

  def transaction(hash) do
    case Tradehub.get(
           Application.fetch_env!(:tradehub, :public_protocol_transaction),
           params: %{hash: hash}
         ) do
      {:ok, response} -> {:ok, response.body}
      other -> other
    end
  end

  @doc """
  Requests available transaction types on Tradehub

  ## Examples

      iex> Tradehub.Protocol.transaction_types

  """

  @spec transaction_types :: {:ok, list(String.t())} | {:error, HTTPoison.Error.t()}

  def transaction_types do
    case Tradehub.get(Application.fetch_env!(:tradehub, :public_protocol_transaction_types)) do
      {:ok, response} -> {:ok, response.body}
      other -> other
    end
  end

  @doc """
  Get total of available balances of token on the chain.

  ## Examples

      iex> Tradehub.Protocol.total_balances

  """

  @spec total_balances :: {:ok, list(Tradehub.protocol_balance())} | {:error, HTTPoison.Error.t()}

  def total_balances do
    case Tradehub.get(Application.fetch_env!(:tradehub, :public_protocol_total_balances)) do
      {:ok, response} -> {:ok, response.body}
      other -> other
    end
  end

  @doc """
  Get external transfers (both withdraws and deposits) of an account from other blockchains.

  ## Examples

      iex> Tradehub.Protocol.external_transfers("swth1qlue2pat9cxx2s5xqrv0ashs475n9va963h4hz")

  """

  @spec external_transfers(String.t()) :: {:ok, list(Tradehub.transfer_record())} | {:error, HTTPoison.Error.t()}

  def external_transfers(account) do
    case Tradehub.get(
           Application.fetch_env!(:tradehub, :public_protocol_external_transfers),
           params: %{account: account}
         ) do
      {:ok, response} -> {:ok, response}
      other -> other
    end
  end
end