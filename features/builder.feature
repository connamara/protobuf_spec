Feature: Building ProtoBufs
    Scenario: I can create a blank protocol buffer
      Given I create a ProtoBuf of type "Sample"
      When I get the ProtoBuf
      Then the ProtoBuf should not have "string_field"
      Then the ProtoBuf should not have "int_field"
      Then the ProtoBuf should not have "double_field"

    Scenario: I can set values of the protocol buffer
      Given I create a ProtoBuf of type "Sample"
      And I set the ProtoBuf at "string_field" to "hello"
      And I set the ProtoBuf at "int_field" to -5
      And I set the ProtoBuf at "double_field" to 123.45
      When I get the ProtoBuf
      Then the ProtoBuf at "string_field" should be "hello"
      And the ProtoBuf at "int_field" should be -5
      And the ProtoBuf at "double_field" should be 123.45

    Scenario: I can create a protobuf with a json description
      Given I create the following ProtoBuf of type "Sample":
      """
      {
        "string_field": "foo",
        "int_field": 5,    
        "double_field": 50.23,    
        "int_field_2": -9    
      }
      """

      When I get the ProtoBuf
      Then the ProtoBuf at "string_field" should be "foo"
      And the ProtoBuf at "int_field" should be 5
      And the ProtoBuf at "double_field" should be 50.23
      And the ProtoBuf at "int_field_2" should be -9
