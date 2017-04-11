# frozen_string_literal: true
require "./binary"
module Arel
  module Nodes
    class DeleteStatement < Arel::Nodes::Binary
      property :limit

      def relation; left end
      def relation=(v); left=(v) end
      def wheres; right end
      def wheres=(v); right=(v) end

      def initialize(relation = nil, wheres = [] of U) # TODO: Determine Types!
        super
      end

      def initialize_copy(other)
        super
        @right = @right.clone
      end
    end
  end
end
