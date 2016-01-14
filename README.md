protobuf\_spec [![Build Status](https://travis-ci.org/connamara/protobuf_spec.png)](https://travis-ci.org/connamara/protobuf_spec)
=============

RSpec matchers and Cucumber step definitions for testing Protocol Buffers using [json_spec](https://github.com/collectiveidea/json_spec)

Usage
-----

### RSpec

protobuf\_spec currently defines two matchers:

* ```be_protobuf_eql```
* ```have_protobuf_path```

The matchers can be used as their counterparts are used in json\_spec


### Cucumber

protobuf\_spec provides cucumber steps that use its RSpec matchers.

In order to use the Cucumber steps, in your ```env.rb``` you must:

```ruby
require "protobuf_spec/cucumber"
```

You will need to load the ruby_protobuf generated classes you intend to test.  This can be done by generating the classes into the cucumber ```support/``` directory, or requiring them manually.

#### "Should" Assertions 

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
    And the ProtoBuf should be:
    """
    {
      "condition":"sunny",
      "temperature":58
    }
    """

  Scenario: I can check if I need an umbrella
    When I request the forecast for Chicago
    Then I should receive a ProtoBuf of type com.weather.ForecastResponse
    And the ProtoBuf should have "bring_umbrella"
    And the ProtoBuf at "bring_umbrella" should be true
```

The background and request/receive steps above aren't provided by protobuf_spec.  The remaining steps protobuf_spec provides.  See [json_spec documentation](https://github.com/collectiveidea/json_spec) for more examples

#### Building Protobufs

In order to use the Cucumber steps for building protocol buffers, in your ```env.rb``` you must:

```ruby
require "protobuf_spec/builder"
```
Now you can use proto_spec builder steps in your features:

```cucumber
Feature: Weather Request API
  Background: 
    Given the weather is 58 degrees and cloudy in Chicago
    And the weather is 72 degrees and sunny in Portland

  Scenario: I can request the weather for a city by protocol buffer
    Given I create a ProtoBuf of type "com::weather::WeatherRequest"
    And I set the ProtoBuf at "city" to "Portland"
    And I set the ProtoBuf at "zipcode" to 97211    
    When I send the request
    Then I should receive a ProtoBuf of type com::weather::WeatherResponse
    And the ProtoBuf at "condition" should be "sunny"
    And the ProtoBuf at "temperature" should be 72

    Given I create the following protobuf of type "com::weather::WeatherRequest":
    """
    {
      "city": "Chicago",
      "zipcode": 60606    
    }
    """
    When I send the request
    Then I should receive a ProtoBuf of type com::weather::WeatherResponse
    And the ProtoBuf at "condition" should not be "sunny"
    And the ProtoBuf at "temperature" should be 58
```

The built protocol buffer can be accessed through the ```protobuf``` function in the ```ProtobufSpec::Builder``` module.

### Testing with a Transport Layer

Normally you will pair a serialization method like Protocol Buffers with a transport layer in systems that send and receive serialized data. protobuf\_spec can easily integrated with a transport testing platform to test such systems.  Consider again the weather example presented above.  If the weather server used [ZeroMQ](http://zeromq.org) as a transport layer, one could use an agent platform like [agent_zmq](https://github.com/connamara/agent_zmq) to test and control the transport concern.  Using agent\_zmq, we could construct the following step definitions

```ruby
When /^I send the request$/ do
  AgentZeroMQ.agents_hash[:requester].publish [ProtobufSpec::Builder.protobuf.serialize_to_string]
end

Then /^I should receive a ProtoBuf of type com::weather::WeatherResponse$/
  steps %{Then I should receive a response on ZeroMQ with agent "requester"}

  @my_protocol_buffer=Com::weather::WeatherResponse.new
  @my_protocol_buffer.parse_from_string last_zmq_message.last
end

...
```

See [agent_zmq](https://github.com/connamara/agent_zmq) for additional information.  A similar abstraction could be applied to any other transport layer. 

### More

Check out [specs](https://github.com/connamara/protobuf_spec/blob/master/spec) and [features](https://github.com/connamara/protobuf_spec/blob/master/features) to see all the ways you can use protobuf_spec.

Install
-------

```shell
gem install protobuf_spec
```

or add the following to Gemfile:
```ruby
gem 'protobuf_spec'
```
and run `bundle install` from your shell.

More Information
----------------

* [Rubygems](https://rubygems.org/gems/protobuf_spec)
* [Issues](https://github.com/connamara/protobuf_spec/issues)
* [Connamara Systems](http://connamara.com)

Contributing
------------

Please see the [contribution guidelines](https://github.com/connamara/protobuf_spec/blob/master/CONTRIBUTION_GUIDELINES.md).

Credits
-------

Contributers:

* [Chris Busbey](https://github.com/cbusbey)
* [Mike Gatny](https://github.com/mgatny)

![Connamara Systems](http://www.connamara.com/wp-content/uploads/2016/01/connamara_logo_dark.png)

protobuf_spec is maintained and funded by [Connamara Systems, llc](http://connamara.com).

The names and logos for Connamara Systems are trademarks of Connamara Systems, llc.

Licensing
---------

protobuf_spec is Copyright © 2016 Connamara Systems, llc. 

This software is available under the GPL and a commercial license.  Please see the [LICENSE](https://github.com/connamara/protobuf_spec/blob/master/LICENSE.txt) file for the terms specified by the GPL license.  The commercial license offers more flexible licensing terms compared to the GPL, and includes support services.  [Contact us](mailto:info@connamara.com) for more information on the Connamara commercial license, what it enables, and how you can start developing with it.
