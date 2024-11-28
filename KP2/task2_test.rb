require 'rspec'
require_relative 'task2'

RSpec.describe NumProcessor do
  before do
    @processor = NumProcessor.new
  end

  it 'генерує і додає числа в чергу' do
    Thread.new { @processor.generate_numbers(5) }
    sleep 0.6
    expect(@processor.instance_variable_get(:@queue).size).to eq(6)
  end

  it 'обробляє лише непарні числа' do
    allow_any_instance_of(Queue).to receive(:pop).and_return(5, 42, 17, :done)
    expect { @processor.process_numbers }.to output(
                                               /Непарне число: 5\nНепарне число: 17/
                                             ).to_stdout
  end

  it 'коректно завершує роботу' do
    generator_thread = Thread.new { @processor.generate_numbers(3) }
    processor_thread = Thread.new { @processor.process_numbers }

    generator_thread.join
    processor_thread.join

    expect(@processor.instance_variable_get(:@queue)).to be_empty
  end

  it 'не падає при виникненні винятків у генераторі' do
    allow(@processor).to receive(:generate_numbers).and_raise(StandardError, 'Test error')
    expect { @processor.generate_numbers rescue nil }.to_not raise_error
  end

  it 'не падає при виникненні винятків у обробнику' do
    allow_any_instance_of(Queue).to receive(:pop).and_raise(StandardError, 'Test error')
    expect { @processor.process_numbers rescue nil }.to_not raise_error
  end
end
