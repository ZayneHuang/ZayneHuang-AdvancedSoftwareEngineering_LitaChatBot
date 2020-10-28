module Lita
  module Handlers
    class Calculater < Handler
      route(
        /^calculate\s+(-?[1-9]\d*)([-*\/+])(-?[1-9]\d*)$/i,
        :respond_with_calc,
        command: true,
        help: { 'calculate a+\-\*\/b' => 'prints a +\-\*\/ b = result' }
      )

      def respond_with_calc(response)
        # Read up on the Ruby MatchData class for more options
        a = response.match_data.captures[0]
        op = response.match_data.captures[1]
        b = response.match_data.captures[2]
        a = Integer(a)
        b = Integer(b)

        case op
        when "+"
            response.reply "#{a} + #{b} = #{add(a, b)}"
        when "-"
            response.reply "#{a} - #{b} = #{minus(a, b)}"
        when "*"
            response.reply "#{a} * #{b} = #{multiply(a, b)}"
        when "/"
            response.reply "#{a} / #{b} = #{divide(a, b)}"
        end

      end

      def add(a, b)
          return a + b
      end

      def minus(a, b)
        return a - b
      end

      def multiply(a, b)
        return a * b
      end

      def divide(a, b)
        if a % b == 0 then
          return a / b
        else
          return a.to_f / b.to_f
        end
      end

      Lita.register_handler(self)
    end
  end
end
