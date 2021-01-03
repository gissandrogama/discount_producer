defmodule DiscountProducer do
  @topic "ofertas"

  def execut, do: %{name: "Paystation #{:rand.uniform(1000)}", discount: :rand.uniform(60), price: :rand.uniform(3000)} |> send_msg()
  def executx, do: %{name: "Xbox #{:rand.uniform(1000)}", discount: :rand.uniform(60), price: :rand.uniform(5000)} |> send_msg()

  def send_msg(payload) do
    client_id = :discount_producer
    hosts = [localhost: 9092]

    :ok = :brod.start_client(hosts, client_id)
    :ok = :brod.start_producer(client_id, @topic, [])

    :brod.produce(client_id, @topic, 0, _key = "", payload |> Jason.encode!())
  end
end
