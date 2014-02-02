module TopN
  class Sort
    def initialize(file)
      @bitm = ::TopN::Bitmask.new(get_file_length(file))
      @file = file
    end

    def sort_content
      begin
        File.open(@file, 'r') do |f|
          f.each_line do |line|
            number = line.to_i
            @bitm.sort(number)
          end
        end
      rescue => e
        puts "Can't load file"
        puts e.backtrace
        exit 1
      end
    end

    def display_n(n, &block)
      @bitm.display_result(n) do |result|
        yield result
      end
    end

    private
    def get_file_length(file)
      wc = %x{which wc}.chomp
      cmd = Array.new
      cmd << wc
      cmd << '-l'
      cmd << file

      begin
        io = IO.popen(cmd.join(' '))
        # this is ugly but system's 'wc -l' is faster than reading file in Ruby.
        output  = io.read
        file_length = output.chomp.split(' ').first.to_i
        io.close

        file_length
      rescue => e
        puts "Can't examine file"
        puts e.backtrace
      end
    end
  end
end
