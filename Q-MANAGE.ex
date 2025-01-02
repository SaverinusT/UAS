defmodule Hiwi.Queue do
  defstruct id: nil, name: "", description: "", prefix: "", max_number: 0, current_number: 0, status: :inactive, tellers: [], clients: []

  @doc """
  Creates a new queue with the given attributes.
  """
  def new(name, description, prefix, max_number) do
    %Hiwi.Queue{
      id: UUID.uuid4(),  # Generate a unique ID for the queue
      name: name,
      description: description,
      prefix: prefix,
      max_number: max_number,
      current_number: 0,
      status: :inactive,
      tellers: [],
      clients: []
    }
  end

  @doc """
  Activates the queue, allowing numbers to be incremented.
  """
  def activate(queue) do
    %Hiwi.Queue{queue | status: :active}
  end

  @doc """
  Deactivates the queue, preventing number increments.
  """
  def deactivate(queue) do
    %Hiwi.Queue{queue | status: :inactive}
  end

  @doc """
  Increments the queue number if the queue is active and the max number has not been reached.
  """
  def increment_number(%Hiwi.Queue{status: :active, current_number: current_number, max_number: max_number} = queue) do
    if current_number < max_number do
      %Hiwi.Queue{queue | current_number: current_number + 1}
    else
      {:error, "Maximum queue number reached"}
    end
  end

  def increment_number(queue), do: {:error, "Queue is not active"}

  @doc """
  Resets the queue number to zero.
  """
  def reset_number(queue) do
    %Hiwi.Queue{queue | current_number: 0}
  end

  @doc """
  Adds a teller to the queue.
  """
  def add_teller(queue, teller_id) do
    %Hiwi.Queue{queue | tellers: queue.tellers ++ [teller_id]}
  end

  @doc """
  Registers a client to the queue and assigns a queue number.
  """
  def register_client(queue, client_id) do
    if queue.status == :active do
      new_client_number = queue.current_number + 1
      if new_client_number <= queue.max_number do
        updated_queue = %Hiwi.Queue{queue | current_number: new_client_number, clients: queue.clients ++ [{client_id, new_client_number}]}
        {:ok, new_client_number}
      else
        {:error, "Maximum queue number reached"}
      end
    else
      {:error, "Queue is not active"}
    end
  end

  @doc """
  Displays the queue's details.
  """
  def display(%Hiwi.Queue{name: name, description: description, prefix: prefix, current_number: current_number, status: status}) do
    IO.puts("Queue Name: #{name}")
    IO.puts("Description: #{description}")
    IO.puts("Prefix: #{prefix}")
    IO.puts("Current Number: #{current_number}")
    IO.puts("Status: #{status}")
  end
end