# UAS\\


defmodule QueueManager do
  @moduledoc """
  A module to manage queues with a name and description.
  """

  defstruct name: nil, description: nil

  @doc """
  Creates a new queue with a given name and description.

  ## Examples

      iex> QueueManager.create_queue("MyQueue", "This is a test queue")
      {:ok, %QueueManager{name: "MyQueue", description: "This is a test queue"}}

      iex> QueueManager.create_queue("", "No name queue")
      {:error, "Name cannot be empty"}
  """
  def create_queue(name, description) when is_binary(name) and is_binary(description) do
    cond do
      String.trim(name) == "" ->
        {:error, "Name cannot be empty"}

      String.trim(description) == "" ->
        {:error, "Description cannot be empty"}

      true ->
        {:ok, %__MODULE__{name: name, description: description}}
    end
  end

  @doc """
  Updates the description of an existing queue.

  ## Examples

      iex> {:ok, queue} = QueueManager.create_queue("MyQueue", "This is a test queue")
      iex> QueueManager.update_description(queue, "Updated description")
      {:ok, %QueueManager{name: "MyQueue", description: "Updated description"}}

  """
  def update_description(%__MODULE__{} = queue, new_description) when is_binary(new_description) do
    if String.trim(new_description) == "" do
      {:error, "Description cannot be empty"}
    else
      {:ok, %__MODULE__{queue | description: new_description}}
    end
  end
end
