# frozen_string_literal: true
require "./join_source"
module Arel
  module Nodes
    class StringJoin < Arel::Nodes::Join
      def initialize(left, right = nil)
        super
      end
    end
  end
end
