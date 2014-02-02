#!/usr/bin/env ruby

require "pp"
require "optparse"

$:.unshift File.join(File.dirname(__FILE__), *%w[.. lib])

require "topn"

options = Hash.new

o = OptionParser.new do |opts|
  opts.banner = "Usage #{$0} [options]"

  opts.on('-f', '--file FILE', 'specify the file you want to process') do |v|
    options[:file] = v
  end

  opts.on('-n', '--limit N', 'specify N as output limit') do |v|
    options[:n] = v.to_i
  end
end

begin
  o.parse!
rescue OptionParser::InvalidOption
  puts o
  exit 1
rescue OptionParser::MissingArgument
  puts o
  exit 2
end

n    = options[:n]
file = options[:file]

sort = TopN::Sort.new(file)
sort.sort_content

sort.display_n(n) do |element|
  puts element
end
