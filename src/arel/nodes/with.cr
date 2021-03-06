# frozen_string_literal: true
require "./unary"
module Arel
  module Nodes
    class With < Arel::Nodes::Unary
      def children; expr end
    end

    class WithRecursive < With; end
  end
end

