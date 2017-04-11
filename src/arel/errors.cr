# frozen_string_literal: true
module Arel
  class ArelError < Exception
  end

  class EmptyJoinError < ArelError
  end
end
