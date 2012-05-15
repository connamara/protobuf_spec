protobuf_spec
=============

RSpec matchers and cucumber step defs for testing protocol buffers


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


In order to use the Cucumber steps, in your `env.rb` you must:

```ruby
require "protobuf_spec/cucumber"
```

You will need to load the ruby_protobuf generated classes you intend to test.  This can be done by generating the classes into the cucumber ```support/``` directory, or requiring them manually.

You also need to define a `last_protobuf` method. 

See ```features/``` for example usage
