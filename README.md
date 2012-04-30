protobuf_spec
=============

RSpec matchers and cucumber step defs for testing protocol buffers

Cucumber
--------

protobuf_spec provides cucumber steps that use its RSpec matchers.


In order to use the Cucumber steps, in your `env.rb` you must:

```ruby
require "protobuf_spec/cucumber"
```

You will need to load the ruby_protobuf generated classes you intend to test.  This can be done by generating the classes intothe cucumber support/ directory, or requiring them manually.

You also need to define a `last_protouf` method. 
