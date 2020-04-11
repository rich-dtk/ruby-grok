$: << File.join(File.dirname(__FILE__), "lib")
require 'grok-pure'
require 'byebug'

class Test
  def initialize
    @grok = Grok.new
    path = "#{File.dirname(__FILE__)}/../patterns/pure-ruby/base"
    byebug
    @grok.add_patterns_from_file(path)
  end
  
  def test_multiline
    @grok.compile("hello%{GREEDYDATA}")
    match = @grok.match("hello world \nthis is fun")
    pp match.captures
    
    match = @grok.match("hello world this is fun")
    pp match.captures
  end
end
Test.new.test_multiline
