Feature: Memory 
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
    And I get the Protobuf

  Scenario: Entire Protobuf
    When I keep the Protobuf as "PROTO"
    Then the Protobuf should be %{PROTO}
    And the Protobuf should be:
      """
      %{PROTO}
      """

  Scenario: String
    When I keep the ProtoBuf at "string_field" as "STRING"
    Then the ProtoBuf at "string_field" should be %{STRING}
    And the ProtoBuf should be:
    """
    {
      "string_field": %{STRING},
      "int_field": 5,    
      "double_field": 50.23,    
      "int_field_2": -9,    
      "bool_field": true,
      "bool_field_2": false
    }
    """

  Scenario: Integer
    When I keep the ProtoBuf at "int_field" as "INTEGER"
    Then the ProtoBuf at "int_field" should be %{INTEGER}
    And the ProtoBuf should be:
    """
    {
      "string_field": "foo",
      "int_field": %{INTEGER},    
      "double_field": 50.23,    
      "int_field_2": -9,    
      "bool_field": true,
      "bool_field_2": false
    }
    """

  Scenario: Double
    When I keep the ProtoBuf at "double_field" as "DOUBLE"
    Then the ProtoBuf at "double_field" should be %{DOUBLE}
    And the ProtoBuf should be:
    """
    {
      "string_field": "foo",
      "int_field": 5,    
      "double_field": %{DOUBLE},    
      "int_field_2": -9,    
      "bool_field": true,
      "bool_field_2": false
    }
    """

  Scenario: True
    When I keep the ProtoBuf at "bool_field" as "TRUE"
    Then the ProtoBuf at "bool_field" should be %{TRUE}
    And the ProtoBuf should be:
    """
    {
      "string_field": "foo",
      "int_field": 5,    
      "double_field": 50.23,    
      "int_field_2": -9,    
      "bool_field": %{TRUE},
      "bool_field_2": false
    }
    """

  Scenario: False
    When I keep the ProtoBuf at "bool_field_2" as "FALSE"
    Then the ProtoBuf at "bool_field_2" should be %{FALSE}
    And the ProtoBuf should be:
    """
    {
      "string_field": "foo",
      "int_field": 5,    
      "double_field": 50.23,    
      "int_field_2": -9,    
      "bool_field": true,
      "bool_field_2": %{FALSE}
    }
    """

  Scenario: Table format
    When I keep the ProtoBuf at "string_field" as "STRING"
    And I keep the ProtoBuf at "int_field" as "INTEGER"
    And I keep the ProtoBuf at "double_field" as "DOUBLE"
    And I keep the ProtoBuf at "bool_field" as "TRUE"
    And I keep the ProtoBuf at "bool_field_2" as "FALSE"
    Then the ProtoBuf should have the following:
      | string_field  | %{STRING}  |
      | int_field     | %{INTEGER} |
      | double_field  | %{DOUBLE}   |
      | bool_field    | %{TRUE}    |
      | bool_field_2  | %{FALSE}   |

  Scenario: Inclusion
    When I keep the ProtoBuf at "string_field" as "STRING"
    And I keep the ProtoBuf at "int_field" as "INTEGER"
    And I keep the ProtoBuf at "double_field" as "DOUBLE"
    And I keep the ProtoBuf at "bool_field" as "TRUE"
    And I keep the ProtoBuf at "bool_field_2" as "FALSE"
    Then the ProtoBuf should include %{STRING}
    Then the ProtoBuf should include %{INTEGER}
    Then the ProtoBuf should include %{DOUBLE}
    Then the ProtoBuf should include %{TRUE}
    Then the ProtoBuf should include %{FALSE}

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
