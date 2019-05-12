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

    context 'add' do
      let(:parsed_code) { ['add'] }
      it 'converts it to assembly' do
        expect(code_writer.call(parsed_code))
          .to eq(
            [
              '// add',
              '@SP',
              'M=M-1',
              'A=M',
              'D=M',
              'A=A-1',
              'M=D+M',
            ]
          )
      end
    end
  end
end
