# frozen_string_literal: true
require "./node"
module Arel
  module Nodes
    class Binary < Arel::Nodes::Node
      property :left, :right

      def initialize(@left, @right)
        super()
      end

      def initialize_copy(other)
        super
        @left  = @left.clone if @left
        @right = @right.clone if @right
      end

      def hash
        [self.class, @left, @right].hash
      end

      def eql?(other)
        self.class == other.class &&
          self.left == other.left &&
          self.right == other.right
      end
      def ==(o); eql?(o) end
    end

    class As                 < Binary; end  
    class Assignment         < Binary; end 
    class Between            < Binary; end 
    class GreaterThan        < Binary; end 
    class GreaterThanOrEqual < Binary; end
    class Join               < Binary; end 
    class LessThan           < Binary; end 
    class LessThanOrEqual    < Binary; end 
    class NotEqual           < Binary; end 
    class NotIn              < Binary; end 
    class Or                 < Binary; end 
    class Union              < Binary; end 
    class UnionAll           < Binary; end 
    class Intersect          < Binary; end 
    class Except             < Binary; end 
  end
end
