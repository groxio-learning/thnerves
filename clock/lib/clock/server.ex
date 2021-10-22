defmodule Clock.Server do
  defstruct [:adapter, :time, :timezone]
  use GenServer
  @spi_bus_name "spidev0.0"
  @timezone "US/Eastern"
  
  def init(opts) do
    tz = opts[:timezone] || @timezone
    bus = opts[:spi] || @spi_bus_name
    time = local_time(tz)
    
    adapter = opts[:adapter] || Clock.Adapter.Dev

    {:ok, %__MODULE__{adapter: adapter.open(bus, time), time: time, timezone: tz}}
  end
  
  def handle_info(:tick, server), do: {:noreply, advance(server)}
  
  defp advance(server) do
    module = server.adapter.__struct__
    advanced = module.show(server.adapter, local_time(server.timezone))
    %{server| adapter: advanced}
  end
  
  def start_link(opts \\ %{}) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end
  
  def tick do
    send(__MODULE__, :tick)
  end
  
  defp local_time(timezone) do
    DateTime.now!(timezone, Tzdata.TimeZoneDatabase)
  end
end