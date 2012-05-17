Feature: Equivalence
  Background:
    Given I create the following ProtoBuf of type "Sample":
    """
    {
      "string_field": "foo",
      "int_field": 5,    
      "double_field": 50.23,    
      "int_field_2": -9    
    }
    """

    Scenario: String
    When I get the ProtoBuf
    Then the ProtoBuf at "string_field" should be "foo"
    Then the ProtoBuf at "string_field" should not be "bar"
    Then the ProtoBuf at "string_field_2" should not be "bar"
    Then the ProtoBuf at "string_field_2" should not be ""

    Scenario: Integer
    When I get the ProtoBuf
    Then the ProtoBuf at "int_field" should be 5
    Then the ProtoBuf at "int_field" should not be 15

    Then the ProtoBuf at "int_field_2" should be -9
    Then the ProtoBuf at "int_field_2" should not be -19

    Then the ProtoBuf at "int_field_3" should not be 0

    Scenario: Double
    When I get the ProtoBuf
    Then the ProtoBuf at "double_field" should be 50.23
    Then the ProtoBuf at "double_field" should not be -15.45
