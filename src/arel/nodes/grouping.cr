# frozen_string_literal: true
require "./unary"
require "../predications"
module Arel
  module Nodes
    class Grouping < Unary
      include Arel::Predications
    end
  end
end
