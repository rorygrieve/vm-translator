require 'main'

RSpec.describe Main do
  subject(:main) { Main.new }

  describe '#call' do
    it 'outputs name of generated asm file' do
      expect(main.call('path/to/some-vm-code.vm')).to eq('lib/output/some-vm-code.asm')
    end
  end
end
