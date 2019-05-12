require 'arithmetic_command_translator'

RSpec.describe ArithmeticCommandTranslator do
  subject(:arithmetic_command_translator) { ArithmeticCommandTranslator }
  describe '#call' do
    context 'add' do
      let(:parsed_code) { 'add' }

      it 'converts it to assembly' do
        expect(arithmetic_command_translator.call(parsed_code))
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

    context 'subtract' do
      let(:parsed_code) { 'sub' }

      it 'converts it to assembly' do
        expect(arithmetic_command_translator.call(parsed_code))
          .to eq(
            [
              '// subtract',
              '@SP',
              'M=M-1',
              'A=M',
              'D=M',
              'A=A-1',
              'M=M-D',
            ]
          )
      end
    end
  end
end
