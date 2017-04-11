# frozen_string_literal: true
require "../spec_helper"

module Arel
  module Nodes
    describe "As" do
      describe "#as" do
        it "makes an AS node" do
          attr = Table.new(:users)[:id]
          _as = attr._as(Arel.sql("foo"))
          assert_equal attr, _as.left
          assert_equal "foo", _as.right
        end

        it "converts right to SqlLiteral if a string" do
          attr = Table.new(:users)[:id]
          _as = attr._as("foo")
          assert_kind_of Arel::Nodes::SqlLiteral, _as.right
        end
      end

      describe "equality" do
        it "is equal with equal ivars" do
          array = [As.new("foo", "bar"), As.new("foo", "bar")]
          assert_equal 1, array.uniq.size
        end

        it "is not equal with different ivars" do
          array = [As.new("foo", "bar"), As.new("foo", "baz")]
          assert_equal 2, array.uniq.size
        end
      end
    end
  end
end
