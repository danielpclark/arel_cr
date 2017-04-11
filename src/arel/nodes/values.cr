# frozen_string_literal: true
require "./binary"
module Arel
  module Nodes
    class Values < Arel::Nodes::Binary
      def expressions;     left      end
      def expressions=(v); left=(v)  end
      def columns;         right     end
      def columns=(v);     right=(v) end

      def initialize(exprs, columns = [] of U) # TODO: Determine Types!
        super
      end
    end
  end
end
