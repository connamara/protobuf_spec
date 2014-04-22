require 'json_spec/messages'

module ProtobufSpec
  module Matchers
    class BeProtobufEql
      include JsonSpec::Messages

      def diffable?
        true
      end

      def initialize(expected_json = nil)
        @json_matcher= JsonSpec::Matchers::BeJsonEql.new expected_json
      end

      def expected
        @json_matcher.expected
      end

      def actual
        @json_matcher.actual
      end

      def at_path(path)
        @path=path
        @json_matcher.at_path path
        self
      end

      def matches?(protobuf)
        @json_matcher.matches? protobuf.to_json
      end

      def failure_message_for_should
        message_with_path("Expected equivalent Protobuf")
      end

      def negative_failure_message
        message_with_path("Expected inequivalent Protobuf")
      end

      def description
        message_with_path("equal Protobuf")
      end
    end
  end
end
