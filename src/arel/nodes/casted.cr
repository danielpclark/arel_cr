# frozen_string_literal: true
require "./node"
require "./unary"
module Arel
  module Nodes
    class Casted < Arel::Nodes::Node # :nodoc:
      getter :val, :attribute
      def initialize(val, attribute)
        @val       = val
        @attribute = attribute
        super()
      end

      def is_nil?; @val.nil?; end

      def hash
        [self.class, val, attribute].hash
      end

      def eql?(other)
        self.class == other.class &&
            self.val == other.val &&
            self.attribute == other.attribute
      end
      def ==(o); eql? o end
    end

    class Quoted < Arel::Nodes::Unary # :nodoc:
      def val; value end
      def is_nil?; val.nil?; end
    end

    def self.build_quoted(other, attribute = nil)
      case other
        when Arel::Nodes::Node, Arel::Attributes::Attribute, Arel::Table, Arel::Nodes::BindParam, Arel::SelectManager, Arel::Nodes::Quoted
          other
        else
          case attribute
            when Arel::Attributes::Attribute
              Casted.new other, attribute
            else
              Quoted.new other
          end
      end
    end
  end
end
