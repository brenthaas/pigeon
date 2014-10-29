require 'spec_helper'
require 'pigeon/consumer'

module Pigeon
  describe Consumer do
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
        expect(subject.queue.object_id).to eq(subject.queue.object_id)
      end

      context 'when unable to establish a connection' do
        let(:connection) { double(Bunny) }

        before do
          allow(Bunny).to receive(:new).and_return(connection)
          allow(connection).to receive(:start).and_raise(Bunny::Exception)
        end

        specify 'a connection error is raised' do
          expect{subject.connect}.to raise_error(Pigeon::ConnectionError)
        end
      end
    end

    describe '#consume_messages' do
      let(:message) { "\x82\xA4type\xA5thing\xA5value\x14" }
      let(:queue) { double(Bunny::Queue) }

      before do
        allow(subject).to receive(:queue).and_return(queue)
      end

      it 'subscribes to the queue' do
        expect(queue).to receive(:subscribe)
        subject.consume_messages
      end
    end
  end
end
