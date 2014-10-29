require 'spec_helper'
require 'pigeon/producer'

module Pigeon
  describe Producer do
    let(:message) { { type: 'message', value: 12 } }
    let(:queue_name) { 'queue' }

    subject { described_class.new(queue_name) }

    before do
      allow(Bunny).to receive(:new).and_return(BunnyMock.new)
    end

    describe 'initialization' do

      it 'assigns the queue name if given' do
        expect(subject.queue_name).to eq(queue_name)
      end
    end

    describe '#connect' do

      it 'does not reconnect if already connected' do
        expect(subject.connect.object_id).to eq(subject.connect.object_id)
      end

      context 'when unable to establish a connection' do
        let(:connection) { double(Bunny) }

        before do
          allow(Bunny).to receive(:new).and_return(connection)
          allow(connection).to receive(:start).and_raise(Bunny::Exception)
        end

        specify 'a connection error is raised' do
          expect{subject.exchange}.to raise_error(Pigeon::ConnectionError)
        end
      end
    end

    describe '#send_message' do
      let(:exchange) { double(Bunny::Exchange)}

      it 'serializes the message for transmission' do
        expect(message).to receive(:to_msgpack).and_call_original
        subject.send_message(message)
      end

      it 'sends the message' do
        allow(subject).to receive(:exchange).and_return(exchange)
        expect(exchange).to receive(:publish)
        subject.send_message(message)
      end
    end
  end
end
