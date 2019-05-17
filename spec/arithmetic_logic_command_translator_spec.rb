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

    context 'or' do
      let(:parsed_code) { 'or' }

      it 'converts it to assembly' do
        expect(arithmetic_logic_command_translator.call(parsed_code))
          .to eq(
            [
              '// or',
              '@SP',
              'M=M-1',
              'A=M',
              'D=M',
              'A=A-1',
              'M=D|M',
            ]
          )
      end
    end

    context 'not' do
      let(:parsed_code) { 'not' }

      it 'converts it to assembly' do
        expect(arithmetic_logic_command_translator.call(parsed_code))
          .to eq(
            [
              '// not',
              '@SP',
              'A=M-1',
              'M=!M',
            ]
          )
      end
    end

    context 'less than' do
      let(:parsed_code) { 'lt' }

      it 'converts it to assembly' do
        expect(arithmetic_logic_command_translator.call(parsed_code))
          .to eq(
            [
              '// lt',
              '@SP',
              'M=M-1',
              'A=M',
              'D=M',
              'A=A-1',
              'D=M-D',
              '@TRUE',
              'D;JLT',
              '@FALSE',
              '0;JMP',
              '(TRUE)',
              '@SP',
              'A=M-1',
              'M=-1',
              '@FINISH',
              '0;JMP',
              '(FALSE)',
              '@SP',
              'A=M-1',
              'M=0',
              '(FINISH)',
            ]
          )
      end
    end

    context 'unrecognized command' do
      let(:parsed_code) { 'unknown' }

      it 'raises an error' do
        expect{ arithmetic_logic_command_translator.call(parsed_code) }
          .to raise_error(StandardError, /Unrecognized command: unknown/)
      end
    end
  end
end
