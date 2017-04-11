# frozen_string_literal: true
require "./function"
module Arel
  module Nodes
    class NamedFunction < Arel::Nodes::Function
      property :name

      def initialize(name, expr, aliaz = nil)
        super(expr, aliaz)
        @name = name
      end

      def hash
        super ^ @name.hash
      end

      def eql?(other)
        super && self.name == other.name
      end
      def ==(o); eql?(o) end
    end
  end
end
