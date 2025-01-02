defmodule Hiwi.Queue do
  defstruct [:prefix, :name, :description, :status, :current_number, :tellers, :clients]

  @statuses [:active, :inactive]

  def new(prefix, name, description) do
    %Hiwi.Queue{
      prefix: prefix,
      name: name,
      description: description,
      status: :active,
      current_number: 0,
      tellers: [],
      clients: []
    }
  end

  def set_status(queue, status) when status in @statuses do
    %{queue | status: status}
  end

  def increment_number(queue) do
    if queue.status == :active do
      new_number = queue.current_number + 1
      %{queue | current_number: new_number}
    else
      {:error, "Queue is inactive"}
    end
  end

  def reset_number(queue) do
    %{queue | current_number: 0}
  end

  def add_teller(queue, teller) do
    %{queue | tellers: [teller | queue.tellers]}
  end

  def add_client(queue, client) do
    %{queue | clients: [client | queue.clients]}
  end

  def get_queue_number(queue) do
    "#{queue.prefix}#{queue.current_number}"
  end
end

defmodule Hiwi.User do
  defstruct [:email, :phone_number, :full_name, :role]

  def new(email, phone_number, full_name, role) do
    %Hiwi.User{
      email: email,
      phone_number: phone_number,
      full_name: full_name,
      role: role
    }
  end
end

defmodule Hiwi do
  def start do
    # Example of creating a queue and managing users
    queue = Hiwi.Queue.new("C90", "Registration Queue", "Queue for event registration")

    # Owner actions
    queue = Hiwi.Queue.increment_number(queue)
    queue = Hiwi.Queue.add_teller(queue, %Hiwi.User.new("teller@example.com", "1234567890", "John Doe", :teller))
    queue = Hiwi.Queue.add_client(queue, %Hiwi.User.new("client@example.com", "0987654321", "Jane Smith", :client))

    # Get the current queue number
    current_queue_number = Hiwi.Queue.get_queue_number(queue)

    IO.inspect(queue)
    IO.puts("Current Queue Number: #{current_queue_number}")
  end
end

