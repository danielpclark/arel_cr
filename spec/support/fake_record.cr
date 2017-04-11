# frozen_string_literal: true
module FakeRecord
  class Column 
    property :name, :type
    include Enumerable(String | Symbol)
    def initialize(@name : String, @type : Symbol)
    end
  end

  class Connection
    @columns_hash : Hash(String, Hash(String, Column))
    getter :tables
    property :visitor

    def initialize(visitor : Nil | Arel::Visitors::Visitor | FakeRecord::Connection = nil) # TODO: Verify types
      @tables = %w{ users photos developers products}
      @columns = {
        "users" => [
          Column.new("id", :integer),
          Column.new("name", :string),
          Column.new("bool", :boolean),
          Column.new("created_at", :date)
        ],
        "products" => [
          Column.new("id", :integer),
          Column.new("price", :decimal)
        ]
      }
      @columns_hash = {
        "users" => @columns["users"].map { |x| {x.name, x} }.
          reduce({} of String => Column) {|arr,(k,v)| arr[k]=v; arr},
        "products" => @columns["products"].map { |x| {x.name, x} }.
          reduce({} of String => Column) {|arr,(k,v)| arr[k]=v; arr}
      }
      @primary_keys = {
        "users" => "id",
        "products" => "id"
      }
      @visitor = visitor
    end

    def columns_hash(table_name)
      @columns_hash[table_name]
    end

    def primary_key(name)
      @primary_keys[name.to_s]
    end

    def data_source_exists?(name)
      @tables.include? name.to_s
    end

    def columns(name, message = nil)
      @columns[name.to_s]
    end

    def quote_table_name(name)
      "\"#{name.to_s}\""
    end

    def quote_column_name(name)
      "\"#{name.to_s}\""
    end

    def schema_cache
      self
    end

    def quote(thing)
      case thing
      when DateTime
        %("#{thing.strftime("%Y-%m-%d %H:%M:%S")}")
      when Date
        %("#{thing.strftime("%Y-%m-%d")}")
      when true
        %("t")
      when false
        %("f")
      when nil
        "NULL"
      when Numeric
        thing
      else
        ""#{thing.to_s.gsub(""", "\\\\"")}""
      end
    end
  end

  class ConnectionPool
    class Spec
      property config
      def initialize(@config : NamedTuple(adapter: String))
      end
    end

    getter :spec, :connection

    def initialize
      @spec = Spec.new({adapter: "america"})
      @connection = Connection.new
      @connection.visitor = Arel::Visitors::ToSql.new(connection)
    end

    def with_connection
      yield connection
    end

    def table_exists?(name)
      connection.tables.include? name.to_s
    end

    def columns_hash
      connection.columns_hash
    end

    def schema_cache
      connection
    end

    def quote(thing)
      connection.quote thing
    end
  end

  class Base
    property :connection_pool

    def initialize
      @connection_pool = ConnectionPool.new
    end

    def connection
      connection_pool.connection
    end
  end
end
