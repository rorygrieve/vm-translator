class Main
  def initialize(parser:, code_writer:)
    @parser = parser
    @code_writer = code_writer
  end

  attr_reader :parser, :code_writer
  private :parser, :code_writer

  def call(file_to_be_translated)
    parsed_code = parser.call(file_to_be_translated)
    assembly_code = code_writer.call(parsed_code)

    name_of_output_file = generate_name_of_output_file(file_to_be_translated)

    create_output_file(file_name: name_of_output_file, code: assembly_code)
  end

  private

  def generate_name_of_output_file(file)
    name_of_original_file = file.split("/").last
    name_of_new_file_without_file_type = name_of_original_file.split(".").first
    "lib/output/#{name_of_new_file_without_file_type}.asm"
  end

  def create_output_file(file_name:, code:)
    File.open(file_name, "w+") do |f|
      f.puts(code)
    end
  end
end
