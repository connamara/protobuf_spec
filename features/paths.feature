Feature: Paths
  Background:
    Given the ProtoBuf is:
    """
    {
      "string_field": "foo",
      "int_field": 5    
    }
    """

    Scenario: Base paths
    When I get the ProtoBuf
    Then the ProtoBuf should have "string_field"
    Then the ProtoBuf should have "int_field"
    Then the ProtoBuf should not have "double_field"
