require 'pigeon'

module Pigeon
  class Consumer
    attr_reader :queue_name

    def initialize(queue_name)
      @queue_name = queue_name
    end

    def queue
      @queue ||= begin
        connection = Bunny.new
        connection.start

        channel = connection.create_channel
        channel.queue(queue_name, auto_delete: false, durable: true)
      rescue Bunny::Exception => e
        raise ConnectionError.new(e)
      end
    end

    def consume_messages
      queue.subscribe(:block => true) do |delivery_info, properties, body|
        yield MessagePack.unpack(body)
      end
    end
  end
end
