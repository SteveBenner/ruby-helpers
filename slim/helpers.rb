# Slim helpers

# Renders a Slim template in logic-less mode, intended to be used from within another Slim template
# Note: the `dict` parameter is very picky. You can't pass a literal Hash to the function, because
# it won't be parsed correctly for some reason. It must be a single parameter.
def llpartial(name, dict, &block)
	options = {logic_less: true, dictionary: dict}
	Slim::Template.new("_#{name}.slim", options).render(self, block)
end

if defined? ::Rails
	# In Rails we have to use capture!
	# If we are using Slim without a framework (plain Tilt),
	# you can just yield to get the captured block.
	def capture_slim(var, &block)
		set_var = block.binding.eval "lambda {|x| #{var} = x }"
		set_var.call(defined?(::Rails) ? capture(&block) : yield)
	end
else
	# Captures the result of a given Slim block, and stores it into the variable named by given argument
	def capture(var, &block)
		set_var = block.binding.eval "lambda {|x| #{var} = x }"
		set_var.call(yield)
	end
end

# def capture_slim(var, &block)
# 	"#{block}"
# 	# bl = block.binding.eval "lambda {#{block}\n\tdiv}"
# 	# bl.call
# end
#
# def wrap(var, &block)
# 	set_var = block.binding
# 	set_var.call(yield)
# end