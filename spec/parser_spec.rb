require "parser"

RSpec.describe Parser do
  subject(:parser) { Parser }

  describe "#call" do
    it "reads the file" do
      asm_file = "somefile.asm"
      allow(IO).to receive(:readlines).with(asm_file).and_return([])
      parser.call(asm_file)

      expect(IO).to have_received(:readlines).with(asm_file)
    end

    it "stips out lines starting with comments" do
      expect(parser.call("spec/fixtures/the_one_with_comments.asm"))
        .to eq(
          ['push constant 79']
        )
    end

    it "strips out text after comments" do
      expect(parser.call("spec/fixtures/the_one_with_inline_comments.asm"))
        .to eq(
          [
            'pop local 8',
            'push constant 7',
            'push constant 868',
            'add',
          ]
        )
    end

    it "strips out whitespace" do
      expect(parser.call("spec/fixtures/the_one_with_extra_whitespace.asm"))
        .to eq(
          ['push constant 8'],
        )
    end

    it "strips out blank lines" do
      expect(parser.call("spec/fixtures/the_one_with_blank_lines.asm"))
        .to eq(
          [
            'push constant 8',
            'add',
          ]
        )
    end
  end
end
