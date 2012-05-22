require 'protobuf_spec/matchers/be_protobuf_eql'
require 'protobuf_spec/matchers/have_protobuf_path'

module ProtobufSpec
  module Matchers
    def be_protobuf_eql(expected=nil)
      ProtobufSpec::Matchers::BeProtobufEql.new(expected)
    end

    def have_protobuf_path(path)
      ProtobufSpec::Matchers::HaveProtobufPath.new(path)
    end
  end
end

RSpec.configure do |config|
  config.include(ProtobufSpec::Matchers)
end
