require 'main'
require 'parser'
require 'code_writer'

RSpec.describe 'Translate files to assembly' do
  subject(:main) {
    Main.new(
      parser: Parser,
      code_writer: CodeWriter,
    )
  }


  context 'a file containing simple vm commands is added' do
    it 'is translated into assembly' do
      main.call('spec/fixtures/SimpleAdd.vm')

      expect(File).to exist('lib/output/SimpleAdd.asm')
      expect(IO.read('lib/output/SimpleAdd.asm')).to eq(IO.read('spec/fixtures/SimpleAdd.asm'))
    end
  end

  after do
    Dir["lib/output/*"].each do |file|
      File.delete(file)
    end
  end
end
