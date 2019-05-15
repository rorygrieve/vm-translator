require 'arithmetic_logic_command_translator'

RSpec.describe ArithmeticLogicCommandTranslator do
  subject(:arithmetic_logic_command_translator) { ArithmeticLogicCommandTranslator }
  describe '#call' do
    context 'add' do
      let(:parsed_code) { 'add' }

      it 'converts it to assembly' do
        expect(arithmetic_logic_command_translator.call(parsed_code))
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
        expect(arithmetic_logic_command_translator.call(parsed_code))
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

    context 'neg' do
      let(:parsed_code) { 'neg' }

      it 'converts it to assembly' do
        expect(arithmetic_logic_command_translator.call(parsed_code))
          .to eq(
            [
              '// neg',
              '@SP',
              'A=M',
              'M=-M',
            ]
          )
      end
    end

    context 'and' do
      let(:parsed_code) { 'and' }

      it 'converts it to assembly' do
        expect(arithmetic_logic_command_translator.call(parsed_code))
          .to eq(
            [
              '// and',
              '@SP',
              'M=M-1',
              'A=M',
              'D=M',
              'A=A-1',
              'M=D&M',
            ]
          )
      end
    end
  end
end
