module ProtobufSpec
  module Matchers
    class BeProtobufEql

      attr_reader :expected_value, :actual

      def initialize(expected_value = nil)
        @expected_value = expected_value
      end

      def at_path(path)
        @path=path
        self
      end

      def matches?(protobuf)
        raise "Expected value not provided" if @expected_value.nil?
        raise "Path not provided" if @path.nil?

        unless protobuf.has_field? @path
          @actual = nil
          return false
        end

        @actual = protobuf[@path]
        protobuf[@path] == @expected_value
      end

      def failure_message_for_should
        if @actual.nil?
          "Expected '#{@expected_value}' at '#{@path}' but '#{@path}' is unset"
        else
          "Expected '#{@expected_value}' at '#{@path}' but got '#{@actual}'"
        end
      end

      def negative_failure_message
        "Didn't expect to find '#{@expected_value}' at '#{@path}'"
      end
    end
  end
end
