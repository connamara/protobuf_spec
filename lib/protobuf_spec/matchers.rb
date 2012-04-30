require 'protobuf_spec/matchers/be_protobuf_eql'

module ProtobufSpec
  module Matchers
    def be_protobuf_eql(expected=nil)
      ProtobufSpec::Matchers::BeProtobufEql.new(expected)
    end
  end
end

RSpec.configure do |config|
  config.include(ProtobufSpec::Matchers)
end
