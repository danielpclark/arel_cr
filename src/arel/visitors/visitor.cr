# frozen_string_literal: true
module Arel
  module Visitors
    class Visitor
      def initialize
        @dispatch = get_dispatch_cache
      end

      def accept(object)
        visit object
      end

      protected def self.dispatch_cache
        Hash(Visitor.class,String).new do |hash, klass|
          hash[klass] = "visit_#{(klass.name || "").gsub("::", "_")}"
        end
      end

      private def get_dispatch_cache
        self.class.dispatch_cache
      end

      private def dispatch
        @dispatch
      end

      private def visit(object)
        send dispatch[object.class], object
      rescue e : NoMethodError
        raise e if respond_to?(dispatch[object.class], true)
        superklass = object.class.ancestors.find { |klass|
          respond_to?(dispatch[klass], true)
        }
        raise(TypeError, "Cannot visit #{object.class}") unless superklass
        dispatch[object.class] = dispatch[superklass]
        retry
      end
    end
  end
end
