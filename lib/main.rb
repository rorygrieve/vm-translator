class Main
  def call(file_to_be_translated)
    generate_name_of_output_file(file_to_be_translated)
  end

  private

  def generate_name_of_output_file(file)
    name_of_original_file = file.split("/").last
    name_of_new_file_without_file_type = name_of_original_file.split(".").first
    "lib/output/#{name_of_new_file_without_file_type}.asm"
  end
end
