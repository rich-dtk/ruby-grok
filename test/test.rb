$: << File.join(File.dirname(__FILE__), "lib")
require 'grok-pure'
require 'byebug'

class Test
  def initialize
    @grok = Grok.new
    path = "#{File.dirname(__FILE__)}/../patterns/pure-ruby/base"
    @grok.add_patterns_from_file(path)
    @grok.add_pattern('SYMBOL_VALUE', "[0-9']+")
    @grok.add_pattern('ACNTST_C', 'ACNTST C : %{SYMBOL_VALUE:data}')
    @grok.add_pattern('ACNTST_C_HVA', 'ACNTST C HVA : %{SYMBOL_VALUE:data}')
    @input = File.read("#{File.dirname(__FILE__)}/input")
  end
  
  def match(pattern)
    @grok.compile("%{#{pattern}}")
    if match = @grok.match(@input)
      pp match.captures
    else
      fail "Cannot match pattern '#{pattern}'"
    end
  end
end
test_helper = Test.new
test_helper.match('ACNTST_C')
test_helper.match('ACNTST_C_HVA')
