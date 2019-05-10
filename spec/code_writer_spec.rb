require 'code_writer'

RSpec.describe CodeWriter do
  subject(:code_writer) { CodeWriter }
  describe '#call' do
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
  end
end
