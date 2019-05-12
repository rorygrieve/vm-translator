require 'code_writer'

RSpec.describe CodeWriter do
  subject(:code_writer) { CodeWriter }
  describe '#call' do
    context 'push commands' do
      context 'push constant' do
        let(:parsed_code) { ['push constant 8'] }

        it 'converts it to assembly' do
          expect(code_writer.call(parsed_code))
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
    end

    context 'pop commands' do
      context 'pop local' do
        let(:parsed_code) { ['pop local 3'] }

        it 'converts it to assembly' do
          expect(code_writer.call(parsed_code))
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

      context 'pop argument' do
        let(:parsed_code) { ['pop argument 2'] }

        it 'converts it to assembly' do
          expect(code_writer.call(parsed_code))
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

      context 'pop this' do
        let(:parsed_code) { ['pop this 4'] }

        it 'converts it to assembly' do
          expect(code_writer.call(parsed_code))
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

      context 'pop that' do
        let(:parsed_code) { ['pop that 5'] }

        it 'converts it to assembly' do
          expect(code_writer.call(parsed_code))
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
