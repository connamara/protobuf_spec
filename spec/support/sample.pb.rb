### Generated by rprotoc. DO NOT EDIT!
### <proto file: sample.proto>
# message Sample {
#   optional string string_field = 1;
#   optional int32 int_field = 2;
#   optional double double_field = 3;
# 
#   optional string string_field_2 = 4;
#   optional int32 int_field_2 = 5;
#   optional double double_field_2 = 6;
# 
#   optional string string_field_3 = 7;
#   optional int32 int_field_3 = 8;
#   optional double double_field_3 = 9;
# }

require 'protobuf/message/message'
require 'protobuf/message/enum'
require 'protobuf/message/service'
require 'protobuf/message/extend'

class Sample < ::Protobuf::Message
  defined_in __FILE__
  optional :string, :string_field, 1
  optional :int32, :int_field, 2
  optional :double, :double_field, 3
  optional :string, :string_field_2, 4
  optional :int32, :int_field_2, 5
  optional :double, :double_field_2, 6
  optional :string, :string_field_3, 7
  optional :int32, :int_field_3, 8
  optional :double, :double_field_3, 9
end