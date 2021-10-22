import Config

# Add configuration that is only needed when running on the host here.
config :clock, 
  adapter: Clock.Adapter.Target, 
  timezone: "US/Eastern", 
  spi: "spidev0.0"
