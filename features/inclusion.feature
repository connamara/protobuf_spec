Feature: Inclusion
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

    Scenario: String
    When I get the ProtoBuf
    Then the ProtoBuf should include "foo"
    Then the ProtoBuf should include:
    """
    "foo"
    """

 Scenario: Integer
    When I get the ProtoBuf
    Then the ProtoBuf should include 5
    And the ProtoBuf should include:
      """
      5
      """

  Scenario: Negative integer
    When I get the ProtoBuf
    Then the ProtoBuf should include -9
    And the ProtoBuf should include:
      """
      -9
      """

  Scenario: Double
    When I get the ProtoBuf
    Then the ProtoBuf should include 50.23
    And the ProtoBuf should include 50.23e0
    And the ProtoBuf should include 50.23e+0
    And the ProtoBuf should include 50.23e-0
    And the ProtoBuf should include 50.23e0
    And the ProtoBuf should include 50.23e+0
    And the ProtoBuf should include 50.23e-0
    And the ProtoBuf should include 5.023e1
    And the ProtoBuf should include 5.023e+1
    And the ProtoBuf should include 502.3e-1
    And the ProtoBuf should include:
      """
      50.23
      """
    
    Then the ProtoBuf should not include -15.45
    
    Scenario: True
    When I get the ProtoBuf
    Then the protobuf should include true
    Then the protobuf should include:
    """
    true
    """

    Scenario: False
    When I get the ProtoBuf
    Then the protobuf should include false
    Then the protobuf should include:
    """
    false
    """
