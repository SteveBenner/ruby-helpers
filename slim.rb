# Slim helpers

# Renders a Slim template in logic-less mode, intended to be used from within another Slim template
def llpartial(name, dict, &block)
	options = {logic_less: true, dictionary: dict}
	Slim::Template.new("_#{name}.slim", options).render(self, block)
end