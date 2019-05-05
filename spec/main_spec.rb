require 'main'
require 'parser'

RSpec.describe Main do
  subject(:main) {
    Main.new(
      parser: parser,
    )
  }
  let(:parser) { class_double(Parser) }

  describe '#call' do
    before do
      allow(parser).to receive(:call)
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
