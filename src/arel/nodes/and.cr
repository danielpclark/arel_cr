# frozen_string_literal: true
require "./node"
module Arel
  module Nodes
    class And < Arel::Nodes::Node
      getter :children

      def initialize(children)
        super()
        @children = children
      end

      def left
        children.first
      end

      def right
        children[1]
      end

      def hash
        children.hash
      end

      def eql?(other)
        self.class == other.class &&
          self.children == other.children
      end
      def ==(o); eql?(o) end
    end
  end
end
