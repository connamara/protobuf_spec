protobuf_spec
=============

RSpec matchers and Cucumber step definitions for testing Protocol Buffers

Setup
-----

    bundle install

Test
----

    rake spec
    rake cucumber

RSpec
-----

protobuf_spec currently defines one matcher:

* ```be_protobuf_eql```


The matcher can be used as follows:

```ruby
describe ProtobufSpec::Matchers::BeProtobufEql do
  before(:each) do
    @sample = Sample.new
    @sample.string_field="foo"
  end

  it "matches at a path"  do
    @sample.should be_protobuf_eql("foo").at_path("string_field")
  end

  it "doesn't match for unset path"  do
    @sample.should_not be_protobuf_eql("").at_path("string_field_2")
  end
end
```

Cucumber
--------

protobuf_spec provides cucumber steps that use its RSpec matchers.


In order to use the Cucumber steps, in your ```env.rb``` you must:

```ruby
require "protobuf_spec/cucumber"
```

You will need to load the ruby_protobuf generated classes you intend to test.  This can be done by generating the classes into the cucumber ```support/``` directory, or requiring them manually.

### "Should" Assertions 

In order to test the contents of a Protocol Buffer, you will need to define a ```last_protobuf``` method.  This method should return the protocol buffer to be tested by a protobuf_spec Cucumber step. 

For example, suppose a step that aquires a Protocol Buffer and assigns it to ```@my_protocol_buffer```.  In your ```features/support/env.rb``` you could then have

```ruby
def last_protobuf
  @my_protocol_buffer
end
```

See ```features/support/env.rb``` for a very simple implementation.

Now you can use proto_spec steps in your features:


```cucumber
Feature: Weather API
  Background: 
    Given the weather is 58 degrees and cloudy in Chicago
    And the weather is 72 degrees and sunny in Portland

  Scenario: I can request the weather for a city
    When I request weather for Portland
    Then I should receive a ProtoBuf of type com.weather.WeatherResponse
    And the ProtoBuf at "condition" should be "sunny"
    And the ProtoBuf at "temperature" should be 72

    When I request weather for Chicago
    Then I should receive a ProtoBuf of type com.weather.WeatherResponse
    And the ProtoBuf at "condition" should not be "sunny"
    And the ProtoBuf at "temperature" should be 58

  Scenario: I can check if I need an umbrella
    When I request the forecast for Chicago
    Then I should receive a ProtoBuf of type com.weather.ForecastResponse
    And the ProtoBuf should have "bring_umbrella"
    And the ProtoBuf at "bring_umbrella" should be true
```

### Building Protobufs

In order to use the Cucumber steps for building protocol buffers, in your ```env.rb``` you must:

```ruby
require "protobuf_spec/protobuf_builder"
```
Now you can use proto_spec builder steps in your features:

```cucumber
Feature: Weather Request API
  Background: 
    Given the weather is 58 degrees and cloudy in Chicago
    And the weather is 72 degrees and sunny in Portland

  Scenario: I can request the weather for a city by protocol buffer
    Given I create a ProtoBuf of type "com.weather.WeatherRequest"
    And I set the ProtoBuf at "city" to "Portland"
    And I set the ProtoBuf at "zipcode" to 97211    
    When I request weather for Portland
    Then I should receive a ProtoBuf of type com.weather.WeatherResponse
    And the ProtoBuf at "condition" should be "sunny"
    And the ProtoBuf at "temperature" should be 72
```

The built protocol buffer can be accessed through the ```protobuf``` function in the ```ProtobufSpec::ProtobufBuilder``` module.


