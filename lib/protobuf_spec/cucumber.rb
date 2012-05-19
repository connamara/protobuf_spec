require File.expand_path("../../protobuf_spec", __FILE__)

World(ProtobufSpec::Matchers)

def test_protobuf_val_at_path(path, negative, value)
  if negative
    last_protobuf[path].should_not == value if last_protobuf.has_field? path
  else
    last_protobuf.should be_protobuf_eql(value).at_path(path)
  end
end

Then /^the (?:ProtoBuf|Protobuf|protobuf) at "([^"]*)" should( not)? be (\-?\d+|\-?\d+\.\d+)$/ do |path, negative, value|
  test_protobuf_val_at_path(path, negative, value.to_f)
end


Then /^the (?:ProtoBuf|Protobuf|protobuf) at "([^"]*)" should( not)? be "([^"]*)"$/ do |path, negative, value|
  test_protobuf_val_at_path(path, negative, value)
end

Then /^the (?:ProtoBuf|Protobuf|protobuf) at "([^"]*)" should( not)? be (true|false)$/ do |path, negative, value|
  test_protobuf_val_at_path(path, negative, (value == "true"))
end



Then /^the (?:ProtoBuf|Protobuf|protobuf) should( not)? have "([^"]*)"$/ do |negative, path|
  if negative
    last_protobuf.should_not have_field(path)
  else
    last_protobuf.should have_field(path)
  end
end
