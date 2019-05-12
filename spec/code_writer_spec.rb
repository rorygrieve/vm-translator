require 'code_writer'

RSpec.describe CodeWriter do
  subject(:code_writer) { CodeWriter }
  describe '#call' do
    context 'memory access commands' do
      context 'single push constant' do
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

      context 'mulitple push constants' do
        let(:parsed_code) { ['push constant 8', 'push constant 9'] }

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
                '// push constant 9',
                '@9',
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
    end

    context 'arithmetic commands' do
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
end
