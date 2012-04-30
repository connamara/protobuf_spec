Given /^the ProtoBuf is:$/ do |proto_as_json|
  json = JSON.parse proto_as_json

  @protobuf=Sample.new
  @protobuf.fields.each_value do |field| 
    field_name = field.name.to_s
    @protobuf[field_name] = json[field_name] if json.has_key? field_name
  end
end

When /^I get the ProtoBuf$/ do
  @last_protobuf=@protobuf
end
