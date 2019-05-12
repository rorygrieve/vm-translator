require 'memory_access_command_translator'

RSpec.describe MemoryAccessCommandTranslator do
  subject(:memory_access_command_translator) { MemoryAccessCommandTranslator }
  describe '#call' do
    context 'push commands' do
      context 'constant' do
        let(:parsed_code) { ['push', 'constant', '8'] }

        it 'converts it to assembly' do
          expect(memory_access_command_translator.call(parsed_code))
            .to eq(
              [
                '// push constant 8',
                '@8',
                'D=A',
                '@SP',
                'A=M',
                'M=D',
                '@SP',
                'M=M+1',
              ]
            )
        end
      end

      context 'local' do
        let(:parsed_code) { ['push', 'local', '7'] }

        it 'converts it to assembly' do
          expect(memory_access_command_translator.call(parsed_code))
            .to eq(
              [
                '// push local 7',
                '@7',
                'D=A',
                '@LCL',
                'A=D+M',
                'D=M',
                '@SP',
                'M=M+1',
                'A=M-1',
                'M=D',
              ]
            )
        end
      end

      context 'this' do
        let(:parsed_code) { ['push', 'this', '7'] }

        it 'converts it to assembly' do
          expect(memory_access_command_translator.call(parsed_code))
            .to eq(
              [
                '// push this 7',
                '@7',
                'D=A',
                '@THIS',
                'A=D+M',
                'D=M',
                '@SP',
                'M=M+1',
                'A=M-1',
                'M=D',
              ]
            )
        end
      end

      context 'that' do
        let(:parsed_code) { ['push', 'that', '7'] }

        it 'converts it to assembly' do
          expect(memory_access_command_translator.call(parsed_code))
            .to eq(
              [
                '// push that 7',
                '@7',
                'D=A',
                '@THAT',
                'A=D+M',
                'D=M',
                '@SP',
                'M=M+1',
                'A=M-1',
                'M=D',
              ]
            )
        end
      end
    end

    context 'pop commands' do
      context 'local' do
        let(:parsed_code) { ['pop', 'local', '3'] }

        it 'converts it to assembly' do
          expect(memory_access_command_translator.call(parsed_code))
            .to eq(
              [
                '// pop local 3',
                '@3',
                'D=A',
                '@LCL',
                'D=M+D',
                '@addr',
                'M=D',
                '@SP',
                'M=M-1',
                'A=M',
                'D=M',
                '@addr',
                'A=M',
                'M=D',
              ]
            )
        end
      end

      context 'argument' do
        let(:parsed_code) { ['pop', 'argument', '2'] }

        it 'converts it to assembly' do
          expect(memory_access_command_translator.call(parsed_code))
            .to eq(
              [
                '// pop argument 2',
                '@2',
                'D=A',
                '@ARG',
                'D=M+D',
                '@addr',
                'M=D',
                '@SP',
                'M=M-1',
                'A=M',
                'D=M',
                '@addr',
                'A=M',
                'M=D',
              ]
            )
        end
      end

      context 'this' do
        let(:parsed_code) { ['pop', 'this', '4'] }

        it 'converts it to assembly' do
          expect(memory_access_command_translator.call(parsed_code))
            .to eq(
              [
                '// pop this 4',
                '@4',
                'D=A',
                '@THIS',
                'D=M+D',
                '@addr',
                'M=D',
                '@SP',
                'M=M-1',
                'A=M',
                'D=M',
                '@addr',
                'A=M',
                'M=D',
              ]
            )
        end
      end

      context 'that' do
        let(:parsed_code) { ['pop', 'that', '5'] }

        it 'converts it to assembly' do
          expect(memory_access_command_translator.call(parsed_code))
            .to eq(
              [
                '// pop that 5',
                '@5',
                'D=A',
                '@THAT',
                'D=M+D',
                '@addr',
                'M=D',
                '@SP',
                'M=M-1',
                'A=M',
                'D=M',
                '@addr',
                'A=M',
                'M=D',
              ]
            )
        end
      end
    end
  end
end
