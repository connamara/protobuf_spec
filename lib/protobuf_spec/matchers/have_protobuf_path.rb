module ProtobufSpec
  module Matchers
    class HaveProtobufPath
      attr_reader :path
      def initialize path
        @path = path
        @json_matcher = JsonSpec::Matchers::HaveJsonPath.new path
      end

      def matches? proto
        @json_matcher.matches? proto.to_json
      end

      def failure_message_for_should
        %(Expected Protobuf path "#{@path}")
      end

      def failure_message_for_should_not
        %(Expected no Protobuf path "#{@path}")
      end

      def description
        %(have Protobuf path "#{@path}")
      end
    end
  end
end
