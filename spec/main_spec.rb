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
  let(:parser) { class_double(Parser, call: 'some parsed vm code') }
  let(:code_writer) { class_double(CodeWriter, call: nil) }

  describe '#call' do
    before do
      allow(File).to receive(:open).and_return("something")
      main.call("spec/fixtures/SomeVMCode.vm")
    end

    it "passes the file to the parser" do
      expect(parser).to have_received(:call).with("spec/fixtures/SomeVMCode.vm")
    end


    it "passes the file to the code writer" do
      expect(code_writer).to have_received(:call).with("some parsed vm code")
    end

    it "creates a file with translated code" do
      expect(File).to have_received(:open).with("lib/output/SomeVMCode.asm", "w+")
    end
  end
end
