require 'main'
require 'parser'
require 'code_writer'

RSpec.describe Main do
  subject(:main) {
    Main.new(
      parser: parser,
      code_writer: code_writer,
    )
  }
  let(:parser) { class_double(Parser) }
  let(:code_writer) { class_double(CodeWriter) }

  describe '#call' do
    before do
      allow(parser).to receive(:call)
      allow(code_writer).to receive(:call)
    end

    it 'outputs name of generated asm file' do
      expect(main.call('path/to/some-vm-code.vm')).to eq('lib/output/some-vm-code.asm')
    end

    it 'passes the file to the parser' do
      main.call('path/to/some-vm-code.vm')

      expect(parser).to have_received(:call).with('path/to/some-vm-code.vm')
    end
  end
end
