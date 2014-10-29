require 'pigeon'
require 'bunny'
require 'msgpack'

module Pigeon
  class Producer
    attr_reader :queue_name

    def initialize(queue_name)
      @queue_name = queue_name
    end

    def exchange
      @exchange ||= begin
        connection = Bunny.new
        connection.start

        channel = connection.create_channel
        queue   = channel.queue(queue_name, auto_delete: false, durable: true)

        channel.default_exchange
      rescue Bunny::Exception => e
        raise ConnectionError.new(e)
      end
    end

    def send_message(msg)
      exchange.publish(msg.to_msgpack, routing_key: queue_name)
    end
  end
end
