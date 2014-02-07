require 'cuke_mem'

module ProtobufSpec
module Builder 
  def self.protobuf
    @protobuf
  end

  def self.protobuf= protobuf
    @protobuf=protobuf 
  end
end

end

Given /^I create a (?:ProtoBuf|Protobuf|protobuf) of type "([^"]*)"$/ do |proto_type|
  ProtobufSpec::Builder.protobuf = eval("#{proto_type}.new") 
end

Given /^I set the (?:ProtoBuf|Protobuf|protobuf) at "([^"]*)" to "([^"]*)"$/ do |field, val|
  ProtobufSpec::Builder.protobuf.send("#{field}=".to_sym, val)
end

Given /^I set the (?:ProtoBuf|Protobuf|protobuf) at "([^"]*)" to (-?\d+)$/ do |field, val|
  ProtobufSpec::Builder.protobuf.send("#{field}=".to_sym, val.to_i)
end

Given /^I set the (?:ProtoBuf|Protobuf|protobuf) at "([^"]*)" to (-?\d+\.\d+)$/ do |field, val|
  ProtobufSpec::Builder.protobuf.send("#{field}=".to_sym, val.to_f)
end

Given /^I set the (?:ProtoBuf|Protobuf|protobuf) at "([^"]*)" to (-?true|false)$/ do |field, val|
  ProtobufSpec::Builder.protobuf.send("#{field}=".to_sym, val == "true")
end

Given /^I create the following (?:ProtoBuf|Protobuf|protobuf) of type "([^"]*)":$/ do |proto_type, proto_as_json|
  steps %{Given I create a ProtoBuf of type "#{proto_type}"}

  json = JSON.parse proto_as_json
  ProtobufSpec::Builder.protobuf.fields.each_value do |field| 
    field_name = field.name.to_s
    ProtobufSpec::Builder.protobuf[field_name] = json[field_name] if json.has_key? field_name
  end
end

When /^I deserialize a (?:ProtoBuf|Protobuf|protobuf) of type "([^"]*)" from "([^"]*)"$/ do |proto_type, serial|
  steps %{Given I create a ProtoBuf of type "#{proto_type}"}
  ProtobufSpec::Builder.protobuf.parse_from_string CukeMem.remember(serial)
end

