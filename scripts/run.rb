#!/usr/bin/env ruby

require_relative '../lib/main'
require_relative '../lib/parser'
require_relative '../lib/code_writer'

Main.new(parser: Parser, code_writer: CodeWriter).call(ARGV[0])
