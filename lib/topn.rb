module TopN
  MASK  = 0x1F
  SHIFT = 5

  $:.unshift File.join(File.dirname(__FILE__), *%w[lib])
  require "topn/bitmask"
  require "topn/sort"
end
