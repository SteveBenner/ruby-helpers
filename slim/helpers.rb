# Functions extending the capabilities of Slim

# Renders a Slim template in logic-less mode, intended to be used from within another Slim template
# Note: the `dict` parameter is very picky. You can't pass a literal Hash to the function, because
# it won't be parsed correctly for some reason. It must be a single parameter.
def llpartial(name, dict, &block)
  options = {logic_less: true, dictionary: dict}
  Slim::Template.new("_#{name}.slim", options).render(self, block)
end

# 'Capturing', as it is called in the official docs, is a highly convenient form of inline Slim partials
# @see https://github.com/slim-template/slim#helpers-capturing-and-includes
# todo: find a way to remove necessity of declaring the var in the function argument...
# todo: write a thingy to monkey-patch something to ensure capture(&block) is used in Rails
if defined? ::Rails
  # In Rails we have to use capture!
  # If we are using Slim without a framework (plain Tilt),
  # you can just yield to get the captured block.
  def capture_slim(var, &block)
    set_var = block.binding.eval "lambda {|x| #{var} = x }"
    set_var.call(defined?(::Rails) ? capture(block) : yield)
  end
else
  # Captures the result of a given Slim block, and stores it into the variable named by given argument
  def capture(var, &block)
    set_var = block.binding.eval "lambda {|x| #{var} = x }"
    set_var.call(yield)
    '' # Remove this line if you want to actually return the output when called
  end
end

# @return [String] Returns given String prefixed with given spaces
def indent(str, spaces = ' '*2)
  str.gsub /(^..)/, spaces
end

# def capture_slim(var, &block)
# 	# bl = block.binding.eval "lambda {#{block}\n\tdiv}"
# 	# bl.call
# end
#
# def wrap(&block)
# 	set_var = block.binding
# 	set_var.call(yield)
# end
