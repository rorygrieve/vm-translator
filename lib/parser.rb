class Parser

  def self.call(file)
    lines = IO.readlines(file)
    lines
      .reject { |line| strip_out_lines_starting_with_comments(line) }
      .map { |line| strip_out_inline_comments(line) }
      .map { |line| strip_out_whitespace(line) }
      .reject { |line| strip_out_blank_lines(line) }
  end

  private

  def self.strip_out_lines_starting_with_comments(line)
    line[0..1] == "//"
  end

  def self.strip_out_inline_comments(line)
    comment_index = line.index("//")
    if comment_index == nil
      return line
    end

    line[comment_index..-1] = ""
    line
  end

  def self.strip_out_blank_lines(line)

    line.empty?
  end

  def self.strip_out_whitespace(line)
    line.strip
  end
end
