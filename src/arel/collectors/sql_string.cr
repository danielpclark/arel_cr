# encoding: utf-8
# frozen_string_literal: true

require "./plain_string"

module Arel
  module Collectors
    class SQLString < PlainString
      def initialize(*opts)
        super
        @bind_index = 1
      end

      def add_bind(bind)
        self << yield(@bind_index)
        @bind_index += 1
        self
      end

      def compile(bvs)
        value
      end
    end
  end
end
