# frozen_string_literal: true
require "./node"
require "../predications"
require "../window_predications"
require "../order_predications"
module Arel
  module Nodes
    class Function < Arel::Nodes::Node
      include Arel::Predications
      include Arel::WindowPredications
      include Arel::OrderPredications
      property :expressions, :alias, :distinct

      def initialize(expr, aliaz = nil)
        super()
        @expressions = expr
        @alias       = aliaz && SqlLiteral.new(aliaz)
        @distinct    = false
      end

      def _as(aliaz)
        self.alias = SqlLiteral.new(aliaz)
        self
      end

      def hash
        [@expressions, @alias, @distinct].hash
      end

      def eql?(other)
        self.class == other.class &&
          self.expressions == other.expressions &&
          self.alias == other.alias &&
          self.distinct == other.distinct
      end
    end

    
    class Suma   < Function; end
    class Exists < Function; end
    class Max    < Function; end
    class Min    < Function; end
    class Avg    < Function; end
  end
end
