require 'main'

RSpec.describe 'Translate files to assembly' do
  let(:main) { Main.new }

  context 'a file containing simple vm commands is added' do
    it 'is translated into assembly' do
      main.call('spec/fixtures/SimpleAdd.vm')

      expect(File).to exist('lib/output/SimpleAdd.asm')
    end
  end
end
