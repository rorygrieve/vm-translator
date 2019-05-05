require 'main'
require 'parser'

RSpec.describe 'Translate files to assembly' do
  subject(:main) {
    Main.new(
      parser: parser,
    )
  }
  let(:parser) { class_double(Parser) }

  before do
    allow(parser).to receive(:call)
  end

  context 'a file containing simple vm commands is added' do
    it 'is translated into assembly' do
      main.call('spec/fixtures/SimpleAdd.vm')

      expect(File).to exist('lib/output/SimpleAdd.asm')
    end
  end
end
