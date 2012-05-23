When /^I get the (?:ProtoBuf|protobuf|Protobuf)$/ do
  @last_protobuf=ProtobufSpec::Builder.protobuf
end
