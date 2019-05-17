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

  context 'a file containing arithmetic and logic commands is added' do
    it 'is translated into assembly' do
      main.call('spec/fixtures/StackTest.vm')

      expect(File).to exist('lib/output/StackTest.asm')
      expect(IO.read('lib/output/StackTest.asm')).to eq(IO.read('spec/fixtures/StackTest.asm'))
    end
  end

  context 'a file containing pointer commands is added' do
    it 'is translated into assembly' do
      main.call('spec/fixtures/PointerTest.vm')

      expect(File).to exist('lib/output/PointerTest.asm')
      expect(IO.read('lib/output/PointerTest.asm')).to eq(IO.read('spec/fixtures/PointerTest.asm'))
    end
  end

  context 'a file containing static variable commands is added' do
    it 'is translated into assembly' do
      main.call('spec/fixtures/StaticTest.vm')

      expect(File).to exist('lib/output/StaticTest.asm')
      expect(IO.read('lib/output/StaticTest.asm')).to eq(IO.read('spec/fixtures/StaticTest.asm'))
    end
  end

  after do
    Dir["lib/output/*"].each do |file|
      File.delete(file)
    end
  end
end
