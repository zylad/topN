module TopN
  class Bitmask
    attr_reader :result
    # Args:
    #   elements - integer, amount of elements being sorted
    def initialize(elements)
      @result   = Array.new(elements)
    end

    def sort(i)
      @result[i>>TopN::SHIFT] |= (1<<(i & TopN::MASK))
    end

    def is_stored?(i)
      (@result[i>>TopN::SHIFT] & (1<<(i & TopN::MASK)))
    end

    def display_result(n, &block)
      count = 0

      catch :reached_limit do
        loop do
          @result.to_enum.with_index.reverse_each do |v, i|
            if is_stored?(i)
              count += 1
              yield i
            end
            if count == n
              throw :reached_limit
            end
          end
        end
      end
    end
  end
end
