# frozen_string_literal: true
require "./node"
module Arel
  module Nodes
    class Unary < Arel::Nodes::Node
      property :expr
      def value(*a) ; expr(*a) end

      def initialize(expr)
        super()
        @expr = expr
      end

      def hash
        @expr.hash
      end

      def eql?(other)
        self.class == other.class &&
          self.expr == other.expr
      end
      def ==(o) ; eql?(o) end
    end

    class Bin             < Unary; end 
    class Cube            < Unary; end
    class DistinctOn      < Unary; end
    class Group           < Unary; end
    class GroupingElement < Unary; end
    class GroupingSet     < Unary; end
    class Limit           < Unary; end
    class Lock            < Unary; end
    class Not             < Unary; end
    class Offset          < Unary; end
    class On              < Unary; end
    class Ordering        < Unary; end
    class RollUp          < Unary; end
    class Top             < Unary; end
  end
end
