require 'code_writer'

RSpec.describe CodeWriter do
  subject(:code_writer) { CodeWriter }
  describe '#call' do
    context 'memory access commands' do
      let(:parsed_code) { ['push constant 5'] }

      it 'calls MemoryAccessCommandTranslator' do
        allow(MemoryAccessCommandTranslator).to receive(:call)
        code_writer.call(parsed_code)

        expect(MemoryAccessCommandTranslator).to have_received(:call)
      end
    end

    context 'arithmetic commands' do
      let(:parsed_code) { ['add'] }

      it 'calls ArithmeticCommandTranslator' do
        allow(ArithmeticCommandTranslator).to receive(:call)
        code_writer.call(parsed_code)

        expect(ArithmeticCommandTranslator).to have_received(:call)
      end
    end
  end
end
