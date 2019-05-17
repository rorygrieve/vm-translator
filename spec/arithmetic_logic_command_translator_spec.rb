require 'arithmetic_logic_command_translator'

RSpec.describe ArithmeticLogicCommandTranslator do
  subject(:arithmetic_logic_command_translator) { ArithmeticLogicCommandTranslator }
  describe '#call' do
    before do
      arithmetic_logic_command_translator.class_variable_set(:@@number, 0)
    end
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
              '// sub',
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
              'A=M-1',
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
              '@TRUE.1',
              'D;JLT',
              '@FALSE.1',
              '0;JMP',
              '(TRUE.1)',
              '@SP',
              'A=M-1',
              'M=-1',
              '@FINISH.1',
              '0;JMP',
              '(FALSE.1)',
              '@SP',
              'A=M-1',
              'M=0',
              '(FINISH.1)',
            ]
          )
      end
    end

    context 'greater than' do
      let(:parsed_code) { 'gt' }

      it 'converts it to assembly' do
        expect(arithmetic_logic_command_translator.call(parsed_code))
          .to eq(
            [
              '// gt',
              '@SP',
              'M=M-1',
              'A=M',
              'D=M',
              'A=A-1',
              'D=D-M',
              '@TRUE.1',
              'D;JLT',
              '@FALSE.1',
              '0;JMP',
              '(TRUE.1)',
              '@SP',
              'A=M-1',
              'M=-1',
              '@FINISH.1',
              '0;JMP',
              '(FALSE.1)',
              '@SP',
              'A=M-1',
              'M=0',
              '(FINISH.1)',
            ]
          )
      end
    end

    context 'equals' do
      let(:parsed_code) { 'eq' }

      it 'converts it to assembly' do
        expect(arithmetic_logic_command_translator.call(parsed_code))
          .to eq(
            [
              '// eq',
              '@SP',
              'M=M-1',
              'A=M',
              'D=M',
              'A=A-1',
              'D=M-D',
              '@TRUE.1',
              'D;JEQ',
              '@FALSE.1',
              '0;JMP',
              '(TRUE.1)',
              '@SP',
              'A=M-1',
              'M=-1',
              '@FINISH.1',
              '0;JMP',
              '(FALSE.1)',
              '@SP',
              'A=M-1',
              'M=0',
              '(FINISH.1)',
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
