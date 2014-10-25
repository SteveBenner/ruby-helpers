# Capistrano DSL additions (probably outdated!)

# Allows one to specify the working directory for command execution
def execute_at(path, cmd)
	execute "cd #{path} && #{cmd}"
end