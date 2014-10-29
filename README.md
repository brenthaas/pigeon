## Pigeon: A way to get from here to there
### Overview
This gem is a basic implementation of message passing using RabbitMQ (via Bunny)

### How to use:
#### Server
* You must have a RabbitMQ server instance running
    - run `brew install rabbitmq` to install via homebrew
    - `rabbitmq-server` to start the server
* It is advised to declare a `queue` via the admin tool
    - `rabbitmqadmin declare queue name='queue.yerdle' durable=true` 
    - `rabbitmqadmin list queues` or `rabbitmqctl list_queues` to list queues
    - `rabbitmqadmin -f long -d 3 list queues` for very detailed queue info

#### Producer
* The `producer_example.rb` file shows a basic working example of a Producer
* Creating a new instance of `Producer` will establish a connection to the default (named `""`) exchange
* Call `#send` with a `Hash` to send data to the consumer
* Call `#finish ` to close the connection

#### Consumer
* The `consumer_example.rb` file shows a basic working example of a Producer
* Creating a new instance of `Consumer` will establish a connection to a queue (default to `"queue.yerdle"` unless a name is passed to `#new`)
* Call `#consume_messages` with a block
    - The block will be passed a hash (the payload of a message from a producer)
    - :warning: This is a *blocking* call. Execution of this thread will block until an `Exception` or `Interrurpt` (i.e. Ctrl-C) is raised
* Call `#finish` to close the connection

