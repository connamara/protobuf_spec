require File.expand_path("../../protobuf_spec", __FILE__)
require 'cuke_mem'

World(JsonSpec::Helpers, JsonSpec::Matchers)
World(ProtobufSpec::Matchers)

When /^(?:I )?keep the (?:ProtoBuf|protobuf|Protobuf)(?: response)?(?: at "(.*)")? as "(.*)"$/ do |path, key|
  CukeMem.memorize(key, normalize_json(last_protobuf.to_json, path))
end

Then /^the (?:ProtoBuf|Protobuf|protobuf)(?: response)?(?: at "(.*)")? should( not)? include:$/ do |path, negative, json|
  if negative
    last_protobuf.to_json.should_not include_json(CukeMem.remember(json)).at_path(path)
  else
    last_protobuf.to_json.should include_json(CukeMem.remember(json)).at_path(path)
  end
end

Then /^the (?:ProtoBuf|Protobuf|protobuf)(?: response)?(?: at "(.*)")? should( not)? include (".*"|\-?\d+(?:\.\d+)?(?:[eE][\+\-]?\d+)?|\[.*\]|%?\{.*\}|true|false|null)$/ do |path, negative, value|
  if negative
    last_protobuf.to_json.should_not include_json(CukeMem.remember(value)).at_path(path)
  else
    last_protobuf.to_json.should include_json(CukeMem.remember(value)).at_path(path)
  end
end

Then /^the (?:ProtoBuf|Protobuf|protobuf)(?: response)?(?: at "(.*)")? should( not)? be:$/ do |path, negative, json|
  if negative
    last_protobuf.to_json.should_not be_json_eql(CukeMem.remember(json)).at_path(path)
  else
    last_protobuf.to_json.should be_json_eql(CukeMem.remember(json)).at_path(path)
  end
end

Then /^the (?:ProtoBuf|Protobuf|protobuf)(?: response)?(?: at "(.*)")? should( not)? be (".*"|\-?\d+(?:\.\d+)?(?:[eE][\+\-]?\d+)?|\[.*\]|%?\{.*\}|true|false|null)$/ do |path, negative, value|
  if negative
    last_protobuf.to_json.should_not be_json_eql(CukeMem.remember(value)).at_path(path)
  else
    last_protobuf.to_json.should be_json_eql(CukeMem.remember(value)).at_path(path)
  end
end

Then /^the (?:ProtoBuf|Protobuf|protobuf)(?: response)?(?: at "(.*)")? should have the following:$/ do |base, table|
  table.rows.each do |path, value|
    path = [base, path].compact.join("/")

    if value
      step %(the protobuf at "#{path}" should be:), value
    else
      step %(the protobuf should have "#{path}")
    end
  end
end



Then /^the (?:ProtoBuf|Protobuf|protobuf)(?: response)? should( not)? have "(.*)"$/ do |negative, path|
  if negative
    last_protobuf.should_not have_protobuf_path(path)
  else
    last_protobuf.should have_protobuf_path(path)
  end
end


When /^I save the serialized (?:ProtoBuf|Protobuf|protobuf) as "([^"]*)"$/ do |key|
  CukeMem.memorize key, last_protobuf.serialize_to_string
end

