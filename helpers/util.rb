# Miscellaneous utility functions

# Generates copyright text from a name, using the current year as default date.
#
# @param name       [String]  Legal entity which holds the copyright
# @param start_date [Integer] Begin year for copyright
# @param end_date   [Integer] End year for copyright
#
def copyright(name, start_date=Time.now.year, end_date=Time.now.year)
	"Copyright © #{start_date}-#{end_date} #{name}. All rights reserved."
end

# @author Nathan Henderson <nathos@nathos.com>
# @return [String] Beginning and ending years for a Copyright
def copyright_from(start_year)
  end_year = Date.today.year
  (start_year == end_year) ? start_year.to_s : "#{start_year}-#{end_year}"
end

# @author Fabien Piuzzi <http://demenzia.net/>
# @return [String] The current date
def display_date(date)
	# See {Date#strftime} for complete formatting documentation
	if date.is_a?(Date)
		date.strftime("%e %B %Y")
	else
		date
	end
end

# @author Fabien Piuzzi <http://demenzia.net/>
# @return [String] Current age of person who'se birthday was given
def display_age(birthday)
	now = Date.today
	now.year - birthday.year - (Date.new(now.year, birthday.month, birthday.day) > now ? 1 : 0)
end