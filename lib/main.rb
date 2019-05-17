class Main
  def initialize(parser:, code_writer:)
    @parser = parser
    @code_writer = code_writer
  end

  attr_reader :parser, :code_writer
  private :parser, :code_writer

  def call(file_to_be_translated)
    parsed_vm_code = parser.call(file_to_be_translated)

    name_of_original_file = filename_without_extension(file_to_be_translated)
    code_writer.filename = name_of_original_file
    assembly_code = code_writer.call(parsed_vm_code)

    name_of_output_file = generate_name_of_output_file(name_of_original_file)
    create_output_file(file_name: name_of_output_file, code: assembly_code)
  end

  private

  def generate_name_of_output_file(file)
    name_of_original_file = filename_without_extension(file)
    "lib/output/#{name_of_original_file}.asm"
  end

  def create_output_file(file_name:, code:)
    File.open(file_name, "w+") do |f|
      f.puts(code)
    end
  end

  def filename_without_extension(file)
    file.split("/").last.split(".").first
  end
end
