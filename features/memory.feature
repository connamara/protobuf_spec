Feature: Protobuf spec memory
  Scenario: I can store the serialized form of a protocol buffer in cuke_mem
    Given I create a ProtoBuf of type "Sample"
    And I set the ProtoBuf at "string_field" to "hello"
    And I set the ProtoBuf at "int_field" to -5
    And I set the ProtoBuf at "double_field" to 123.45
    And I get the ProtoBuf
    When I save the serialized ProtoBuf as "SERIALIZED"
    And I deserialize a Protobuf of type "Sample" from "%{SERIALIZED}"
    And I get the ProtoBuf
    Then the ProtoBuf at "string_field" should be "hello"
    And the ProtoBuf at "int_field" should be -5
    And the ProtoBuf at "double_field" should be 123.45
