require 'main'
require 'parser'
require 'code_writer'

RSpec.describe 'Translate files to assembly' do
  subject(:main) {
    Main.new(
      parser: parser,
      code_writer: code_writer,
    )
  }
  let(:parser) { class_double(Parser) }
  let(:code_writer) { class_double(CodeWriter) }

  before do
    allow(parser).to receive(:call)
    allow(code_writer).to receive(:call)
  end

  context 'a file containing simple vm commands is added' do
    it 'is translated into assembly' do
      main.call('spec/fixtures/SimpleAdd.vm')

      expect(File).to exist('lib/output/SimpleAdd.asm')
    end
  end
end
