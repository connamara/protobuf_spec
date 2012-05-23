Feature: Equivalence
  Background:
    Given I create the following ProtoBuf of type "Sample":
    """
    {
      "string_field": "foo",
      "int_field": 5,    
      "double_field": 50.23,    
      "int_field_2": -9,    
      "bool_field": true,
      "bool_field_2": false
    }
    """

    Scenario: Identical Protobuf
    When I get the ProtoBuf
    Then the Protobuf should be:
    """
    {
      "string_field": "foo",
      "int_field": 5,    
      "double_field": 50.23,    
      "int_field_2": -9,    
      "bool_field": true,
      "bool_field_2": false
    }
    """

    Scenario: String
    When I get the ProtoBuf
    Then the ProtoBuf at "string_field" should be "foo"
    Then the protobuf at "string_field" should be:
    """
    "foo"
    """
    Then the ProtoBuf at "string_field" should not be "bar"

    Scenario: Integer
    When I get the ProtoBuf
    Then the ProtoBuf at "int_field" should be 5
    Then the ProtoBuf at "int_field" should not be 15


    Scenario: Negative Integer
    When I get the ProtoBuf
    Then the ProtoBuf at "int_field_2" should be -9
    Then the ProtoBuf at "int_field_2" should not be -19

    Scenario: Double
    When I get the ProtoBuf
    Then the ProtoBuf at "double_field" should be 50.23
    And the ProtoBuf at "double_field" should be 50.23e0
    And the ProtoBuf at "double_field" should be 50.23e+0
    And the ProtoBuf at "double_field" should be 50.23e-0
    And the ProtoBuf at "double_field" should be 50.23e0
    And the ProtoBuf at "double_field" should be 50.23e+0
    And the ProtoBuf at "double_field" should be 50.23e-0
    And the ProtoBuf at "double_field" should be 5.023e1
    And the ProtoBuf at "double_field" should be 5.023e+1
    And the ProtoBuf at "double_field" should be 502.3e-1
    And the ProtoBuf at "double_field" should be:
      """
      50.23
      """
    
    Then the ProtoBuf at "double_field" should not be -15.45

    Scenario: True
    When I get the ProtoBuf
    Then the protobuf at "bool_field" should be true
    Then the protobuf at "bool_field" should be:
    """
    true
    """
    Then the protobuf at "bool_field" should not be false

    Scenario: False
    When I get the ProtoBuf
    Then the protobuf at "bool_field_2" should be false
    Then the protobuf at "bool_field_2" should be:
    """
    false
    """
    Then the protobuf at "bool_field_2" should not be true

    Scenario: Table format
    When I get the ProtoBuf
    Then the protobuf should have the following:
    | string_field    |  "foo"  |
    | int_field       | 5       |    
    | double_field    | 50.23   |    
    | int_field_2     | -9      |
    | bool_field      | true    |
    | bool_field_2    | false   |

